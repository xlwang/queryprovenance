import click
import pdb
import csv
import time
import math
import random
import sys
import json
sys.path.append('..')

from datetime import *
from operator import mul
from itertools import *
from collections import *
from sqlalchemy import *

from synth.gen import truemain as genmain
from synth.datagen import truemain as datamain
from configgen import keys, qlogkeys

def init_db(db):
  """
  dataset tables should be named:
    table_<cid>_<clean|dirty|rollback>_idx
  """

  stmts = [
      """
      CREATE TABLE if not exists configs (
        id serial primary key,
        N_D int,
        N_dim int,
        N_q int,
        N_pred int,
        N_ins int,
        N_set int,
        N_where int,
        N_corrupt int,
        N_corrupt_vals int,
        N_corrupt_set int,
        N_corrupt_where int,
        idx float,
        p_I float,
        p_pk float,
        p_fp float,
        p_fn float,
        exptype int,
        passtype int,
        optchoice int,
        qfixtype int,
        epsilon float,
        M float,
        approx float,
        prune float,
        rollbackbatch int
      );
      """,
      """
      CREATE TABLE if not exists qlogs (
        id serial primary key,
        cid int references configs(id),
        qidx int,
        isclean bool,
        type varchar,
        vals text,
        set text,
        wherec text,
        query text
      )
      """,
      # stats go here
      """
      CREATE TABLE if not exists exps (
        id serial primary key,
        cid int references configs(id)
      )
      """
  ]

  try:
    for stmt in stmts:
      db.execute(stmt)
  except Exception as e:
    print e
    pass




def to_sql(q, tname):
  qtype = q.get("type")
  setc = q.get("set", [])
  wherec = q.get("where", [])
  valsc = q.get("vals", [])

  if qtype == "INSERT":
    qtext = "INSERT INTO %s VALUES(default, %s)" 
    qtext = qtext % (tname, ",".join(["%s"] * len(valsc)))
    qtext = qtext % tuple(map(str, valsc))
  else:
    qtext = "UPDATE %s SET %s WHERE %s"
    setclause = []
    for s in setc:
      col = s[0]
      expr = s[1]
      if isinstance(expr, list):
        expr = " ".join(map(str, expr))
      setclause.append("%s = %s" % (col, expr))
    whereclause = [" ".join(map(str, w)) for w in wherec]
    qtext = qtext % (tname, ", ".join(setclause), " AND ".join(whereclause))
  return qtext


def save_qlog(db, cid, tname, queries, isclean):
  for qidx, q in enumerate(queries):
    qtype = q.get("type")
    setc = q.get("set", [])
    wherec = q.get("where", [])
    valsc = q.get("vals", [])
    qtext = to_sql(q, tname)
    
    q = "INSERT INTO qlogs values(default, %s, %s, %s, %s, %s, %s, %s, %s)"
    db.execute(q, 
        cid, qidx, isclean, qtype, 
        json.dumps(valsc),
        json.dumps(setc),
        json.dumps(wherec),
        qtext
    )


def init_database_state(db, dburl, cid, config):
  tname = "synth_%d" % cid
  ntup = int(config[0])
  ndim = int(config[1])
  datamain(False, False, True, "/dev/null", dburl, tname, 0, ndim, ntup)
  return tname


def run_query(db, tname, newtname, q):
  sql = "CREATE TABLE %s AS (SELECT * FROM %s)" % (newtname, tname)
  db.execute(sql)
  sql = "SELECT count(*) FROM %s" % newtname
  minv = db.execute(sql).fetchone()[0]
  sql = "CREATE SEQUENCE %s_seq MINVALUE %d;" % (newtname, minv)
  db.execute(sql)
  sql = "ALTER TABLE %s ALTER id SET DEFAULT NEXTVAL('%s_seq');"
  sql = sql % (newtname, newtname)
  db.execute(sql)

  db.execute(to_sql(q, newtname))


def run_querylog(db, tname, queries, mode):
  """
  args:
    mode: "clean", "dirty", "rollback"
  """


  for qidx, q in enumerate(queries):
    if qidx == 0:
      old_tname = "%s_%s_%d" % (tname, mode, 0)
      sql = "CREATE TABLE %s AS (SELECT * FROM %s)"
      sql = sql % (old_tname, tname)
      db.execute(sql)

    new_tname = "%s_%s_%d" % (tname, mode, qidx+1)
    run_query(db, old_tname, new_tname, q)
    old_tname = new_tname


def save_config(db, dburl, config):

  # if config already exists, skip
  q = "SELECT id FROM configs WHERE %s"
  clauses = ["%s = %s" % pair for pair in zip(keys, config)]
  where = " AND ".join(clauses)
  q = q % where
  res = db.execute(q)
  rows = res.fetchall()
  if len(rows):
    cid = rows[0][0]
    return cid

  q = "INSERT INTO configs VALUES(default, %s) RETURNING id" % ",".join(["%s"]*len(config))
  res = db.execute(q, tuple(config))
  cid = res.fetchone()[0]
  
  #
  # Generate the queries
  #
  args = [config[keys.index(key)] for key in qlogkeys]
  for i in xrange(len(args) - 4, len(args)):
    args[i] = int(args[i])
  queries, corruptqueries = genmain(False, None, 0, *args)

  #
  # Generate the initial database state
  #
  tname = init_database_state(db, dburl, cid, config)

  #
  # save queries
  #
  save_qlog(db, cid, tname, queries, True)
  save_qlog(db, cid, tname, corruptqueries, False)


  #
  # Initialize and store every database state
  #
  tname = init_database_state(db, dburl, cid, config)
  run_querylog(db, tname, queries, "clean")
  run_querylog(db, tname, corruptqueries, "dirty")

  return cid

    





@click.command()
@click.option("--dburl", default=None)
@click.argument("configfname")
def main(dburl, configfname):
  """
  Given a file containing configurations generated by configgen.py
  populate database tables and set up the database states
  """
  if not dburl:
    return

  db = create_engine(dburl)
  init_db(db)

  with file(configfname) as f:
    for l in f:
      config = map(float, l.strip().split(","))
      print config
      cid = save_config(db, dburl, config)


if __name__ == "__main__":
  main()

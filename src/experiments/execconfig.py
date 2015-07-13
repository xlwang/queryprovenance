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

from synth.gen import truemain as genqlog
from synth.datagen import truemain as datamain
from configgen import keys, qlogkeys

def init_db(db):
  """
  dataset tables should be named:
    table_<cid>_<clean|dirty|rollback>_idx
  """

  stmts = [
      """
      CREATE TABLE if not exists plots (
        id serial primary key,
        name text,
        x text,
        y text,
        opts text
      );
      """,
      """
      CREATE TABLE if not exists configs (
        id serial primary key,
        pid int references plots(id),
        runidx int,
        notes text,
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
        gen_mode int,
        idx float,
        p_I float,
        p_pk float,
        p_fp float,
        p_fn float,
        exptype int,
        epsilon float,
        M float,
        solvertype int,
        batchsize int,
        niterations int,
        approx int,
        alg2_attrsize int,
        alg2_obj int,
        alg2_objratio int,
        alg2_fixq int,
        alg2_fixattr int
      );
      """,
      # mode: [clean, dirty, fixed]
      """
      CREATE TABLE if not exists qlogs (
        id serial primary key,
        cid int references configs(id),
        qidx int,
        oldtname text,
        newtname text,
        mode text,
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
        cid int references configs(id),
        iter int,
        nbadcomplaints int,
        nfixedcomplaints int,
        removerate numeric,
        noiserate numeric,
        prep_time numeric,
        solver_prep_time numeric,
        solve_time numeric,
        post_proc_time numeric,
        p_fp numeric,
        avgnconstraints int,
        avgnvariables int
      )
      """
  ]

  for stmt in stmts:
    try:
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
    qtext = "INSERT INTO %s VALUES(%s)" 
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



def save_query(db, cid, qidx, oldtname, newtname, q, mode):
  """
  mode: clean | dirty | fixed | rolledback
  """
  qtype = q.get("type")
  setc = q.get("set", [])
  wherec = q.get("where", [])
  valsc = q.get("vals", [])
  qtext = to_sql(q, oldtname)
  
  q = "INSERT INTO qlogs values(default, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
  db.execute(q, 
      cid, qidx, oldtname, newtname, mode, qtype, 
      json.dumps(valsc),
      json.dumps(setc),
      json.dumps(wherec),
      qtext
  )


def init_database_state(db, dburl, cid, config):
  tname = "synth_%d" % cid
  ntup = int(config["n_d"])
  ndim = int(config["n_dim"])
  datamain(False, False, True, "/dev/null", dburl, tname, cid, ndim, ntup)
  return tname

def clean_database_state(db, cid):
  tname = "synth_%d" % cid
  q = "SELECT tablename FROM pg_tables WHERE tablename like '%s_%%%%';" 
  q = q % tname
  rows = db.execute(q).fetchall()
  tnames = [row[0] for row in rows]
  for torm in tnames:
    q = "DROP TABLE IF EXISTS %s CASCADE;" % torm
    print q
    db.execute(q)
  return tnames




def run_query(db, tname, newtname, q):
  sql = "CREATE TABLE %s AS (SELECT * FROM %s)" % (newtname, tname)
  db.execute(sql)
  altersql = "ALTER TABLE %s ADD PRIMARY KEY (id)" % (newtname)
  # db.execute(altersql)
  sql = "SELECT count(*) FROM %s" % newtname
  minv = db.execute(sql).fetchone()[0]
  sql = "CREATE SEQUENCE %s_seq MINVALUE %d;" % (newtname, minv)
  db.execute(sql)
  sql = "ALTER TABLE %s ALTER id SET DEFAULT NEXTVAL('%s_seq');"
  sql = sql % (newtname, newtname)
  db.execute(sql)

  db.execute(to_sql(q, newtname))


def run_querylog(db, cid, tname, queries, mode):
  """
  args:
    mode: "clean", "dirty", "rollback", "fixed"
  """
  for qidx, q in enumerate(queries):
    try:
      # initialize first table in the sequence
      if qidx == 0:
        old_tname = "%s_%s_%d" % (tname, mode, 0)
        sql = "CREATE TABLE %s AS (SELECT * FROM %s)"
        sql = sql % (old_tname, tname)
        db.execute(sql)

      new_tname = "%s_%s_%d" % (tname, mode, qidx+1)
      run_query(db, old_tname, new_tname, q)
      save_query(db, cid, qidx, old_tname, new_tname, q, mode)
      old_tname = new_tname

      res = db.execute("SELECT id, count(*) FROM %s GROUP BY id HAVING count(*) > 1" % new_tname)
      assert len(res.fetchall()) == 0
    except Exception as e:
      print e
      pass
  print "created %d tables for %s" % (qidx, tname)


def sync_db(db, dburl):
  q = """SELECT id FROM configs WHERE 
     id not in (SELECT cid FROM qlogs)"""
  res = db.execute(q).fetchall()
  cids_to_sync = [row[0] for row in res]

  for cid in cids_to_sync:
    sync_cid(db, dburl, cid)

def sync_cid(db, dburl, cid):
  print "Sync %d" % cid

  q = "SELECT * FROM configs WHERE id = %s" % cid
  cur = db.execute(q)
  res = cur.fetchall()
  keys = cur.keys()
  if not res: return
  config = dict(zip(keys, res[0]))

  #
  # Generate the initial database state
  #
  tname = init_database_state(db, dburl, cid, config)
  print "init db %s" % tname

  #
  # Generate and save the queries
  #
  args = [config[key.lower()] for key in qlogkeys]
  for i in xrange(len(args) - 4, len(args)):
    args[i] = int(args[i])
  args.append(config['n_d'])
  args.append(config['gen_mode'])
  print args
  queries, corruptqueries = genqlog(False, None, cid, *args)
  print "qlog generated"

  #save_qlog(db, cid, tname, queries, True)
  #save_qlog(db, cid, tname, corruptqueries, False)


  #
  # Initialize and store every database state
  #
  run_querylog(db, cid, tname, queries, "clean")
  run_querylog(db, cid, tname, corruptqueries, "dirty")

  return cid

 

    





@click.command()
@click.option("--dburl", default="postgresql://localhost/queryprov")
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
      config = l.strip().split(",")
      print config
      name = config[0]
      config = config[1:]
      config = map(float, config)
      cid = save_config(db, dburl, name, config)


if __name__ == "__main__":
  main()

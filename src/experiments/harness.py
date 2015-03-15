import os
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
from sqlalchemy.sql import text


from configgen import keys as allkeys, DEFAULT
from execconfig import sync_db, init_db, sync_cid, clean_database_state


def parse_config(fname):
  with file(fname) as f:
    configs = parse_config_file(f)
    return configs

def tablevel(l):
  for idx, c in enumerate(l):
    if c != " ": 
      return idx
  return -1

def parse_config_file(f):
  tab = 0
  name = None
  config = None
  plot = None
  cur_dict = None
  state = None
  all_configs = {}
  for l in f:
    if l.strip().startswith("#"):
      continue 
    if not l.strip():
      continue

    tab = tablevel(l)
    l = l[tab:].strip()
    print " "*tab, l

    if tab == 0:
      name = l.strip()
      all_configs[name] = {}
    elif tab == 2:
      if l == "config":
        config = {}
        all_configs[name]["config"] = config
        state = "config"
      if l == "plot":
        plot = {}
        all_configs[name]["plot"] = plot
        state = "plot"
    elif tab == 4:
      optname, optvals = tuple(l.split(":"))
      optname = optname.strip()
      optvals = optvals.strip().split(",")
      optvals = [v.strip() for v in optvals]
      if state == "config":
        optvals = map(float, optvals)
        config[optname] = optvals
      else:
        plot[optname] = optvals

  return all_configs


def create_params(options, base_params={}, keys=None):
  """
  Given a dictionaly of parametrs and possible values,
  creates a list of the cross products of all parameter values
  returns a generator

  Example:
    options = { a: [1,2], b: [3,4] }

    yields: [ {a:1, b:3}, {a:1, b:4}, {a:2, b:3}, {a:2, b:4} ]
  """
  if keys is None:
    keys = options.keys()
  if len(keys) == 0:
    yield base_params
    return

  key = keys[0]
  vals = options[key]
  if not isinstance(vals, list):
    vals = [vals]

  for val in vals:
    param = dict(base_params)
    param[key] = val
    for param in create_params(options, param, keys[1:]):
      yield param


def save_plot(db, name, plot):
  x = json.dumps(plot["x"])
  y = json.dumps(plot["y"])
  opts = json.dumps(plot)
  
  with db.begin() as conn:
    q = "SELECT id FROM plots WHERE name=:name"
    cur = conn.execute(text(q), name=name)
    res = cur.fetchall()
    if res:
      pid = res[0][0]
      q = "UPDATE plots SET x=:x, y=:y, opts=:opts WHERE name=:name"
      conn.execute(text(q), name=name, x=x, y=y, opts=opts)
      print "updated plot %s" % name
      return pid

    q = "INSERT INTO plots VALUES(default, :name, :x, :y, :opts) RETURNING id;"
    cur = conn.execute(text(q), name=name, x=x, y=y, opts=opts)
    print "added plot %s" % name
    return cur.fetchone()[0]


def save_config(db, pid, runidx, name, config):
  # if config already exists, skip
  q = "SELECT id FROM configs WHERE pid = :pid AND runidx = :runidx"
  q = "SELECT id FROM configs WHERE pid = :pid AND runidx = :runidx AND %s"
  clauses = ["%s = %s" % pair for pair in config.items()]
  where = " AND ".join(clauses)
  q = q % where

  with db.begin() as conn:
    res = conn.execute(text(q), pid=pid, runidx=runidx)
    rows = res.fetchall()
    if len(rows):
      cid = rows[0][0]
      q = "UPDATE configs SET %s WHERE id = :cid"
      args = ", ".join(["%s = :%s" % (k.lower(), k) for k in allkeys])
      q = q % args
      conn.execute(text(q), cid=cid, **config)
      print "update config", cid, config["N_q"]
      return cid

    print "insert config"
    q = "INSERT INTO configs VALUES(default, %d, %d, '%s', %s) RETURNING id"
    q = q % (pid, runidx, name, ",".join(["%s"]*len(config)))
    res = conn.execute(q, tuple([config[k] for k in allkeys]))
    cid = res.fetchone()[0]
    return cid
  
def plot_pid(db, pid):
  q = "SELECT id, name, opts FROM plots WHERE id = %d" % pid
  res = db.execute(q).fetchall()
  if not res: return

  row = res[0]
  pid = row[0]
  name = row[1]
  opts = json.loads(row[2])
  for k in opts: opts[k] = [v.lower() for v in opts[k]]
  x = opts["x"][0]
  ys = opts["y"]
  fx = opts.get("fx", [None])[0] or "iter"
  fy = opts.get("fy", [None])[0]
  geom = opts.get("geom", ["line"])[0]
  group = opts.get("group", [])
  color = opts.get("color", [])

  print "plotting %s" % name

  for idx, y in enumerate(ys):
    if 'prep' in y:
      y = 'prep_time+solver_prep_time+solve_time'

    #
    # filter and aggregate the data
    #
    q = """
    SELECT avg(%s) as y, stddev(%s) as std, %s
    FROM exps as e, configs as c
    WHERE c.pid = %s AND c.id = e.cid
    GROUP BY %s
    """
    gb = [x]
    gb.extend([fx, fy])
    gb.extend(group)
    gb.extend(color)
    gb = filter(lambda v: v is not None, set(gb))
    q = q % (y, y, ", ".join(gb), pid, ", ".join(gb))

    outname = "%s_%s.pdf" % (name, idx)
    plot(outname, q, x, y, 
         geom=geom,
         fx=fx,
         fy=fy,
         group=", ".join(group),
         color=", ".join(color),
         ylabel=y)

def plot(name, query, x, y, 
         geom="line", 
         fx=None, 
         fy=None, 
         color=None,
         group=None, 
         xlabel=None,
         ylabel=None, 
         log=False):
  prog = """
    library(ggplot2)
    library(plyr)
    library(scales)
    library(RPostgreSQL)
    drv = dbDriver('PostgreSQL')
    con = dbConnect(drv, dbname='queryprov')

    q = "%s"
    data = dbGetQuery(con, q)
    data$ymin = data$y - data$std
    data$ymax = data$y + data$std
    %s
    %s
    ggsave("%s", p, scale=.7)
  """

  xform = ""

  aes = "aes(x=%s, y=y" % x
  if group:
    aes += ", group=group"
    xform += "\ndata = transform(data, group=paste0(%s))" % (group)
  if color:
    aes += ", color=color"
    xform += "\ndata = transform(data, color=paste0(%s))" % (color)
  aes += ", alpha=0.6)" 

  ggplot = "ggplot(data, %s)" % aes
  geom = "geom_%s() + geom_pointrange(aes(ymin=ymin, ymax=ymax, width=0.05))" % geom
  facet = None
  if fx or fy:
    if not fx:
      fx = "."
    if not fy:
      fy = "."
    facet = "facet_grid(%s~%s)" % (fx, fy)
  xscale = "scale_x_continuous(name='%s')" % x
  yscale = None
  if log:
    yscale = "scale_y_log10(name='%s')" % y
  else:
    yscale = "scale_y_continuous(name='%s')" % y

  arr = filter(bool, [ ggplot, geom, facet, xscale, yscale])

  plot = "p = %s" % " + ".join(arr)

  prog = prog % (query, xform, plot, name)

  with file("plot.r", "w") as f:
    f.write(prog)

  os.system("R -f plot.r")


def cmd_load(db, fname):
  for name, configs in  parse_config(fname).iteritems():
    print name
    plot = configs["plot"]
    pid = save_plot(db, name, plot)

    config = dict(DEFAULT)
    config.update(configs["config"])
    for runidx in xrange(int(plot["nruns"][0])):
      for conf in create_params(config):
        save_config(db, pid, runidx, name, conf)
        #print "\t",conf

def cmd_sync(db, dburl, pids):
  if pids:
    q = """SELECT id FROM configs 
    WHERE pid in (%s)""" % ",".join(map(str, pids))
    cids = [row[0] for row in db.execute(q).fetchall()]
    for cid in cids:
      sync_cid(db, dburl, cid)
  else:
    sync_db(db, dburl)

def cmd_plot(db, dburl, pids):
  if not pids:
    q = """SELECT pid, id FROM configs 
        WHERE id in (SELECT cid FROM exps) AND
              id in (SELECT cid FROM qlogs)
        ORDER BY pid, id;"""
    pids = sorted(set([row[0] for row in db.execute(q).fetchall()]))
    print pids

  for pid in pids:
    plot_pid(db, pid)

 
def cmd_list(db):
  q = """SELECT id, id in (SELECT pid FROM configs) , name
        FROM plots"""
  res = db.execute(q).fetchall()
  print "plotid\tsynced\tname"
  print "--------------------------------"
  for row in res:
    print "%d\t%s\t%s" % tuple(row)

def cmd_run(db, dburl, dryrun, pids):
  print "cmd_run", pids
  if not pids:
    q = """SELECT distinct id FROM
            (SELECT pid, id FROM configs 
            WHERE id not in (SELECT cid FROM exps) AND
                  id in (SELECT cid FROM qlogs)
            ORDER BY pid, id
            ) as foo ORDER BY id;"""
    cids = [row[0] for row in db.execute(q).fetchall()]
  else:
    q = """SELECT distinct id FROM configs WHERE pid in (%s) ORDER BY id"""
    q = q % ",".join(map(str, pids))
    cids = [row[0] for row in db.execute(q).fetchall()]


  print "exec cids: %s" % str(cids)
  for cid in cids:
    cmd = "cd ../../; sh run.sh SyntheticHarness dbconn.config %d; cd -"
    cmd = cmd % cid

    if dryrun:
      print cmd
    else:
      # ensure database has the tables
      sync_cid(db, dburl, cid)

      os.system(cmd)

      # clean up database
      print "clean dbstate %d" % cid
      clean_database_state(db, cid)



@click.command()
@click.option("--dburl", default="postgresql://localhost/queryprov")
@click.option("--fname", default=None, help="file containing experiment configurations")
@click.option("--dryrun", is_flag=True, help="flag for actually running experiments")
@click.argument("cmd")
@click.argument("ids", nargs=-1, type=int)
def main(dburl, fname, dryrun, cmd, ids):
  """
  CMD: sync | load | plot | run | list

  ids: the plot ids to execute
  """
  db = create_engine(dburl)
  init_db(db)

  if cmd.lower() == "load":
    cmd_load(db, fname)
  elif cmd.lower() == "sync":
    cmd_sync(db, dburl, ids)
  elif cmd.lower() == "plot":
    cmd_plot(db, dburl, ids)
  elif cmd.lower() == "list":
    cmd_list(db)
  elif cmd.lower() == "run":
    cmd_run(db, dburl, dryrun, ids)

if __name__ == "__main__":
  main()

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

from execconfig import sync_db, init_db, sync_cid, clean_database_state


inf = float('inf')


def extractset(jsonstr):
  return dict([(v[0], v[-1]) for v in json.loads(jsonstr)])
  return [v[-1] for v in json.loads(jsonstr)]

def extractwhere(jsonstr):
  arr = map(tuple, json.loads(jsonstr))
  ret = defaultdict(lambda: [-inf, inf])
  for var, op, val in arr:
    if op == "=":
      ret[var] = [val, val]
    if op == ">=":
      ret[var][0] = val
    if op == "<":
      ret[var][1] = val
  return ret

def count_tuples(db, tname, cwhere, fvar, cb, fb):
  preds = "%s >= %f and %s < %f"  
  where = []
  for var, b in cwhere.items():
    if var == fvar: continue
    where.append(preds % (var, b[0], var, b[1]))

  lb = (fb[0], min(cb[0], fb[1]))
  ub = (cb[1], max(cb[1], fb[0]))

  fwhere = []
  if lb[0] <= lb[1]:
    fwhere.append(preds % (fvar, lb[0], fvar, lb[1]))
  if ub[0] <= ub[1]:
    fwhere.append(preds % (fvar, ub[0], fvar, ub[1]))
  fwhere = "(%s)" % (" OR ".join(fwhere))
  where.append(fwhere)


  q = """
    SELECT COUNT(*) 
    FROM %s 
    WHERE 1=1 and %s""" 
  q = q % (tname, " AND ".join(where))
  n =  db.execute(q).fetchone()[0]
  return n


def compare_qlogs(db, cid):
  
  cq = "SELECT * FROM qlogs WHERE mode = 'clean'"
  fq = "SELECT * FROM qlogs WHERE mode = 'fixed'"
  dq = "SELECT * FROM qlogs WHERE mode = 'dirty'"
  q  = """
        SELECT cq.qidx, 
               cq.type,
               cq.oldtname as tname,
               cq.vals as cvals,
               cq.set as cset,
               cq.wherec as cwhere, 
               cq.query as cquery,
               fq.vals as fvals,
               fq.set as fset,
               fq.wherec as fwhere, 
               fq.query as fquery
        FROM (%s) as cq, (%s) as fq
        WHERE cq.cid = %d and
              fq.cid = %d and
              cq.qidx = fq.qidx and
              cq.query <> fq.query
        ORDER BY cq.qidx
        """
  q = q % (cq, fq, cid, cid)
  rows = db.execute(q).fetchall()
  for row in rows:
    setd, whered = compare_queries(db, *row)
    if setd:
      print "S", cid, row[0], str(setd)
    if whered:
      print "W", cid, row[0], str(whered)



def compare_queries(db, 
                    qidx, 
                    qtype,
                    tname,
                    cvals, 
                    cset, 
                    cwhere, 
                    cquery,
                    fvals, 
                    fset, 
                    fwhere, 
                    fquery):
  if qtype == "UPDATE":
    cset = extractset(cset)
    fset = extractset(fset)
    cwhere = extractwhere(cwhere)
    fwhere = extractwhere(fwhere)

    setdiffs = {}
    for var in cset.keys():
      cv, fv = cset[var], fset[var]
      diff = ((fv - cv)) / (cv + 1.)
      if diff > 0:
        setdiffs[var] = diff


    wherediffs = {}
    for var in chain(cwhere.keys(), fwhere.keys()):
      assert var in cwhere and var in fwhere, "%s not found" % var
      cb = cwhere[var]
      fb = fwhere[var]
      inter = (min(cb[1], fb[1]) - max(cb[0], fb[0]))
      inter = max(inter, 0)
      union = max(cb[1], fb[1]) - min(cb[0], fb[0])
      if inter == union:
        continue

      # is cb inside fb?
      cinf = fb[0] <= cb[0] and cb[1] <= fb[1]
      # is fb inside cb?
      finc = cb[0] <= fb[0] and fb[1] <= cb[1]

      jaccard = float(inter) / float(union)

      # any tuples in non-intersectng portions?
      ntuples = count_tuples(db, tname, cwhere, var, cb, fb)

      wherediffs[var] = (cinf, finc, ntuples, jaccard, cb, fb)

    return setdiffs, wherediffs















db = create_engine("postgresql:///queryprov")


cids = [row[0] for row in db.execute("SELECT distinct cid FROM qlogs").fetchall()]
for cid in cids:
  sync_cid(db, "postgresql:///queryprov", cid)
  compare_qlogs(db, cid)
  clean_database_state(db, cid)



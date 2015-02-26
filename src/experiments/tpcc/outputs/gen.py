from collections import *
from elastictabstops import *
import json
import csv
import re
import click
import random
import numpy as np

qmark = re.compile("\?")
def nextval(minv=0, maxv=100):
  return random.randint(minv, maxv)

def randrng(n):
  l = range(n)
  random.shuffle(l)
  return l

clone = lambda query: json.loads(json.dumps(query))
STATS = {
  "C_ID":  (2,3000)  , 
  "C_D_ID":         (1          ,10        ),
  "C_YTD_PAYMENT":  (21.51      ,17097.17  ),
  "C_PAYMENT_CNT":  (2.0        ,6.0       ),
  "C_W_ID":         (1          ,2         ),
  "C_BALANCE":      (-17097.17  ,10489.21  )
}



def gen_params(attrs):
  vals = []
  for attr in attrs:
    if attr == "C_DATA":
      vals.append("x" * 446)
    else:
      minv, maxv = STATS[attr]
      if isinstance(minv, float):
        vals.append(random.random() * (maxv-minv) + minv)
      else:
        vals.append(nextval(*STATS[attr]))
  return vals


 
def gen_updateCustomer(args):
  balance, cid, cdid, cwid = tuple(args)
  balance = float(balance)
  cid, cdid, cwid = int(cid), int(cdid), int(cwid)

  SET = [ ("C_BALANCE", "C_BALANCE + {0}".format(balance) ) ]
  SET = [ ("C_BALANCE", ("C_BALANCE", "+", balance)) ]
  WHERE = [ ("C_ID", "=", cid), ("C_D_ID", "=", cdid), ("C_W_ID", "=", cwid) ]
  return {
    "type": "UPDATE",
    "set": SET, 
    "where": WHERE
  }


def gen_updateBCCustomer(args):
  """
  SET C_BALANCE = ?, C_YTD_PAYMENT = ?, C_PAYMENT_CNT = ?, C_DATA = ? 
  WHERE C_W_ID = ? AND C_D_ID = ? AND C_ID = ?
  """
  bal, ytd, pay, data, wid, did, cid = tuple(args)
  bal, ytd, pay = tuple(map(float, [bal, ytd, pay]))
  wid, did, cid = tuple(map(int, [wid, did, cid]))

  SET = [
    ("C_BALANCE", bal), 
    ("C_YTD_PAYMENT", ytd), 
    ("C_PAYMENT_CNT", pay),
    ("C_DATA", data)
  ]
  WHERE = [
    ("C_W_ID", "=", wid),
    ("C_D_ID", "=", did),
    ("C_ID", "=", cid)
  ]
  return {
    "type": "UPDATE",
    "set": SET, 
    "where": WHERE
  }


def gen_updateGCCustomer(args):
  """
  SET C_BALANCE = ?, C_YTD_PAYMENT = ?, C_PAYMENT_CNT = ? 
  WHERE C_W_ID = ? AND C_D_ID = ? AND C_ID = ?
  """
  bal, ytd, pay, wid, did, cid = tuple(args)
  bal, ytd, pay = tuple(map(float, (bal, ytd, pay)))
  wid, did, cid = tuple(map(int,   (wid, did, cid)))
  SET = [
    ("C_BALANCE", bal), 
    ("C_YTD_PAYMENT", ytd), 
    ("C_PAYMENT_CNT", pay)
  ]
  WHERE = [
    ("C_W_ID", "=", wid),
    ("C_D_ID", "=", did),
    ("C_ID", "=", cid)
  ]
  return {
    "type": "UPDATE",
    "set": SET,
    "where": WHERE
  }



def corrupt(q, nv, nw, ns):
  q = clone(q)

  if q["type"] == "UPDATE":
    q['trueset'] = clone(q["set"])
    q['truewhere'] = clone(q["where"])
    wheres = q["where"]
    for idx in randrng(len(wheres))[:nw]:
      attr = wheres[idx][0]
      wheres[idx][2] = nextval(*STATS[attr])
  return q 



@click.command()
@click.option('--bprint', is_flag=True)
@click.argument("ncorrupt", default=1)
@click.argument("insertcorrupt", default=1)
@click.argument("setcorrupt", default=1)
@click.argument("wherecorrupt", default=1)
def main(bprint, ncorrupt, insertcorrupt, setcorrupt, wherecorrupt):
  """
  Loads the TPCC customers table workload, transforms them into JSON query data structures, and 
  optionally corrupts a random subset of the log.

  Arguments

    ncorrupt:       # of queries to corrupt\n
    insertcorrupt:  # of attrs in INSERT query to corrupt\n
    setcorrupt:     # of attrs in SET clause of UPDATE query to corrupt\n
    wherecorrupt:   # of attrs in WHERE clause of UPDATE query to corrupt\n

  """
  query_funcs = {
    "updateCustomer": gen_updateCustomer,
    "updateBCCustomer": gen_updateBCCustomer,
    "updateGCCustomer": gen_updateGCCustomer
  }
  customerattrs = ("C_BALANCE", "C_ID","C_D_ID", "C_W_ID")
  bccustomerattrs =   ("C_BALANCE", "C_YTD_PAYMENT", "C_PAYMENT_CNT", "C_DATA", "C_W_ID", "C_D_ID", "C_ID")
  gccustomerattrs = ("C_BALANCE", "C_YTD_PAYMENT", "C_PAYMENT_CNT", "C_W_ID", "C_D_ID", "C_ID")




  queries = []
  with file("./customer_params") as f:
    for l in f:
      vals = l.strip().split(",")[1:]
      qtype = vals[0]
      if qtype not in query_funcs: continue
      f = query_funcs[qtype]
      q = f(vals[1:])
      q["table"] = "CUSTOMER"
      queries.append(q)
  corruptedqueries = list(queries)

  for idx in randrng(len(queries))[:ncorrupt]:
    corruptedqueries[idx] = corrupt(
        corruptedqueries[idx], insertcorrupt, setcorrupt, wherecorrupt)

  if bprint:
    for q in corruptedqueries:
      print q

  #print gen_updateGCCustomer(gen_params(gccustomerattrs))
  return corruptedqueries



if __name__ == "__main__":
  main()




  exit()
  
  stats = defaultdict(list)
  for q in qs:
    for s in q['set']:
      stats[s[0]].append(s[1])
    for w in q['where']:
      stats[w[0]].append(w[2])

  num_stats = [["attr", "min", "max", "mean"]]
  for k, l in stats.items():
    if isinstance(l[0], basestring): continue
    num_stats.append(map(str, [k, min(l), max(l), np.mean(l)]))
  print Table(num_stats).to_spaces()
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




###########################
#
#  exptype:
#    1: synthetic
#    2: tpcc
#  passtype:
#    1: one pass solution
#    2: rollback only
#    3: query fix only
#    4: 2 pass solution
#  optchoice:
#    1: no preprocssing
#    2: preprocessing
#  qfixtype:
#    1: cplex
#    2: decision tree
#  approx: if cplex is infeasible
#    true/false
#  prune: prune false positives w/ density
#    true/false
#
############################

DEFAULT = {
    "N_D": 100, 
    "N_dim": 4, 
    "N_q": 10, 
    "N_pred": 4, 
    "N_ins": 2,
    "N_set": 2,
    "N_where": 2, 
    "N_corrupt": 1,
    "N_corrupt_vals": 1,
    "N_corrupt_set": 1,
    "N_corrupt_where": 1,
    "idx": .9, 
    "p_I": .33, 
    "p_pk": .5, 
    "p_fp": 0, 
    "p_fn": 0,
    "exptype": 1,
    "passtype": 1, 
    "optchoice": 1 , 
    "qfixtype": 1,
    "epsilon": 0.0001, 
    "M": 1000000, 
    "approx": False, 
    "prune": False,
    "rollbackbatch": 1
}

keys = [
  "N_D", "N_dim", "N_q", "N_pred", "N_ins", "N_set", "N_where", 
  "N_corrupt", "N_corrupt_vals", "N_corrupt_set", "N_corrupt_where",
  "idx", 
  "p_I", "p_pk", "p_fp", "p_fn",
  "exptype", "passtype", "optchoice", "qfixtype",
  "epsilon", "M", "approx", "prune", "rollbackbatch"
]

qlogkeys = [
  "N_dim",  "N_set", "N_where", "N_where", "N_q",
  "p_I", "p_pk",
  "N_corrupt", "N_corrupt_vals", "N_corrupt_set", "N_corrupt_where"
]


def all_options_to_generator(all_options):
  for options in all_options:
    for param in create_params(options, {}):
      d = dict(DEFAULT)
      d.update(param)
      param_vals = map(lambda k: float(d[k]), keys)
      yield param_vals



def gen_exact_config():
  all_options = [
    {
      "N_D": [10, 100, 1000],
      "N_q": [5, 10, 20],
      "N_pred": [1,2],
      "N_where": [2],
      "idx": [.8],
      "exptype": 1
    },
    {
      "N_D": 1000,
      "N_q": 20,
      "N_pred": 2,
      "N_where": [1, 2],
      "idx": 0.8,
      "exptype": 1
    },
    {
      "N_D": 1000,
      "N_q": 20,
      "N_pred": 2,
      "N_where": 2,
      "idx": [0.2, 05, 0.8, 0.9],
      "exptype": 1
    }
  ]

  return all_options


def gen_rollback_config():
  all_options = [
    {
      "N_D": [1000],
      "N_q": [20],
      "N_pred": [2],
      "N_where": [2],
      "idx": [.8],
      "exptype": 1,
      "passtype": 2,
      "rollbackbatch": [1, 2, 5]
    }
  ]

  return all_options


def gen_qfix_config():
  all_options = [
    {
      "N_D": [1000],
      "N_q": [1],
      "N_pred": [2],
      "N_where": [2],
      "idx": [.8],
      "exptype": 1,
      "passtype": 3,
      "qfixtype": [1, 2]
    }
  ]

  return all_options

def gen_endtoend_config():
  all_options = [
    {
      "N_D": [1000],
      "N_q": [1],
      "N_pred": [2],
      "N_where": [2],
      "idx": [.8],
      "exptype": 1,
      "passtype": 4,
      "qfixtype": 1
    }
  ]
  return all_options

def gen_noise_config():
  all_options = [
    {
      "N_D": [1000],
      "N_q": [1],
      "N_pred": [2],
      "N_where": [2],
      "idx": [.8],
      "exptype": 1,
      "passtype": 4,
      "qfixtype": 1,
      "p_fp": [0, 01, 02, 05], 
      "p_fn": 0
    },
    {
      "N_D": [1000],
      "N_q": [1],
      "N_pred": [2],
      "N_where": [2],
      "idx": [.8],
      "exptype": 1,
      "passtype": 4,
      "qfixtype": 1,
      "p_fp": 0,
      "p_fn": [0, 01, 02, 05], 
    }
  ]

  return all_options



@click.command()
@click.option("--out", default=None)
@click.argument("exptypes", type=click.Choice(["all", "exact", "rollback", "qfix", "endtoend", "noise", "tpcc"]), nargs=-1)
def main(out, exptypes):
  if out is None:
    out = sys.stdout
  else:
    out = file(out, "w")

  funcs = set()
  for exptype in exptypes:
    if exptype == "exact" or exptype == "all":
      funcs.add(gen_exact_config)
    if exptype == "rollback" or exptype == "all":
      funcs.add(gen_rollback_config)
    if exptype == "qfix" or exptype == "all":
      funcs.add(gen_qfix_config)
    if exptype == "endtoend" or exptype == "all":
      funcs.add(gen_endtoend_config)
    if exptype == "noise" or exptype == "all":
      funcs.add(gen_noise_config)

  for f in funcs:
    configs = all_options_to_generator(f())
    for config in configs:
      print>>out, ",".join(map(str, config))

  try:
    if out is not sys.stdout:
      out.close()
  except:
    pass

if __name__ == "__main__":
  main()
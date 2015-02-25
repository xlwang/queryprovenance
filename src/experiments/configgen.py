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
    "N_attrs": 2, 
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
    "prune": False
}

keys = [
  "N_D", "N_dim", "N_q", "N_pred", "N_attrs", "idx", 
  "p_I", "p_pk", "p_fp", "p_fn",
  "exptype", "passtype", "optchoice", "qfixtype",
  "epsilon", "M", "approx", "prune"
]

def gen_exact_config():
  options = {
    "N_D": [10, 100, 1000],
    "N_q": [5, 10, 20],
    "N_pred": [1,2],
    "N_attrs": [1,2],
    "idx": [0.2, .8],
    "exptype": 1
  }
  for param in create_params(options, {}):
    d = dict(DEFAULT)
    d.update(param)
    param_vals = map(lambda k: d[k], keys)
    print ",".join(map(str, param_vals))




@click.command()
@click.argument("exptype", type=click.Choice(["exact", "rollback", "qfix", "endtoend", "noise", "tpcc"]))
def main(exptype):
  if exptype == "exact":
    gen_exact_config()

if __name__ == "__main__":
  main()
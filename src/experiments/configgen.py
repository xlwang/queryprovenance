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
#  gen_mode:  (see synth/gen.py)
#    1: fixed
#    2: pseudo
#    3: random
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
    "gen_mode": 1,
    "idx": .9, 
    "p_I": .33, 
    "p_pk": .5, 
    "p_fp": 0, 
    "p_fn": 0,
    "exptype": 1,
    "epsilon": 0.001, 
    "M": 1000000,
    "solvertype": 0,
    "batchsize": 1,
    "niterations": 1,     # for multi-iteration algorithm to deal with false-negatives 
    "approx": 0, 
    "alg2_attrsize": 1,
    "alg2_obj": 0,
    "alg2_objratio": 10,
    "alg2_fixq": 0,
    "alg2_fixattr": 0
}

keys = [
  "N_D", "N_dim", "N_q", "N_pred", "N_ins", "N_set", "N_where", 
  "N_corrupt", "N_corrupt_vals", "N_corrupt_set", "N_corrupt_where",
  "gen_mode", "idx", 
  "p_I", "p_pk", "p_fp", "p_fn",
  "exptype", "epsilon", "M", "solvertype", 
  "batchsize", "niterations", "approx", 
  "alg2_attrsize", "alg2_obj", "alg2_objratio", 
  "alg2_fixq", "alg2_fixattr"
]

# params used to generate synthetic query log
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


ALL_OPTIONS = {
  "exact": [
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
  ],

  "iter": [
    {
      "N_D": [10, 100, 1000, 10000, 50000, 100000],
      "N_q": [5, 10, 20, 50, 100],
      "N_pred": [1,2,3],
      "N_where": [2],
      "idx": [.8],
      "exptype": 1,
      "niterations": 2
    },
    {
      "N_D": [50000],
      "N_q": [200, 300, 500],
      "N_pred": 2,
      "N_where": 2,
      "idx": .8,
      "exptype": 1,
      "niterations": 2
    },
     {
      "N_D": 50000,
      "N_q": 100,
      "N_pred": 3,
      "N_where": [1, 2, 3],
      "idx": 0.8,
      "exptype": 1,
      "niterations": 2
    },
    {
      "N_D": 50000,
      "N_q": 100,
      "N_pred": 2,
      "N_where": 2,
      "idx": [0.2, 05, 0.8, 0.9],
      "exptype": 1,
      "niterations": 2
    },
    {
      "N_D": 50000,
      "N_q": 100,
      "N_pred": 2,
      "N_where": 2,
      "idx": [.8],
      "exptype": 1,
      "niterations": [1,2,3]
    }

  ],

  "rollback": [
    {
      "N_D": [1000],
      "N_q": [20],
      "N_pred": [2],
      "N_where": [2],
      "idx": [.8],
      "exptype": 1,
    }
  ],
  "qfix": [
    {
      "N_D": [1000],
      "N_q": [1],
      "N_pred": [2],
      "N_where": [2],
      "idx": [.8],
      "exptype": 1,
    }
  ],
  "endtoend": [
    {
      "N_D": [1000],
      "N_q": [1],
      "N_pred": [2],
      "N_where": [2],
      "idx": [.8],
      "exptype": 1,
    }
  ],
  "noise": [
    {
      "N_D": [1000],
      "N_q": [1],
      "N_pred": [2],
      "N_where": [2],
      "idx": [.8],
      "exptype": 1,
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
      "p_fp": 0,
      "p_fn": [0, 01, 02, 05], 
    }
  ]
}


@click.command()
@click.option("--out", default=None)
@click.argument("exptypes", type=click.Choice(["all"] + ALL_OPTIONS.keys()), nargs=-1)
def main(out, exptypes):
  """
  exptypes describes the experiment type to generate parameters for.
  It can be one of the following:
  
    exact
    iter
    rollback
    qfix
    endtoend
    noise
    tpcc
    all

  """
  if out is None:
    out = sys.stdout
  else:
    out = file(out, "w")

  for optname, options in ALL_OPTIONS.items():
    if "all" in exptypes or optname in exptypes:
      configs = all_options_to_generator(options)
      for config in configs:
        print>>out, "%s,%s" % (optname, ",".join(map(str, config)))

  try:
    if out is not sys.stdout:
      out.close()
  except:
    pass

if __name__ == "__main__":
  main()
from collections import *
import json
from pygg import *
from wuutils import *
import numpy as np
import random 

random.seed(0)

maxval = 100
rand = lambda: random.randint(0, maxval)

def randzipf():
  v = maxval + 1
  while v >= maxval:
    v = np.random.zipf(1+skew)
  return v

runs = dict(run=[], x=[])
ninrange = []
rangesize = 1
skew = 0

def compare(l1, l2):
  return (l1 != l2).sum()

def randquery():
  r = random.randint(0, maxval-rangesize)
  r = randzipf()
  newv = rand()
  def f(dataset):
    dataset[np.logical_and(dataset >= r, dataset < r+rangesize)] = newv
    return dataset
  f.r = r
  f.isin = lambda v: v >= r and v < r+rangesize
  return f

def corrupt(queries, idx):
  ret = list(queries)
  newv = rand()
  r = ret[idx].r
  def f(dataset):
    dataset[np.logical_and(dataset >= r, dataset < r+rangesize)] = newv
    return dataset
  ret[idx] = f
  return ret

def makequerylog(nqueries):
  return [randquery() for i in xrange(nqueries)]

def execute(dataset, queries):
  dataset = dataset.copy()
  for q in queries:
    dataset = q(dataset)
  return dataset

def randdataset(ntuples):
  return np.array([rand() for i in xrange(ntuples)])


def compute_corruptions():
  try:
    with file("cache.json") as f:
      toplot = json.load(f)
      return toplot
  except:
    pass

  toplot = []

  for skeww in [0.00001, .5, 1, 3, 5]:
    skew = skeww
    for rsize in [1, 2, 5, 20]:
      rangesize = rsize
      for run in xrange(5):
        dataset = randdataset(200)
        querylog = makequerylog(1000)

        cleanresults = execute(dataset, querylog)

        for idx in xrange(len(querylog)):
          if idx % 5 != 0: continue
          for i in xrange(2):
            cquerylog = corrupt(querylog, idx)
            badresults = execute(dataset, cquerylog)
            ncomplaints = compare(cleanresults, badresults)
            toplot.append(dict(ncomplaints=ncomplaints, qidx = idx, rsize=rsize, skew=skew, run="%s-%s" % (run, i)))
        print "run %d done" % run

  with file("cache.json", "w") as f:
    f.write(json.dumps(toplot))
  return toplot

if True:
  toplot = compute_corruptions()
  toplot = [d for d in toplot if d['ncomplaints'] > 0 and d['skew'] != 3]
  p = ggplot(toplot, aes(x='qidx', y='ncomplaints')) + geom_point(alpha=0.4, size=1.5)
  p += facet_grid("skew~rsize")
  p += legend_bottom
  p += axis_labels("Corrupted Query Index", "Complaint Set Size", xkwargs=dict(breaks=[250, 500, 750], lim=[0, 1000]), ykwargs=dict(breaks=[50, 100, 150]))
  ggsave("qidx_v_ncomplaints.png", p, width=8, height=6, libs=['grid'], scale=0.7)

if True:

  try:
    with file("datacache.json") as f:
      tmp = json.load(f)
      data = tmp['data']
      nums = tmp['nums']
  except:
    data = []
    nums = []
    for skeww in [0.00001, .5, 1, 3]:
      skew = skeww
      for rsize in [1, 2, 5, 20]:
        rangesize = rsize

        for run in xrange(10):

          dataset = randdataset(200)
          querylog = makequerylog(1000)
          dataset = execute(dataset, querylog)
          c = Counter(dataset)
          for v, count in c.items():
            if count == 0: continue 
            data.append(dict(
              x=v,
              y=count,
              skew=skew,
              rsize=rsize,
              run=run
            ))


        for i in xrange(50):
          q = randquery()
          nrange = len([d for d in data if q.isin(d['x'])])
          if nrange:
            nums.append(dict(x=nrange, run=run, skew=skew, rsize=rsize))


    with file("datacache.json", "w") as f:
      f.write(json.dumps(dict(data=data, nums=nums)))



  data = [d for d in data if d['skew'] != 3]
  p = ggplot(data, aes(x='x', y='y'))#, group='run', color='as.character(run)')) 
  #p += geom_density(aes(y="..density.."))
  p += geom_point(alpha=0.6, size=1.5)
  p += scale_color_discrete()
  p = p + facet_grid("skew~rsize") 
  p += axis_labels("Attribute Value", "Complaint Set Size", xkwargs=dict(breaks=[25, 50, 75], lim=[0, 105]), ykwargs=dict(breaks=[50, 100, 150]))
  p += legend_bottom
  ggsave('datadist.png', p, width=8, height=4, libs=["grid"], scale=0.7)

  nums = [d for d in nums if d['skew'] != 3]
  p = ggplot(nums, aes(x='x'))
  p += geom_density(aes(y="..scaled.."))
  p += facet_grid("skew~rsize") 
  p += axis_labels("# Tuples in Range", "Percentage", xkwargs=dict(breaks=[25, 50, 75], lim=[0, 105]), ykwargs=dict(breaks=[.25, .5, .75]))
  p += legend_bottom
  ggsave('numinrange.png', p, width=8, height=4, libs=["grid"], scale=0.7)

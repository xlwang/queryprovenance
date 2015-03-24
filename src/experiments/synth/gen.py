import sys
import json
import random
import click
random.seed(0)

def nextval(minv=0, maxv=100):
  return random.randint(minv, maxv)

def randrng(n):
  l = range(int(n))
  random.shuffle(l)
  return l

clone = lambda query: json.loads(json.dumps(query))

def gen_where_eq(attrs):
  return [ (attr, "=", nextval()) for attr in attrs ]

def gen_where_rng(attrs):
  WHERE = []
  for attr in attrs:
    val = nextval(0, 90)
    WHERE.append((attr, ">=", val))
    WHERE.append((attr, "<", val+10))
  return WHERE

def gen_set(attrs):
  SET = [ (attr, nextval()) for attr in attrs ]
  return SET



def gen_update_eq(setattrs, whereattrs):
  UPDATE = "UPDATE T SET %s WHERE %s;"
  return {
    "type": "UPDATE",
    "set": gen_set(setattrs),
    "where": gen_where_eq(whereattrs)
  }

def gen_update_rng(setattrs, whereattrs):
  UPDATE = "UPDATE T SET %s WHERE %s;"
  return {
    "type": "UPDATE",
    "set": gen_set(setattrs),
    "where": gen_where_rng(whereattrs)
  }

def gen_delete_eq(attrs):
  return {
    "type": "DELETE",
    "where": gen_where_eq(attrs)
  }

def gen_delete_rng(attrs):
  return {
    "type": "DELETE",
    "where": gen_where_rng(attrs)
} 

def gen_insert(id, nattrs):
  return {
    "type": "INSERT",
    "vals": [id] + [nextval() for i in xrange(int(nattrs))]
  }

def gen_create(nattrs):
  return {
    "type": "CREATE",
    "attrs": map("a{0}".format, range(int(nattrs)))
  }

def corrupt(query, nvcorrupt, nwcorrupt=0, nscorrupt=0):
  """
  @return corrupted copy of the query
  nvcorrupt: number of values in INSERT to corrupt
  nwcorrupt: number of attributes in where clause to corrupt
  nscorrupt: number of parts of SET clause to corrupt
  """
  query = clone(query)
  if query["type"] == "INSERT":
    query['trueval'] = clone(query['vals'])
    idxs = range(1, len(query["vals"]))
    random.shuffle(idxs)
    for idx in idxs[:nvcorrupt]:
      query["vals"][idx] = nextval()

  elif query["type"] == "UPDATE":
    query['trueset'] = clone(query["set"])
    query['truewhere'] = clone(query["where"])
    sets = query["set"]
    clauses = query["where"]

    for idx in randrng(len(sets))[:nscorrupt]:
      sets[idx][1] = nextval()

    if clauses:
      if clauses[0][1] != "=":
        for idx in randrng(len(clauses)/2)[:nwcorrupt]:
          v = nextval(0, 90)
          clauses[idx*2][2] = v
          clauses[idx*2+1][2] = v+10
      else:
        for idx in randrng(len(clauses))[:nwcorrupt]:
          v = nextval()
          clauses[idx][2] = v

  return query



def gen_templates(nattrs, 
                  nset, 
                  nwhereeq, 
                  nwhererng, 
                  nqueries,
                  iperc=0.33, 
                  uperc=0.5, 
                  init_tuple_id=0,
                  gen_mode="fixed"):
  """
  iperc: percentage of inserts
  uperc: of the updates, percentage of equality updates
  gen_mode: fixed:  pick attributes for SET and WHERE clauses, use them for every Q
            pseudo: partition attrs for SET & WHERE.  Randomly pick within
                    partition for each query
            random: randomly pick attrs for each query
  """

  nqueries = int(nqueries)
  nset = int(nset)
  nwhererng = int(nwhererng)
  nwhereeq = int(nwhereeq)
  create = gen_create(nattrs)

  setattrs = list(create['attrs'])
  whereeqattrs = list(create['attrs'])
  whererngattrs = list(create['attrs'])

  # tuple id of max(id) in generated table
  tup_id = init_tuple_id

  # attrs in SET and WHERE may overlap, but they are fixed
  # Randomize once
  if gen_mode == "fixed":
    random.shuffle(setattrs)
    setattrs = setattrs[:nset]
    random.shuffle(whereeqattrs)
    whereeqattrs = whereeqattrs[:nwhereeq]
    random.shuffle(whererngattrs)
    whererngattrs = whererngattrs[:nwhererng]

    for i in xrange(nqueries):
      if random.random() <= iperc:
        yield clone(gen_insert(tup_id, nattrs))
        tup_id += 1
      elif random.random() <= uperc:
        yield clone(gen_update_eq(setattrs, whereeqattrs))
      else:
        yield clone(gen_update_rng(setattrs, whererngattrs))

    return

  # attrs are randomized, and may not ovelap
  # Do this by partitioning attributes into SET only attributes and
  # WHERE only attributes
  elif gen_mode == "pseudo":
    if nattrs < nset + max(nwhererng, nwhereeq):
      raise Exception("nattrs < nsetattrs + nwhereattrs! %d < %d + %d" % (
        nset, max(nwhererng, nwhereeq)
      ))

    randidx = random.randint(0, nattrs - (nset + max(nwhererng, nwhereeq)))
    setattrs = setattrs[:nset+randidx]
    whereeqattrs = whereeqattrs[nset+randidx:]
    whererngattrs = whererngattrs[nset+randidx:]

  elif gen_mode != "random":
    raise Exception("Unrecognized gen_mode %s" % gen_mode)

  for i in xrange(nqueries):
    if random.random() <= iperc:
      yield clone(gen_insert(tup_id, nattrs))
      tup_id += 1
    elif random.random() <= uperc:
      random.shuffle(setattrs)
      random.shuffle(whereeqattrs)
      yield clone(gen_update_eq(setattrs[:nset], whereeqattrs[:nwhereeq]))
    else:
      random.shuffle(setattrs)
      random.shuffle(whererngattrs)
      yield clone(gen_update_rng(setattrs[:nset], whererngattrs[:nwhererng]))


@click.command()
@click.option('--bprint', is_flag=True)
@click.option("--out", default=None, help="output file name/path")
@click.option('--seed', default=0, help="Seed to set the random number generator.")
@click.option('--inittupid', default=0, help="Initial tuple ID for insert queries.")
@click.option('--mode', default="fixed", help="How to randomize attrs in SET and WHERE clauses.")
@click.argument('nattrs', default=4)      
@click.argument('nset', default=1)        
@click.argument('nwhereeq', default=1)    
@click.argument('nwhererng', default=1)   
@click.argument('nqueries', default=10)   
@click.argument('insertperc', default=0.33)
@click.argument('equalityperc', default=0.5)
@click.argument('ncorrupt', default=1)
@click.argument('insertcorrupt', default=1)
@click.argument('setcorrupt', default=1)
@click.argument('wherecorrupt', default=1)
def main(
    bprint, out, seed, inittupid, mode,
    nattrs, nset, nwhereeq, nwhererng, nqueries, insertperc, equalityperc,
    ncorrupt, insertcorrupt, setcorrupt, wherecorrupt
    ):
  """
  Generates and corrupts a query log containing inserts and updates.

  Differentiate INSERTS, point UPDATES, and range UPDATES

  Arguments

    nattrs:         # non-primary key attrs in table\n
    nset:           # of attrs in the SET clauses\n
    nwhereeq:       # attrs in WHERE clause of point update queries\n
    nwhererng:      # attrs in WHERE clause of range update queries\n
    nqueries:       # queries to generate\n
    insertperc:     Percentage of INSERT queries\n
    equalityperc:   Of the UPDATE queries, percentage of point updates\n
    ncorrupt:       # of queries to corrupt\n
    insertcorrupt:  # of attrs in INSERT query to corrupt\n
    setcorrupt:     # of attrs in SET clause of UPDATE query to corrupt\n
    wherecorrupt:   # of attrs in WHERE clause of UPDATE query to corrupt\n

  """

  truemain(
    bprint, out, seed,
    nattrs, nset, nwhereeq, nwhererng, nqueries, insertperc, equalityperc,
    ncorrupt, insertcorrupt, setcorrupt, wherecorrupt,
    inittupid, mode
  )

def truemain(
    bprint, out, seed,
    nattrs, nset, nwhereeq, nwhererng, nqueries, insertperc, equalityperc,
    ncorrupt, insertcorrupt, setcorrupt, wherecorrupt,
    init_tuple_id=0, mode="fixed"
    ):

  random.seed(seed)
  if out is None:
    out = sys.stdout
  else:
    out = file(out, "w")


  # fix mode in case its passed numerically
  if mode == 1:
    mode = "fixed"
  elif mode == 2:
    mode = "pseudo"
  elif mode == 3:
    mode = "random"


  queries = [q for q in gen_templates(nattrs, 
                                      nset, 
                                      nwhereeq, 
                                      nwhererng, 
                                      nqueries, 
                                      insertperc, 
                                      equalityperc, 
                                      init_tuple_id,
                                      mode)]
  corruptedqueries = list(queries)

  for idx in randrng(nqueries)[:ncorrupt]:
    corruptedqueries[idx] = corrupt(
        corruptedqueries[idx], insertcorrupt, setcorrupt, wherecorrupt)

  if bprint:
    for q in corruptedqueries:
      print>>out, q

  return queries, corruptedqueries


if __name__ == '__main__':
  main()
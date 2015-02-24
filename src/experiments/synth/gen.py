import json
import random
import click
random.seed(0)

def nextval(minv=0, maxv=100):
  return random.randint(minv, maxv)

def randrng(n):
  l = range(n)
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

def gen_insert(nattrs):
  return {
    "type": "INSERT",
    "vals": [nextval() for i in xrange(nattrs)]
  }

def gen_create(nattrs):
  return {
    "type": "CREATE",
    "attrs": map("a{0}".format, range(nattrs))
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
    idxs = range(len(query["vals"]))
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



def gen_templates(nattrs, nset, nwhereeq, nwhererng, nqueries, iperc=0.33, uperc=0.5):
  """
  iperc: percentage of inserts
  uperc: of the updates, percentage of equality updates
  """
  create = gen_create(nattrs)
  setattrs = list(create['attrs'])
  random.shuffle(setattrs)
  setattrs = setattrs[:nset]
  whereeqattrs = list(create['attrs'])
  random.shuffle(whereeqattrs)
  whereeqattrs = whereeqattrs[:nwhereeq]
  whererngattrs = list(create['attrs'])
  random.shuffle(whererngattrs)
  whererngattrs = whererngattrs[:nwhererng]


  for i in xrange(nqueries):
    if random.random() <= iperc:
      yield clone(gen_insert(nattrs))
    elif random.random() <= uperc:
      yield clone(gen_update_eq(setattrs, whereeqattrs))
    else:
      yield clone(gen_update_rng(setattrs, whererngattrs))
  return

  CREATE = "CREATE TABLE T (id int serial, %s);"
  INSERT = "INSERT INTO T VALUES(default, %s);"
  UPDATE = "UPDATE T SET %s WHERE %s;"
  DELETE = "DELETE FROM T WHERE %s;"


@click.command()
@click.option('--bprint', is_flag=True)
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
    bprint,
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
  queries = [q for q in gen_templates(
    nattrs, nset, nwhereeq, nwhererng, nqueries, insertperc, equalityperc)]
  corruptedqueries = list(queries)

  for idx in randrng(nqueries)[:ncorrupt]:
    corruptedqueries[idx] = corrupt(
        corruptedqueries[idx], insertcorrupt, setcorrupt, wherecorrupt)

  if bprint:
    for q in corruptedqueries:
      print q

  return corruptedqueries


if __name__ == '__main__':
  main()
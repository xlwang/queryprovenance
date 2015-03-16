import sys
import json
import random
import click
from sqlalchemy import *
random.seed(0)

def nextval(minv=0, maxv=100):
  return random.randint(minv, maxv)

@click.command()
@click.option("--ddl", is_flag=True, help="print CREATE TABLE statement")
@click.option("--schema", is_flag=True, help="Print table attributes in first line")
@click.option("--data", is_flag=True, help="Print the data")
@click.option("--out", default=None, help="output file name/path")
@click.option("--dburl", default=None, help="db url if create table.  table option req.")
@click.option("--table", default=None, help="table name to load data")
@click.option("--seed", default=0, help="Seed to set random number generator")
@click.argument('nattrs', default=4)      
@click.argument('ntuples', default=10)        
def main(ddl, schema, data, out, dburl, table, seed, nattrs, ntuples):
  truemain(ddl, schema, data, out, dburl, table, seed, nattrs, ntuples)


def truemain(ddl, schema, data, out, dburl, table, seed, nattrs, ntuples):
  """
  Data generator for Logavulin
  """
  random.seed(seed)
  if dburl:
    db = create_engine(dburl)
    if not table:
      raise RuntimeError

  attrs = map("a{0}".format, range(int(nattrs)))

  if out is None:
    out = sys.stdout
  else:
    out = file(out, "w")

  if ddl or dburl:
    sql = "CREATE TABLE %s(id int primary key, %s);" 
    sql = sql % (table, ", ".join(map("{0} int".format, attrs)))
    if dburl:
      db.execute("DROP TABLE IF EXISTS %s" % table)
      db.execute(sql)
    if ddl:
      print>>out, sql


  if schema:
    print>>out, "id,%s" % ",".join(attrs)

  if data:
    tuples = []
    for i in xrange(ntuples):
      vals = [i - 1] + map(nextval, xrange(nattrs))
      tuples.append(vals)


    for t in tuples:
      print>>out, ",".join(map(str, t))

    if dburl:
      sql = "INSERT INTO %s(id, %s) VALUES %s"
      datastr = ["(%s)" % ",".join(map(str, t)) for t in tuples]
      sql = sql % (table, ",".join(attrs), ", ".join(datastr))
      db.execute(sql)

  try:
    if out != sys.stdout:
      out.close()
  except:
    pass


if __name__ == '__main__':
  main()

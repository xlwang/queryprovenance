import json
import random
import click
random.seed(0)

def nextval(minv=0, maxv=100):
  return random.randint(minv, maxv)

@click.command()
@click.option("--ddl", is_flag=True, help="print CREATE TABLE statement")
@click.option("--schema", is_flag=True, help="print table attributes in first line")
@click.argument('nattrs', default=4)      
@click.argument('ntuples', default=10)        
def main(ddl, schema, nattrs, ntuples):
  """
  """
  attrs = map("a{0}".format, range(nattrs))

  if ddl:
    sql = "CREATE TABLE T(id int serial primary key, %s);"
    sql = sql % ", ".join(map("{0} int".format, attrs))
    print sql


  if schema:
    print "id,%s" % ",".join(attrs)

  tuples = []
  for i in xrange(ntuples):
    vals = [i] + map(nextval, xrange(nattrs))
    tuples.append(vals)


  for t in tuples:
    print ",".join(map(str, t))



if __name__ == '__main__':
  main()

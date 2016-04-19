"""
Columbia W4111 Intro to databases
Example webserver
To run locally
    python server.py
Go to http://localhost:8111 in your browser
A debugger such as "pdb" may be helpful for debugging.
Read about it online.
eugene wu 2015
"""

import os
import json
from sqlalchemy import *
from sqlalchemy.pool import NullPool
from flask import Flask, request, render_template, g, redirect, Response, jsonify

tmpl_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')
app = Flask(__name__, template_folder=tmpl_dir)


DATABASEURI = "postgresql://localhost:5432/queryprov"
engine = create_engine(DATABASEURI)

@app.before_request
def before_request():
  try:
    g.conn = engine.connect()
  except:
    print "uh oh, problem connecting to database"
    import traceback; traceback.print_exc()
    g.conn = None

@app.teardown_request
def teardown_request(exception):
  try:
    g.conn.close()
  except Exception as e:
    pass


@app.route('/workload/', methods=["POST", "GET"])
def workload():
  workload = request.args.get('workload', 'default')
  return jsonify(**get_workload(workload))


def get_workload(workload='default'):
  if workload == 'default':
    queries = [
        "UPDATE salary \nSET tax = 0.3*income \nWHERE income > 87500",
        "UPDATE salary \nSET pay = income - tax",
        "INSERT INTO salary \nVALUES (4, 21625, 86500, 64875)"
    ]
    ncols = 5
    nrows = 10
    queries = [ dict(query=q, id=i) for i, q in enumerate(queries)]
    header = [ "header-%s" % i  for i in xrange(ncols) ]
    rows = [
        dict(
          data=["v-%s" % j for j in xrange(ncols)],
          iscomplaint=(i == 5)
        )
        for i in xrange(nrows)
    ]
    table = dict(
        header=header,
        rows=rows
    )

  return dict(queries=queries, table=table)




@app.route('/', methods=["POST", "GET"])
def index():
  """
  request is a special object that Flask provides to access web request information:
  request.method:   "GET" or "POST"
  request.form:     if the browser submitted a form, this contains the data in the form
  request.args:     dictionary of URL arguments e.g., {a:1, b:2} for http://localhost?a=1&b=2
  See its API: http://flask.pocoo.org/docs/0.10/api/#incoming-request-data
  """
  print request.args
  workload = request.args.get('workload', 'default')

  workload = get_workload(workload)

  context = dict()
  context.update(workload)

  return render_template("index.html", **context)

@app.route('/complaints/')
def complaints():
  qid = request.args['qid']
  wid = request.args['workload']
  q = request.args['query']

  data = {}

  return json.dumps(data)



@app.route('/solve/')
def solve():
  q = "UPDATE blah\nSET x=99"
  qfix_q = "UPDATE blah\nSET x=y+1"
  alt_q = "UPDATE blah\nSET x=y+10"
  data = dict(
      query=q,
      qfix_query = qfix_q,
      alt_query = alt_q,
      table1 = get_workload()['table'],
      table2 = get_workload()['table']
  )

  return jsonify(**data)


if __name__ == "__main__":
  import click

  @click.command()
  @click.option('--debug', is_flag=True)
  @click.option('--threaded', is_flag=True)
  @click.argument('HOST', default='0.0.0.0')
  @click.argument('PORT', default=8111, type=int)
  def run(debug, threaded, host, port):
    """
    This function handles command line parameters.
    Run the server using
        python server.py
    Show the help text using
        python server.py --help
    """

    HOST, PORT = host, port
    print "running on %s:%d" % (HOST, PORT)
    app.run(host=HOST, port=PORT, debug=debug, threaded=threaded)

  run()

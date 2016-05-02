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

import os, random
import json
from sqlalchemy import *
from sqlalchemy.pool import NullPool
from flask import Flask, request, render_template, g, redirect, Response, jsonify
from subprocess import call

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


@app.route('/workloads/', methods=["POST", "GET"])
def workloads():
  workloads = [ 'default', 'TPC-C', 'TATP', 'Synthetic' ]
  workloads = [dict(id=i, workload=w) for i,w in enumerate(workloads)]
  return jsonify(workloads=workloads)

@app.route('/corrupt/', methods = ["POST", "GET"])
def corrupt():
    workload = request.args.get('workload', 'default')
    # get parameters
    expid = request.args.get('exp_id', 0)    
    queryid = request.args.get('query', 0)
    querylogsize = int(request.args.get('qlogsize', 0))
    mode = request.args.get('mode', 'corrupt')

    # corrupt query: call java function 
    
    corrupt_query = """select query from qlogs where expid = %d and mode = 'dirty' and qid = %d""" 
    db_query_dirty = ""
    db_query_clean = ""

    primary_key = []
    if workload == 'default':
        primary_key = set(["employer_id"])
        db_query_dirty = """select * from %s_dirty_%d order by employer_id"""
        db_query_clean = """select * from %s_clean_%d order by employer_id"""
        db_query_dirty = db_query_dirty % ('taxes', querylogsize)
        db_query_clean = db_query_clean % ('taxes', querylogsize)
        corrupt_query = """select query from qlogs where expid = %d and mode = 'dirty' and qid = %d""" % (0, int(queryid))
        print "default"
    elif workload == 'TPC-C':
        print "corrupt tpcc"
    elif workload == 'TATP':
        print "corrupt tatp"
    else:
        call(["java", "-jar", "synthetic.jar", "5432", "dbconn.config", "-exp", expid, "-option", "2", "-qidx", queryid])
        primary_key = set(["id"])
        db_query_dirty = """select * from %s_dirty_%d order by id"""
        db_query_clean = """select * from %s_clean_%d order by id"""
        db_query_dirty = db_query_dirty % ('synthetic', querylogsize-1)
        db_query_clean = db_query_clean % ('synthetic', querylogsize-1)
        corrupt_query = """select query from qlogs where expid = %d and mode = 'dirty' and qid = %d""" % (int(expid), int(queryid))
        print db_query_dirty
        print corrupt_query
        
    # load queries
    header_and_query = g.conn.execute(corrupt_query)
    raw_query = [dict(zip(header_and_query.keys(), list(row))) for row in header_and_query]

    query = []
    for i, q in enumerate(raw_query):
        query = q['query']
        
    # load data
    header_and_data_clean = g.conn.execute(db_query_clean)
    header_and_data_dirty = g.conn.execute(db_query_dirty)

    header = []
    for i, attrname in enumerate(header_and_data_clean.keys()):
        header.append(str(attrname))
   
    raw_data_clean = [dict(zip(header_and_data_clean.keys(), list(row))) for row in header_and_data_clean]

    clean_rows = {}
    for i, d in enumerate(raw_data_clean):
        data = []
        row_key = ""
        for attrname in header:
            if attrname in primary_key:
                row_key = row_key + "\t" + str(d[attrname])
            data.append(dict(clean = str(d[attrname]), iscorrect = True, dirty = ""))
        clean_rows[row_key] = dict(data = data, iscomplaint = False, id = i, indirty = False)

    rows = []
    raw_data_dirty = [dict(zip(header_and_data_dirty.keys(), list(row))) for row in header_and_data_dirty]
    for i, d in enumerate(raw_data_dirty):
        data = []
        row_key = ""
        for attrname in header:
            if attrname in primary_key:
                row_key = row_key + "\t" + str(d[attrname])
            data.append(dict(clean = str(d[attrname]), iscorrect = True, dirty = ""))
    
        # compare data and data clean
        iscomplaint = False
        if row_key in clean_rows:
            data_clean = clean_rows[row_key]

            for j in range(len(data_clean['data'])):
                if data_clean['data'][j]['clean'] != data[j]['clean']:
                    data[j]['dirty'] = data[j]['clean']
                    data[j]['clean'] = data_clean['data'][j]['clean']
                    data[j]['iscorrect']= False
                    iscomplaint = True
            data_clean['indirty'] = True
            clean_rows[row_key] = data_clean
        else:
            # data not exist
            for j in len(data):
                data[j]['dirty'] = data[j]['clean']
                data[j]['clean'] = "NULL"
                data[j]['iscorrect'] = False
            iscomplaint = True
        rows.append(dict(data = data, iscomplaint = iscomplaint, id = row_key))

    # check clean data
    for key in clean_rows:
        data_clean = clean_rows[key]
        if data_clean['indirty'] == False:
            data = []
            for i in len(data_clean['data']):
                data.append(dict(clean = data_clean['data'][i]['clean'], iscorrect = False, dirty = "NULL"))   
            rows.append(dict(data = data, iscomplaint = True, id = key))

    table = dict(
        header=header,
        rows=rows
    )
    return jsonify(dirtyquery=query, table = table)

@app.route('/workload/', methods=["POST", "GET"])
def workload(): 
  workload = request.args.get('workload', 'default')
  querylogsize = request.args.get('querylogsize', 10)
  expid = request.args.get('exp_id', 0)
  return jsonify(**get_workload(workload, int(querylogsize), expid, 'clean', ''))


def get_workload(workload='default', querylogsize = 10, expid = 0, mode = 'clean', algorithm = ''):
  db_query = ""
  queries_query = """select query, correct from qlogs where expid = %d and mode = '%s' and algorithm = '%s' order by qid limit %d"""
  primary_key = []
  
  if workload == 'default':
    expid = 0        
    # define to database and query 
    db_query = """select * from taxes_%s_%d"""
    queries_query = queries_query % (int(expid), mode, algorithm, int(querylogsize))
    primary_key = set(["employer_id"])
    
  elif workload == 'TPC-C':
      # load tpcc
      print('load tpcc data')
  elif workload == 'TATP':
      # load tatp
      print('load tatp data')
  else:
      # generate data
      if mode == 'clean' and algorithm == '':
          call(["java", "-jar", "synthetic.jar", "5432", "dbconn.config", "-exp", expid, "-option", "0"])
          call(["java", "-jar", "synthetic.jar", "5432", "dbconn.config", "-exp", expid, "-option", "1", "-qsize", str(querylogsize)])
          # load synthetic
          configquery = """insert into qfixconfig values (%d, '', 'qfix;alt', '%s')""" % (int(expid), "synthetic")
          g.conn.execute(configquery)
      
      db_query = """select * from synthetic_%s_%d order by id"""
      queries_query = queries_query % (int(expid), mode, algorithm, int(querylogsize))
      primary_key = set(["id"])
      
  # load queries
  print queries_query
  header_and_query = g.conn.execute(queries_query)
  raw_query = [dict(zip(header_and_query.keys(), list(row))) for row in header_and_query]
  queries = []
  for i, q in enumerate(raw_query):
      query=q['query']
      queries.append(dict(query = str(query), corrupted=(q['correct'] == 0), dirtyquery = ""))
  queries = [ dict(query=q, id=i) for i, q in enumerate(queries[0:len(queries)])]
  
  # load table data
  header = []
  rows = []
  if len(queries) > 0:
      db_query = db_query % (mode, len(queries) - 1)
      print db_query
      header_and_data = g.conn.execute(db_query)
  

      for i, attrname in enumerate(header_and_data.keys()):
          header.append(str(attrname))
       
      raw_data = [dict(zip(header_and_data.keys(), list(row))) for row in header_and_data]
  
      for i, d in enumerate(raw_data):
          data = []
          row_key = ""
          for attrname in header:
              if attrname in primary_key:
                  row_key = row_key + "\t" + str(d[attrname])
              data.append(dict(clean = str(d[attrname]), iscorrect = True, dirty = ""))
          rows.append(dict(data = data, iscomplaint = False, id = row_key))
      
  table = dict(
      header=header,
      rows=rows
  )     
  return dict(queries=queries, table=table)

@app.route('/updatecomplaint/', methods=["POST", "GET"])
def updatecomplaint(): 
  expid = request.args.get('exp_id', 0)
  row_keys = request.args.get('row_keys', '')
  add_or_remove = request.args.get('addorremove', '1')
  
  row_keys = row_keys.replace('row-', '').strip()
  # get current compl_list
  compl_list = ""
  if row_keys == "selectall":
      if add_or_remove != '0':
          compl_list = "selectall"
  elif row_keys == "selectallcompl":
      if add_or_remove != '0':
          compl_list = "selectallcompl"
  else:
      complquery = """select compl_list from qfixconfig where expid = %d""" % int(expid)
      header_and_data = g.conn.execute(complquery)
      raw_data = [dict(zip(header_and_data.keys(), list(row))) for row in header_and_data]
      
      cur_compl = raw_data[0]['compl_list'].split(';')
      if add_or_remove == '1':
          compl_list = raw_data[0]['compl_list'] + row_keys + ";"
      else:
          for compl in cur_compl:
              if compl != row_keys and len(str(compl)) > 0:
                  compl_list = compl_list + compl + ";"
  update_query = """update qfixconfig set compl_list ='%s' where expid = %d""" % (compl_list, int(expid))
  g.conn.execute(update_query)
  return jsonify(update = "")


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

@app.route('/checksolve/')
def check():
  
  expid = request.args.get('exp_id', 0)   
  # test only
  complquery = """select compl_list from qfixconfig where expid = %d""" % int(expid)
  header_and_data = g.conn.execute(complquery)
  raw_data = [dict(zip(header_and_data.keys(), list(row))) for row in header_and_data]
  print raw_data
  cur_compl = raw_data[0]['compl_list'].split(';')
  print cur_compl
  num_compl = 0
  for compl in cur_compl:
      if len(compl) > 0:
          num_compl = num_compl + 1
  return  jsonify(valid = (num_compl > 0))


@app.route('/solve/')
def solve():
  workload = request.args.get('workload', 'default')
  querylogsize = request.args.get('querylogsize', 10)
  expid = request.args.get('exp_id', 0)
  
  call(["java", "-Djava.library.path=/Users/xlwang/Applications/IBM/ILOG/CPLEX_Studio126/cplex/bin/x86-64_osx", "-jar", "queryfix.jar", "5432", "dbconn.config", expid])
  
  # get qfix result
  query_and_data = get_workload(workload, int(querylogsize)-1, expid, 'fixed', 'qfix')
  
  qfix_q = dict(queries = query_and_data['queries'])
  table1 = query_and_data['table']
  
  query_and_data2 = get_workload(workload, int(querylogsize)-1, expid, 'fixed', 'alt')
  
  alt_q = dict(queries = query_and_data2['queries'])
  table2 = query_and_data2['table']
  
  data = dict(
      qfix_query = qfix_q,
      alt_query = alt_q,
      table1 = table1,
      table2 = table2
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
    # initialize db
    call(["dropdb", "queryprov"])
    call(["createdb", "queryprov"])
    call(["psql","-f", "syntheticsetup.sql", "queryprov"])
      
    HOST, PORT = host, port
    print "running on %s:%d" % (HOST, PORT)
    app.run(host=HOST, port=PORT, debug=debug, threaded=threaded)

  run()
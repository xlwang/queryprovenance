from sqlalchemy import *
from pygg import *
from wuutils import *



def create_group_on(dbname):
  def group_on(groups, where_str="1 = 1"):
    arr = []
    for p in groups:
      if isinstance(p, basestring): 
        p = [p, p]
      elif len(p) == 1:
        p = [p[0], p[0]]
      arr.append(p)
    selstr = ", ".join(["%s as %s" % (p[0], p[1]) for p in arr])
    gbstr = ",".join([p[0] for p in arr])
    q = """select 
          %s
          avg(configs.num_compl) as ncomplaints,
          avg(fixed_rate) as fixed_rate, 
          avg(noise_rate) as noise_rate ,
          avg(fixed_rate*configs.num_compl/(fixed_rate*configs.num_compl + num_fixed_compl)) as precision,
          avg(avg_num_cons) as num_cons,
          stddev(fixed_rate*configs.num_compl/(fixed_rate*configs.num_compl + num_fixed_compl)) as precisionstd,
          avg(fixed_rate*configs.num_compl/(configs.num_compl)) as Recall,
          avg(preproc_time + solver_prep_cons_time) as prep_time,
          avg(solver_add_cons_time) as add_time, 
          avg(solver_solve_time) as cplex_time, 
          avg(finish_time) as finish_time,
          avg(preproc_time + solver_prep_cons_time + solver_add_cons_time + 
              solver_solve_time + finish_time) as total_time
    from names, exps join configs on exps.pid = configs.pid
    where names.sname = solver2 and %s
    group by   %s
    order by %s"""
    if selstr:
      selstr = "%s, " % selstr
    if gbstr:
      gbstr = gbstr
    q = q % (selstr, where_str, gbstr, gbstr)
    q = " ".join(q.split("\n"))

    print q
    eng = create_engine("postgresql:///%s" % dbname)
    db = eng.connect()
    cur = db.execute(q)
    keys = cur.keys()
    data = [dict(zip(keys, list(row))) for row in cur]
    db.close()
    for d in data:
      try:
        d['Precision'] = d['precision']
        d['Recall'] = d['recall']
      except Exception as e:
        print e
      try:
        d['F1'] = 2* (d['Precision'] * d['Recall']) / (d['Precision'] + d['Recall'])
      except Exception as e:
        print e

    return data
  return group_on



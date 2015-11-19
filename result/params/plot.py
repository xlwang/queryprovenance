from pygg import *
from wuutils import *

#  opt_query_num (for query-based optimization): number of candidate queries, without optimization, this number should equals to the logsize; 
#  opt_attr_num (for attr. based optimization): how many attributes included in constructing the cplex problem. 
#  opt_approx: 
#    0: cplex_stopearly_0_1 (cplex with attr opt.)
#    1: cplex_stopearly_1_1 (cplex with query opt.)
#    2: cplex_stopearly_1_1 (cplex with both opt.)
#    3: cplex_stopearly_0_0 (cplex with none opt.)
#    4: cplex_stopearly_1_1 (single attr.) 

def plot(name, p, **kwargs):
  p += scale_color_discrete()
  #p += scale_x_continuous()
  #p += facet_grid("name~logsize+rsize")
  p += geom_point(alpha=1, size=1.5)
  p += legend_bottom
  if 'libs' not in kwargs:
    kwargs['libs'] = []
  kwargs['libs'].append("grid")
  kwargs.update(dict(
    width=8,
    height=5
  ))
  ggsave(name, p, **kwargs)



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
  q = """select name,
         %s
         avg(configs.num_compl) as ncomplaints,
         avg(fixed_rate) as fixed_rate, 
         avg(noise_rate) as noise_rate ,
         avg(preproc_time + solver_prep_cons_time) as prep_time,
         avg(solver_add_cons_time) as add_time, 
         avg(solver_solve_time) as cplex_time, 
         avg(preproc_time + solver_prep_cons_time + solver_add_cons_time + solver_solve_time + finish_time) as total_time
  from names, exps join configs on exps.pid = configs.pid
  where names.sname = solver and opt_approx <> 4 and %s
  group by name %s"""
  if selstr:
    selstr = "%s, " % selstr
  if gbstr:
    gbstr = ", " + gbstr
  q = q % (selstr, where_str, gbstr)
  q = " ".join(q.split("\n"))
  return data_sql("queryprovparams", q)


data = group_on(['logsize'])
p = ggplot('data', aes(x='logsize', y='total_time', group='name', fill="name", color='name', linetype='name'))
#p += geom_point(size=2)
p += geom_bar(stat=esc("identity"), position=esc("dodge"))
p += legend_bottom
p += scale_color_discrete()
p += axis_labels("Query Log Size", "Total Time", "continuous", "continuous")
ggsave("qsize_time_badscale.png", p, data=data, libs=['grid'], width=6, height=4, scale=0.7)

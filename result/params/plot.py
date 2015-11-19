from pygg import *
from wuutils import *


# compute a group by using groups
# groups: list of pairs [ (group_by_expr, alias_name), ...]
# where_str: string for the where clause
#
# I created a table names(sname, name) where sname is the solver value e.g., "cplex_allqueries", and name is the full name e.g., "All Queries"
#
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
p += scale_color_discrete()

# add axis labels x is continuous, y is log10 scale
p += axis_labels("Query Log Size", "Total Time", "continuous", "log10")

# make it pretty
p += legend_bottom
ggsave("qsize_time_badscale.png", p, data=data, libs=['grid'], width=6, height=4, scale=0.7)

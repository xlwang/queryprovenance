from sqlalchemy import *
from pygg import *
from wuutils import *
import sys
sys.path.append("..")
from util import *


group_on = create_group_on("queryprov")



# skewness
if 1:
  where = """
  logsize = 300 and db_size = 1000 and wheresize=1 and corrupt_qidx in (49, 199, 149, 299)
  and opt_approx in (0,1,2,3) and skewness <= 1 and max_num_compl > 20
  """
  data = group_on([('name', 'name'), 'skewness', ('301 - (logsize - corrupt_qidx)', 'corrupt_qidx')], 
            where)

  p = ggplot(data, aes(x='skewness', y='prep_time+add_time', color='name', shape='name', linetype='name'))
  p += geom_point(size=2) + geom_line(size=.6)
  p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)")
  p += scale_color_discrete()
  p += axis_labels("# Tuples in DB (log)", "Prep + add Time (sec)", "continuous", "continuous", 
      xkwargs=dict(breaks=[100, 1000, 10000], labels=map(esc, ['100', '1k', '10k'])))
  p += legend_bottom
  p += guides(col = guide_legend(nrow = 2))
  ggsave("skew_preptime.png", p, libs=['grid'], width=6, height=4, scale=0.7)


  p = ggplot(data, aes(x='skewness', y='total_time', color='name', shape='name', linetype='name'))
  p += geom_point(size=2) + geom_line(size=.6)
  p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)")
  p += scale_color_discrete()
  p += axis_labels("Skew", "Time (sec)", "continuous", "continuous", 
      xkwargs=dict(breaks=[.25,  .75]))
  p += legend_bottom
  p += guides(col = guide_legend(nrow = 1))
  ggsave("skew_time.png", p, libs=['grid'], width=6, height=3, scale=0.7)


  #data = fold(data, ['Precision', 'Recall', "F1"])
  #data = fold(data, [ "F1"])
  p = ggplot(data, aes(x='skewness', y='F1', color='name', shape='name', linetype='name'))
  p += geom_point(size=2) + geom_line(size=.6)
  p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)") 
  p += scale_color_discrete()
  p += axis_labels("Skew", "F1", "continuous", "continuous", 
      ykwargs=dict(lim=[.5,1], breaks=[.6, .8]),
      xkwargs=dict(breaks=[.25, .75]))
  p += legend_bottom
  p += guides(col = guide_legend(nrow = 1))
  ggsave("skew_acc.png", p, libs=['grid'], width=6, height=3, scale=0.7)

  
if 1:
  where = """
  logsize = 300 and skewness = 1 and range = 8 and wheresize=1 and corrupt_qidx in (49, 199, 149)
  and opt_approx in (0,1,2,3)  and max_num_compl > 20
  """
  data = group_on([('name', 'name'), ('db_size', 'dbsize'), ('301 - (logsize - corrupt_qidx)', 'corrupt_qidx')], 
            where)



  if 0:
    p = ggplot(data, aes(x='dbsize', y='num_cons', color='name', shape='name', linetype='name'))
    p += geom_point(size=2) + geom_line(size=.6)
    p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)")
    p += scale_color_discrete()
    p += axis_labels("# Tuples in DB (log)", "# constrainst", "log10", "continuous", 
        xkwargs=dict(breaks=[100, 1000, 10000], labels=map(esc, ['10', '1k', '10k'])))
    p += legend_bottom
    p += guides(col = guide_legend(nrow = 2))
    ggsave("dbsize_nconstraints.png", p, libs=['grid'], width=6, height=4, scale=0.7)


    p = ggplot(data, aes(x='dbsize', y='prep_time+add_time', color='name', shape='name', linetype='name'))
    p += geom_point(size=2) + geom_line(size=.6)
    p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)")
    p += scale_color_discrete()
    p += axis_labels("# Tuples in DB (log)", "Prep + add Time (sec)", "log10", "continuous", 
        xkwargs=dict(breaks=[100, 1000, 10000], labels=map(esc, ['100', '1k', '10k'])))
    p += legend_bottom
    p += guides(col = guide_legend(nrow = 2))
    ggsave("dbsize_preptime.png", p, libs=['grid'], width=6, height=4, scale=0.7)

    p = ggplot(data, aes(x='dbsize', y='cplex_time+finish_time', color='name', shape='name', linetype='name'))
    p += geom_point(size=2) + geom_line(size=.6)
    p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)")
    p += scale_color_discrete()
    p += axis_labels("# Tuples in DB (log)", "CPlext + finish Time (sec)", "log10", "continuous", 
        xkwargs=dict(breaks=[100, 1000, 10000], labels=map(esc, ['100', '1k', '10k'])))
    p += legend_bottom
    p += guides(col = guide_legend(nrow = 2))
    ggsave("dbsize_solvetime.png", p, libs=['grid'], width=6, height=4, scale=0.7)


  p = ggplot(data, aes(x='dbsize', y='total_time', color='name', shape='name', linetype='name'))
  p += geom_point(size=2) + geom_line(size=.6)
  p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)") 
  p += scale_color_discrete()
  p += axis_labels("# Tuples in DB (log)", "Time (sec)", "log10", "continuous", 
      xkwargs=dict(breaks=[100, 1000, 10000], labels=map(esc, ['100', '1k', '10k'])))
  p += legend_bottom
  p += guides(col = guide_legend(nrow = 1))
  ggsave("dbsize_time.png", p, libs=['grid'], width=6, height=4, scale=0.7)



  #data = fold(data, ['Precision', 'Recall', "F1"])
  #data = fold(data, [ "F1"])
  p = ggplot(data, aes(x='dbsize', y='F1', color='name', shape='name', linetype='name'))
  p += geom_point(size=2) + geom_line(size=.6)
  p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)") 
  p += scale_color_discrete()
  p += axis_labels("# Tuples in DB (log)", "F1", "log10", "continuous", 
      ykwargs=dict(lim=[.5,1], breaks=[.6, .8]),
      xkwargs=dict(breaks=[100, 1000, 10000], labels=map(esc, ['100', '1k', '10k'])))
  p += legend_bottom
  p += guides(col = guide_legend(nrow = 1))
  ggsave("dbsize_acc.png", p, libs=['grid'], width=6, height=4, scale=0.7)





if True:
  # Scale 3 WHERE 
  where = """
  logsize = 300 and skewness = 1 and range = 8 and db_size=1000 and corrupt_qidx in (49, 199, 149)
  and opt_approx in (0,1,2,3)  and max_num_compl > 20
  """
  data = group_on(
      [('name', 'name'), ('wheresize'), ('301 - (logsize - corrupt_qidx)', 'corrupt_qidx')], 
      where )


  p = ggplot(data, aes(x='wheresize', y='total_time', color='name', shape='name', linetype='name'))
  p += geom_point(size=2) + geom_line(size=.6)
  p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)") 
  p += scale_color_discrete()
  p += axis_labels("# WHERE clauses", "Time (sec)", "continuous", "continuous", 
      xkwargs=dict(breaks=[1,2,3]))#breaks=[100, 1000, 10000], labels=map(esc, ['1k', '10k', '100k'])))
  p += legend_bottom
  p += guides(col = guide_legend(nrow = 1))
  ggsave("where_time.png", p, libs=['grid'], width=6, height=4, scale=0.7)



  #data = fold(data, [ "F1"])
  p = ggplot(data, aes(x='wheresize', y='F1', color='name', shape='name', linetype='name'))
  p += geom_point(size=2) + geom_line(size=.6)
  p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)") 
  p += scale_color_discrete()
  p += axis_labels("# WHERE clauses", "F1", "continuous", "continuous", 
      ykwargs=dict(lim=[.5,1], breaks=[.5, .8]),
      xkwargs=dict(breaks=[1,2,3]))#breaks=[100, 1000, 10000], labels=map(esc, ['1k', '10k', '100k'])))
  p += legend_bottom
  p += guides(col = guide_legend(nrow = 1))
  ggsave("where_acc.png", p, libs=['grid'], width=6, height=4, scale=0.7)

  data = fold(data, ['Precision', 'Recall'])
  p = ggplot(data, aes(x='wheresize', y='val', color='name', shape='name', linetype='name'))
  p += geom_point(size=2) + geom_line(size=.6)
  p += facet_grid("key~corrupt_qidx", labeller="function(k,v)paste('idx:', v)") 
  p += scale_color_discrete()
  p += axis_labels("# WHERE clauses", "F1", "continuous", "continuous", 
      ykwargs=dict(lim=[.5,1], breaks=[.6, .8]),
      xkwargs=dict(breaks=[1,2,3]))#breaks=[100, 1000, 10000], labels=map(esc, ['1k', '10k', '100k'])))
  p += legend_bottom
  p += guides(col = guide_legend(nrow = 1))
  ggsave("where_pr.png", p, libs=['grid'], width=6, height=4, scale=0.7)


  exit()



if True:
  # Scale 3
  data = group_on(
    [('500 - (logsize - corrupt_qidx)', 'corrupt_qidx'),
    'wheresize'], 
    "logsize=300 and db_size=1000 and skewness = 1 and range = 8"
  )


  p = ggplot("data", aes(x='corrupt_qidx', y='fixed_rate', color='factor(wheresize)'))
  p += facet_wrap("~name") + geom_line()
  plot("figs/scale3_qidx_v_fixrate.png", p, data=data)

  p = ggplot("data", aes(x='corrupt_qidx', y='noise_rate', color='factor(wheresize)'))
  p += facet_wrap("~name") + geom_line()
  plot("figs/scale3_qidx_v_noiserate.png", p, data=data)

  p = ggplot("data", aes(x='corrupt_qidx', y='total_time', color='factor(wheresize)'))
  p += facet_wrap("~name") + geom_line() + scale_y_log10()
  plot("figs/scale3_qidx_v_time.png", p, data=data)

  p = ggplot("data", aes(x='total_time', y='noise_rate', color='factor(wheresize)'))
  p += facet_wrap("~name") + geom_line() + scale_x_log10()
  plot("figs/scale3_time_v_noise.png", p, data=data)



exit()



data = group_on(
  [('500 - (logsize - corrupt_qidx)', 'corrupt_qidx'),
   ('logsize', 'logsize'),
   ('db_size', 'dbsize')], 
  "db_size = 1000 and skewness = 1 and wheresize=1"
)


p = ggplot("data", aes(x='corrupt_qidx', y='fixed_rate', color='factor(name)'))
p += facet_wrap("dbsize~logsize") + geom_line()
plot("figs/scale1_qidx_v_fixrate.png", p, data=data)

p = ggplot("data", aes(x='corrupt_qidx', y='total_time', color='factor(name)'))
p += facet_wrap("dbsize~logsize") + geom_line() + scale_y_log10()
plot("figs/scale1_qidx_v_time.png", p, data=data)

p = ggplot("data", aes(x='total_time', y='noise_rate', color='factor(name)'))
p += facet_wrap("dbsize~logsize") + geom_line() + scale_x_log10()
plot("figs/scale1_time_v_noise.png", p, data=data)


exit()

data = data_sql("queryprov", " ".join("""
  select 'qfix_' || opt_approx as name,
         logsize,
         db_size as dbsize,
         skewness as skewness,
         range as rsize,
         500 - (logsize - corrupt_qidx) as corrupt_qidx,
         avg(configs.num_compl) as ncomplaints,
         avg(fixed_rate) as fixed_rate, 
         avg(noise_rate) as noise_rate ,
         avg(preproc_time + solver_prep_cons_time) as prep_time,
         avg(solver_add_cons_time) as add_time, 
         avg(solver_solve_time) as cplex_time, 
         avg(preproc_time + solver_prep_cons_time + solver_add_cons_time + solver_solve_time + finish_time) as total_time
  from exps join configs on exps.pid = configs.pid
  group by 
          'qfix_' || opt_approx,
         logsize,
         db_size,
         skewness,
         range,
         corrupt_qidx ;
""".split("\n")))




p = ggplot("data", aes(x='corrupt_qidx', y='fixed_rate', color='factor(dbsize)'))
plot("qidx_v_fixrate.png", p, data=data)

p = ggplot("data", aes(x='corrupt_qidx', y='noise_rate', color='factor(dbsize)'))
plot("qidx_v_noiserate.png", p, data=data)

p = ggplot("data", aes(x='total_time', y='fixed_rate', color='factor(dbsize)'))
plot("time_v_fixrate.png", p, data=data)




data = data_sql("queryprovscale2", " ".join("""
  select  'qfix_' || opt_approx as name,
         logsize,
         db_size as dbsize,
         skewness,
         range as rsize,
         500 - (logsize - corrupt_qidx) as corrupt_qidx,
         configs.num_compl as ncomplaints,
         500 - (logsize - coalesce(nullif(fixed_query_idx,''),'-20')::int) as fixed_query_idx,
         fixed_rate, 
         noise_rate ,
         preproc_time + solver_prep_cons_time as prep_time,
         solver_add_cons_time as add_time, 
         solver_solve_time as cplex_time, 
         preproc_time + solver_prep_cons_time + solver_add_cons_time + solver_solve_time + finish_time as total_time
  from exps join configs on exps.pid = configs.pid;
""".split("\n")))

p = ggplot("data", aes(x='ncomplaints', y='total_time', color='factor(dbsize)')) + scale_y_log10()
plot("ncomplaints_v_total_time.png", p, data=data, libs=["grid"])

p = ggplot("data", aes(x='ncomplaints', y='noise_rate', color='factor(dbsize)')) + scale_y_log10()
plot("ncomplaints_v_noise.png", p, data=data, libs=["grid"])

p = ggplot("data", aes(x='corrupt_qidx - fixed_query_idx', y='noise_rate', color='factor(dbsize)')) 
plot("idxdiff_v_noise.png", p, data=data, libs=["grid"])


p = ggplot("data", aes(x='corrupt_qidx', y='total_time', color='factor(dbsize)'))
plot("qidx_v_total_time.png", p, data=data, libs=["grid"])

p = ggplot("data", aes(x='corrupt_qidx', y='prep_time', color='factor(dbsize)'))
plot("qidx_v_prep_time.png", p, data=data, libs=["grid"])

p = ggplot("data", aes(x='corrupt_qidx', y='cplex_time', color='factor(dbsize)'))
plot("qidx_v_solve_time.png", p, data=data, libs=["grid"])

p = ggplot("data", aes(x='corrupt_qidx', y='fixed_query_idx', color='factor(dbsize)'))
p += stat_function(fun="function(x)x")
plot("qidx_v_fixedidx.png", p, data=data, libs=["grid"])


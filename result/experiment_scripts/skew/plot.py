from sqlalchemy import *
from pygg import *
from wuutils import *
import sys
sys.path.append("..")
from util import *


group_on = create_group_on("queryprovskew")



# skewness
if 1:
  where = """
  logsize = 300 and db_size = 1000 and wheresize=1 and corrupt_qidx in (49, 199, 149, 299)
  and opt_approx in (8, 10) and max_num_compl > 20
  """
  data = group_on([('name', 'name'), 'skewness', ('301 - (logsize - corrupt_qidx)', 'corrupt_qidx')], 
            where)

  p = ggplot(data, aes(x='skewness', y='total_time', color='name', shape='name', linetype='name'))
  p += geom_point(size=2) + geom_line(size=.6)
  p += facet_grid(".~corrupt_qidx") #, labeller="function(k,v)paste('idx:', v)")
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
  p += facet_grid(".~corrupt_qidx") #, labeller="function(k,v)paste('idx:', v)") 
  p += scale_color_discrete()
  p += axis_labels("Skew", "F1", "continuous", "continuous", 
      ykwargs=dict(lim=[.5,1], breaks=[.6, .8]),
      xkwargs=dict(breaks=[.25, .75]))
  p += legend_bottom
  p += guides(col = guide_legend(nrow = 1))
  ggsave("skew_acc.png", p, libs=['grid'], width=6, height=3, scale=0.7)

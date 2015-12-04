from pygg import *
from wuutils import *
from sqlalchemy import *

import sys
sys.path.append("..")
from util import *


group_on = create_group_on("queryprov")

where = """
configs.sid = 9 and 
(opt_approx > 4 or 
 (opt_approx = 3 and solver!='cplex') or 
 solver = 'Naive_cplex')"""
data = group_on(
    [('name', 'name'), ('300 - (logsize - corrupt_qidx)', 'corrupt_qidx')], 
    where)

p = ggplot(data, aes(x='corrupt_qidx', y='total_time', group='name', fill="name", color='name', linetype='name', shape='name'))
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index", "Time (sec)", "continuous", "continuous", 
      xkwargs=dict(breaks=[ 100, 150, 200, 250]))
p += legend_bottom
#p += guides(col = guide_legend(nrow = 2))

ggsave("incrementalcompare_time.png", p, libs=['grid'], width=6, height=3, scale=0.7)


data = fold(data, ['Precision', 'Recall'])
p = ggplot(data, aes(x='corrupt_qidx', y='val', group='name', fill="name", color='name', linetype='name', shape='name'))
p += facet_grid(".~key")
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index", "Accuracy Metric", "continuous", "continuous", 
      ykwargs=dict(lim=[0,1]),
      xkwargs=dict(breaks=[ 100, 150, 200, 250]))
p += legend_bottom
#p += guides(col = guide_legend(nrow = 2))
ggsave("incrementalcompare_acc.png", p, libs=['grid'], width=6, height=3, scale=0.7)


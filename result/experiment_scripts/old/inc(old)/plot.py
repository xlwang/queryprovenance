from pygg import *
from wuutils import *
from sqlalchemy import *

import sys
sys.path.append("..")
from util import *


group_on = create_group_on("inc")

where = """
1 = 1"""
data = group_on(
    [('name', 'name'), ('300 - (logsize - corrupt_qidx)', 'corrupt_qidx')], 
    where)

p = ggplot(data, aes(x='corrupt_qidx', y='total_time', group='name', fill="name", color='name', linetype='name', shape='name'))
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index", "Time (sec)", "continuous", "continuous", 
      xkwargs=dict(breaks=[ 50, 150, 300]))
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
      xkwargs=dict(breaks=[ 50, 150, 300 ]))
p += legend_bottom
#p += guides(col = guide_legend(nrow = 2))
ggsave("incrementalcompare_acc.png", p, libs=['grid'], width=6, height=3, scale=0.7)


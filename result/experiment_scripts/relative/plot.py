from sqlalchemy import *
from pygg import *
from wuutils import *
import sys
sys.path.append("..")
from util import *


group_on = create_group_on("queryprovrel")



where = """1=1
"""
data = group_on([('name', 'name'), ('301 - (logsize - corrupt_qidx)', 'corrupt_qidx')], 
          where)

p = ggplot(data, aes(x='corrupt_qidx', y='prep_time+add_time', color='name', shape='name', linetype='name'))
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index", "Prep + add Time (sec)", "continuous", "continuous", 
    xkwargs=dict(breaks=[ 100, 150, 200, 250]))
p += legend_bottom + guides(col = guide_legend(nrow = 2))
ggsave("rel_preptime.png", p, libs=['grid'], width=6, height=4, scale=0.7)

p = ggplot(data, aes(x='corrupt_qidx', y='total_time', color='name', shape='name', linetype='name'))
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index", "Total time (sec)", "continuous", "continuous", 
    xkwargs=dict(breaks=[ 100, 150, 200, 250]))
p += legend_bottom + guides(col = guide_legend(nrow = 2))
ggsave("rel_time.png", p, libs=['grid'], width=6, height=4, scale=0.7)

p = ggplot(data, aes(x='corrupt_qidx', y='num_cons', color='name', shape='name', linetype='name'))
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index", "# Constraints", "continuous", "continuous", 
    xkwargs=dict(breaks=[ 100, 150, 200, 250]))
p += legend_bottom + guides(col = guide_legend(nrow = 2))
ggsave("rel_ncons.png", p, libs=['grid'], width=6, height=4, scale=0.7)


#data = fold(data, ['Precision', 'Recall', "F1"])
#data = fold(data, [ "F1"])
p = ggplot(data, aes(x='corrupt_qidx', y='F1', color='name', shape='name', linetype='name'))
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index", "F1", "continuous", "continuous", 
    ykwargs=dict(lim=[.5,1], breaks=[.6, .8]),
    xkwargs=dict(breaks=[ 100, 150, 200, 250]))
p += legend_bottom + guides(col = guide_legend(nrow = 2))
ggsave("rel_acc.png", p, libs=['grid'], width=6, height=4, scale=0.7)


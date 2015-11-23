from sqlalchemy import *
from pygg import *
from wuutils import *
sys.path.append("..")
from util import *


group_on = create_group_on("queryprovmulti")
where = """ 1 = 1 """
data = group_on(
    ['name', 'idx'],
    where)


p = ggplot(data, aes(x='idx', y='total_time', color='name', shape='name', linetype='name'))
p += geom_point(size=2) + geom_line(size=.6)
#p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)")
p += scale_color_discrete()
p += axis_labels("# Corrupted Queries", "Time (sec)", "continuous", "continuous")
    #xkwargs=dict(breaks=[.25,  .75]))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("multi_time.png", p, libs=['grid'], width=6, height=3, scale=0.7)


data = fold(data, ['Precision', 'Recall'])
p = ggplot(data, aes(x='idx', y='val', color='name', shape='name', linetype='name'))
p += geom_point(size=2) + geom_line(size=.6)
p += facet_grid(".~key")
p += scale_color_discrete()
p += axis_labels("# Corrupted Queries", "Accuracy Metric", "continuous", "continuous", 
    ykwargs=dict(lim=[0,1]))
    #xkwargs=dict(breaks=[.25, .75]))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("multi_pr.png", p, libs=['grid'], width=6, height=3, scale=0.7)



p = ggplot(data, aes(x='idx', y='F1', color='name', shape='name', linetype='name'))
p += geom_point(size=2) + geom_line(size=.6)
#p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)") 
p += scale_color_discrete()
p += axis_labels("# Corrupted Queries", "F1", "continuous", "continuous", 
    ykwargs=dict(lim=[0,1]))
    #xkwargs=dict(breaks=[.25, .75]))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("multi_acc.png", p, libs=['grid'], width=6, height=3, scale=0.7)


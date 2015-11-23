from sqlalchemy import *
from pygg import *
from wuutils import *
sys.path.append("..")
from util import *


group_on = create_group_on("queryprovlog")
where = """ true """
data = group_on(
    [('name'), ('logsize'), 'skewness', (' (logsize - corrupt_qidx)', 'corrupt_qidx')], 
    where)

p = ggplot(data, aes(x='corrupt_qidx', y='prep_time+add_time', color='name', shape='name', linetype='name'))
p += facet_wrap("~logsize")
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index From Most Recent", "Time (sec)", "continuous", "continuous",
    ykwargs=dict())
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("logsize_prep.png", p, libs=['grid'], width=6, height=4, scale=0.7)

p = ggplot(data, aes(x='corrupt_qidx', y='cplex_time', color='name', shape='name', linetype='name'))
p += facet_wrap("~logsize")
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index From Most Recent", "Time (sec)", "continuous", "continuous",
    ykwargs=dict())
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("logsize_solve.png", p, libs=['grid'], width=6, height=4, scale=0.7)



p = ggplot(data, aes(x='corrupt_qidx', y='total_time', color='name', shape='name', linetype='name'))
p += facet_wrap("~logsize")
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index From Most Recent", "Time (sec)", "continuous", "continuous",
    ykwargs=dict())
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("logsize_time.png", p, libs=['grid'], width=6, height=4, scale=0.7)


p = ggplot(data, aes(x='corrupt_qidx', y='F1', color='name', shape='name', linetype='name'))
p += facet_wrap("~logsize")
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index From Most Recent", "F1", "continuous", "continuous",
    ykwargs=dict(lim=[.5, 1], breaks=[.6, .8]))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("logsize_acc.png", p, libs=['grid'], width=6, height=4, scale=0.7)



exit()

#data = fold(data, ['Precision', 'Recall', "F1"])
#data = fold(data, [ "F1"])
p = ggplot(data, aes(x='logsize', y='F1', color='corrupt_qidx', shape='corrupt_qidx', linetype='corrupt_qidx'))
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index", "F1", "continuous", "continuous", 
    ykwargs=dict(lim=[.5, 1], breaks=[.6, .8]))
    #xkwargs=dict(breaks=[.25, .75]))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("logsize_acc.png", p, libs=['grid'], width=6, height=3, scale=0.7)


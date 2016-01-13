from sqlalchemy import *
from pygg import *
from wuutils import *
import sys
sys.path.append("..")
from util import *



group_on = create_group_on("queryprovskew")

# skewness
where = """1 = 1
"""
data = group_on(
    [('name'), 
     ('skewness'),
     ('db_size', 'dbsize'),
     #('row_num'),
     ('\'idx: \' || lpad((301 - (logsize - corrupt_qidx))::text, 3, \'0\')', 'corrupt_qidx')], 
    where)

p = geom_jitter(position=position_jitter(height=0, width=0.1), size=2, alpha=0.4) # + geom_line(size=.6)
p += scale_color_discrete()
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))

if 0:  
    plot = ggplot(data, aes(x='skewness', y='ncomplaints', color='name', shape='name', linetype='name'))
    plot += p
    plot += facet_grid("dbsize~corrupt_qidx")
    plot += axis_labels("Skew", "# Complaints", "log10", "continuous")
    ggsave("skew_ncomp.png", plot, libs=['grid'], width=6, height=3, scale=1.7)


    plot = ggplot(data, aes(x='ncomplaints', y='total_time', color='name', shape='name', linetype='name'))
    plot += p
    plot += facet_grid("dbsize~corrupt_qidx")
    plot += axis_labels("# Complaints", "Time (sec)", "continuous", "continuous")
    ggsave("skew_ncomp_time.png", plot, libs=['grid'], width=6, height=3, scale=1.7)

    plot = ggplot(data, aes(x='ncomplaints', y='count', color='name', shape='name', linetype='name'))
    plot += p
    plot += facet_grid(".~corrupt_qidx")
    plot += axis_labels("# Complaints", "count(*)", "continuous", "continuous")
    ggsave("skew_ncomp_count.png", plot, libs=['grid'], width=6, height=3, scale=1.7)
    exit()

    plot = ggplot(data, aes(x='skewness', y='cplex_time', color='name', shape='name', linetype='name'))
    plot += p
    plot += facet_grid("dbsize~corrupt_qidx")
    plot += axis_labels("Skew", "Solver Time (sec)", "log10", "continuous")
    ggsave("skew_cplex_time.png", plot, libs=['grid'], width=6, height=3, scale=1.7)

    plot = ggplot(data, aes(x='skewness', y='prep_time + add_time', color='name', shape='name', linetype='name'))
    plot += p
    plot += facet_grid("dbsize~corrupt_qidx")
    plot += axis_labels("Skew", "Prep Time (sec)", "log10", "continuous")
    ggsave("skew_prep_time.png", plot, libs=['grid'], width=6, height=3, scale=1.7)


plot = ggplot(data, aes(x='skewness', y='total_time', color='name', shape='name', linetype='name'))
plot += p
plot += facet_grid("dbsize~corrupt_qidx")
plot += axis_labels("Skew", "Time (sec)", "log10", "continuous")
ggsave("skew_time.png", plot, libs=['grid'], width=6, height=3, scale=1.7)

plot = ggplot(data, aes(x='skewness', y='F1', color='name', shape='name', linetype='name'))
plot += p
plot += facet_grid("dbsize~corrupt_qidx")
plot += axis_labels("Skew", "F1", "log10", "continuous",
    ykwargs=dict(lim=[0.5,1], breaks=[.6, .8]))
ggsave("skew_f1.png", plot, libs=['grid'], width=6, height=3, scale=1.7)


data = fold(data, ['Precision', 'Recall'])
plot = ggplot(data, aes(x='skewness', y='val', color='name', shape='name', linetype='name'))
plot += p
plot += facet_grid("dbsize~key")
plot += axis_labels("Skew", "Percentage", "log10", "continuous",
    ykwargs=dict(lim=[0.5,1], breaks=[.6, .8]))
    #xkwargs=dict(breaks=[.25, .75]))
ggsave("skew_acc.png", plot, libs=['grid'], width=6, height=3, scale=1.7)



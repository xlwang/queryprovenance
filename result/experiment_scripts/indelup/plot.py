from sqlalchemy import *
from pygg import *
from wuutils import *
sys.path.append("..")
from util import *


group_on = create_group_on("queryprovindel")
where = """
 opt_approx in (3)
"""
data = group_on(
    ['logsize', ('exps.sid', 'sid')],
    where
)

for d in data:
  if d['sid'] == 0:
    d['sid'] = "DELETE only"
  if d['sid'] == 1:
    d['sid'] = "INSERT only"
  if d['sid'] == 2:
    d['sid'] = "UPDATE only"

p = ggplot(data, aes(x='logsize', y='total_time', color='sid', shape='sid', linetype='sid'))
p += geom_point(size=2) + geom_line(size=.6)
#p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)")
p += scale_color_discrete()
p += axis_labels("# Queries", "Time (sec)", "continuous", "continuous")
    #xkwargs=dict(breaks=[.25,  .75]))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("indelup_time.png", p, libs=['grid'], width=6, height=3, scale=0.7)

p = ggplot(data, aes(x='logsize', y='F1', color='sid', shape='sid', linetype='sid'))
p += geom_point(size=2) + geom_line(size=.6)
#p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)") 
p += scale_color_discrete()
p += axis_labels("# Queries", "F1", "continuous", "continuous", 
    ykwargs=dict(lim=[.5,1], breaks=[.6, .8]))
    #xkwargs=dict(breaks=[.25, .75]))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("indelup_acc.png", p, libs=['grid'], width=6, height=3, scale=0.7)

data = fold(data, ['Precision', 'Recall'])
p = ggplot(data, aes(x='logsize', y='val', color='sid', shape='sid', linetype='sid'))
p += geom_point(size=2) + geom_line(size=.6)
p += facet_grid(".~key")
p += scale_color_discrete()
p += axis_labels("# Queries", "F1", "continuous", "continuous", 
    ykwargs=dict(lim=[.5,1], breaks=[.6, .8]))
    #xkwargs=dict(breaks=[.25, .75]))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("indelup_pr.png", p, libs=['grid'], width=6, height=3, scale=0.7)


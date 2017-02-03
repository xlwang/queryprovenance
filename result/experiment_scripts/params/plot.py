from pygg import *
from wuutils import *
import sys
sys.path.append("..")
from util import *


group_on = create_group_on("queryprovparams")
data = group_on(['name', 'logsize'])
p = ggplot(data, aes(x='logsize', y='total_time', group='name', fill="name", color='name'))
#p += geom_point(size=2)
p += geom_bar(stat=esc("identity"), position=esc("dodge"))
p += scale_color_discrete()

# add axis labels x is continuous, y is log10 scale
p += axis_labels("Query Log Size", "Total Time\n(sec)(log)", "continuous", "log10", xkwargs=dict(lim=[5, 70]), ykwargs=dict(breaks=[1, 10, 100, 1000]))

# make it pretty
p += legend_bottom
#p += theme(**{"legend.spacing": "unit(-.5, 'cm')"})
p += theme(**{"legend.position": "c(.32, .4)"})
ggsave("qsize_time_badscale.png", p, libs=['grid'], width=6, height=2.25, scale=0.7)

from pygg import *
from wuutils import *
sys.path.append("..")
from util import *


group_on = create_group_on("queryprovparams")
data = group_on(['logsize'])
p = ggplot('data', aes(x='logsize', y='total_time', group='name', fill="name", color='name', linetype='name'))
#p += geom_point(size=2)
p += geom_bar(stat=esc("identity"), position=esc("dodge"))
p += scale_color_discrete()

# add axis labels x is continuous, y is log10 scale
p += axis_labels("Query Log Size", "Total Time", "continuous", "log10")

# make it pretty
p += legend_bottom
ggsave("qsize_time_badscale.png", p, data=data, libs=['grid'], width=6, height=4, scale=0.7)

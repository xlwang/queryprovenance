from sqlalchemy import *
from pygg import *
from wuutils import *
import sys
sys.path.append("..")
from util import *


group_on = create_group_on("queryprovnoise")

# skewness
where = """
corrupt_qidx in (49, 199, 149, 299) and opt_approx in (2)
"""
data = group_on(
    [('name'), ('1-fntrunc', 'fn'), ('\'idx: \' || 301 - (logsize - corrupt_qidx)', 'corrupt_qidx')], 
    where)


p = ggplot(data, aes(x='fn', y='total_time', color='corrupt_qidx', shape='corrupt_qidx', linetype='corrupt_qidx'))
p += geom_point(size=2) + geom_line(size=.6)
#p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)")
p += scale_color_discrete()
p += axis_labels("False Negative Rate", "Time (sec)", "continuous", "continuous")
    #xkwargs=dict(breaks=[.25,  .75]))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("noise_fn_time.png", p, libs=['grid'], width=6, height=3, scale=0.7)


#data = fold(data, ['Precision', 'Recall', "F1"])
#data = fold(data, [ "F1"])
p = ggplot(data, aes(x='fn', y='F1', color='corrupt_qidx', shape='corrupt_qidx', linetype='corrupt_qidx'))
p += geom_point(size=2) + geom_line(size=.6)
#p += facet_grid(".~corrupt_qidx", labeller="function(k,v)paste('idx:', v)") 
p += scale_color_discrete()
p += axis_labels("False Negative Rate", "F1", "continuous", "continuous", 
    ykwargs=dict(lim=[0,1], breaks=[.6, .8]))
    #xkwargs=dict(breaks=[.25, .75]))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("noise_fn_acc.png", p, libs=['grid'], width=6, height=3, scale=0.7)


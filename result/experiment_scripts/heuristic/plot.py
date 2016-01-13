from sqlalchemy import *
from pygg import *
from wuutils import *
import sys
sys.path.append("..")
from util import *


group_on = create_group_on("queryprovheuristic")
where = """
opt_approx in (0, 1)  and max_num_compl > 20
"""
data = group_on([('name', 'name'), ('db_size', 'dbsize'), ('301 - (logsize - corrupt_qidx)', 'corrupt_qidx')],
       where)

p = ggplot(data, aes(x='dbsize', y='total_time', color='name', shape='name', linetype='name')) 
p += geom_point(size=2) + geom_line(size=.6) #
#p += facet_grid(".~corrupt_qidx") #, labeller="function(k,v)paste('idx:', v)") 
p += scale_color_discrete() 
p += axis_labels("# Tuples in DB (log)", "Time (sec)", "log10", "continuous", xkwargs=dict(breaks=[100, 1000, 10000], labels=map(esc, ['100', '1k', '10k']))) 
p += legend_bottom 
p += guides(col = guide_legend(nrow = 1))
ggsave("decisiontree_vs_qfix_time.png", p, libs=['grid'], width=6, height=4, scale=0.7)
                            
#data = fold(data, ['Precision', 'Recall', "F1"])
#data = fold(data, [ "F1"])
p = ggplot(data, aes(x='dbsize', y='F1', color='name', shape='name', linetype='name'))
p += geom_point(size=2) + geom_line(size=.6)
#p += facet_grid(".~corrupt_qidx") #, labeller="function(k,v)paste('idx:', v)")
p += scale_color_discrete()
p += axis_labels("# Tuples in DB (log)", "F1", "log10", "continuous", 
                 ykwargs=dict(lim=[0,1], breaks=[.6, .8]),
                 xkwargs=dict(breaks=[100, 1000, 10000], labels=map(esc, ['100', '1k', '10k'])))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("decisiontree_vs_qfix_acc.png", p, libs=['grid'], width=6, height=4, scale=0.7)
  



from sqlalchemy import *
from pygg import *
from wuutils import *
import sys
sys.path.append("..")
from util import *






# skewness
group_on = create_group_on("queryprovauction")
where = """opt_approx = 0
"""
auction = group_on(
    [('name'), ('exps.avg_num_cons', 'num_complaints'), ('651 - (logsize - corrupt_qidx)', 'corrupt_qidx')], 
    where)
for d in auction:
  d['name'] = 'AuctionMark'

group_on = create_group_on("queryprovtpcc")
tpcc = group_on(
    [('name'),  ('exps.avg_num_cons', 'num_complaints'), ('1001 - (logsize - corrupt_qidx)', 'corrupt_qidx')], 
    where)
for d in tpcc:
  d['name'] = 'TPC-C'

data = []
data.extend(auction)
data.extend(tpcc)


p = ggplot(data, aes(x='corrupt_qidx', y='num_complaints', color='name', 
  shape='name', linetype='name'))
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index", "# Constraints", "continuous", "continuous")
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("benchmark_complaints.png", p, libs=['grid'], width=6, height=3, scale=0.7)



p = ggplot(data, aes(x='corrupt_qidx', y='total_time', color='name', 
  shape='name', linetype='name'))
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index", "Time (sec)", "continuous", "continuous",
    ykwargs=dict(lim=[0, 10]))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("benchmark_time.png", p, libs=['grid'], width=6, height=3, scale=0.7)


#data = fold(data, ['Precision', 'Recall', "F1"])
#data = fold(data, [ "F1"])
p = ggplot(data, aes(x='corrupt_qidx', y='F1', color='name', shape='name', linetype='name'))
p += geom_point(size=2) + geom_line(size=.6)
p += scale_color_discrete()
p += axis_labels("Corrupted Query Index", "F1", "continuous", "continuous", 
    ykwargs=dict(lim=[.5,1], breaks=[.6, .8]))
    #xkwargs=dict(breaks=[.25, .75]))
p += legend_bottom
p += guides(col = guide_legend(nrow = 1))
ggsave("auction_acc.png", p, libs=['grid'], width=6, height=3, scale=0.7)


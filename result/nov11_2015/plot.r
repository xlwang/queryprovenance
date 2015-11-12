library(ggplot2)

data = read.csv("qidxstats.csv")

noskew = data[data$skewness==0,]
skew = data[data$range==20,]

p = ggplot(noskew, aes(x=corrupt_idx, y=num_compl, color=set_type))
p = p + facet_grid(range~set_type)
p = p + geom_point(alpha=0.1, size=1.25)
p = p + geom_smooth(color='black')
ggsave('complaint_varyrange.png', p, width=8, height=6)

p = ggplot(skew, aes(x=corrupt_idx, y=num_compl, color=set_type))
p = p + facet_grid(skewness~set_type)
p = p + geom_point(alpha=0.1, size=1.25)
p = p + geom_smooth(color='black')
ggsave('complaint_varyskew.png', p, width=8, height=6)


p = ggplot(noskew, aes(x=corrupt_idx, y=num_relv_query, color=set_type))
p = p + facet_grid(range~set_type)
p = p + geom_point(alpha=0.15, size=1.25)
p = p + geom_smooth(color='black')
ggsave('relqueries_varyrange.png', p, width=8, height=6)

p = ggplot(skew, aes(x=corrupt_idx, y=num_relv_query, color=set_type))
p = p + facet_grid(skewness~set_type)
p = p + geom_point(alpha=0.15, size=1.25)
p = p + geom_smooth(color='black')
ggsave('relqueries_varyskew.png', p, width=8, height=6)

p = ggplot(noskew, aes(x=num_relv_query, y=num_compl, color=set_type))
p = p + facet_grid(range~set_type)
p = p + geom_point(alpha=0.15, size=1.25)
p = p + geom_smooth(color='black')
ggsave('relvcompl_varyrange.png', p, width=8, height=6)

p = ggplot(skew, aes(x=num_relv_query, y=num_compl, color=set_type))
p = p + facet_grid(skewness~set_type)
p = p + geom_point(alpha=0.15, size=1.25)
p = p + geom_smooth(color='black')
ggsave('relvcompl_varyskew.png', p, width=8, height=6)


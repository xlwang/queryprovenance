library(ggplot2)

data = read.csv('costdata.tsv', sep=' ')
data$FalsePositive[data$FalsePositive == 1] = 'false positive'
data$FalsePositive[data$FalsePositive == 0] = 'true positive'
p = ggplot(data=data, aes(x=TupleID, y=cost, color=label))
p = p+geom_point()+scale_y_log10()
p = p+facet_grid(FalsePositive~perc)
ggsave('/tmp/cs_by_dist.pdf', w=12,h=5)


data$perc = factor(data$perc)
p = ggplot(data=data, aes(x=TupleID, y=cost, color=perc))
p = p+geom_point()+scale_y_log10()
p = p+facet_grid(FalsePositive~label)
ggsave('/tmp/cs_by_perc.pdf', w=12,h=5)

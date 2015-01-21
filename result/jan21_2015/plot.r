library(ggplot2)

data = read.csv('costdata.csv')
data$FalsePositive[data$FalsePositive == 1] = 'false positive'
data$FalsePositive[data$FalsePositive == 0] = 'true positive'
data$perc = factor(data$perc)
p = ggplot(data=data, aes(x=TupleID, y=cost, color=label))
p = p+geom_point()+scale_y_log10()
p = p+facet_grid(FalsePositive~perc)
ggsave('./cs_by_dist_facet.pdf', w=12,h=5)


p = ggplot(data=data, aes(x=TupleID, y=cost, color=perc))
p = p+geom_point()+scale_y_log10()
p = p+facet_grid(FalsePositive~label)
ggsave('./cs_by_perc_facet.pdf', w=12,h=5)

p = ggplot(data=data, aes(x=TupleID, y=cost, color=perc))
p = p+geom_point()+scale_y_log10()
p = p+facet_grid(.~label)
ggsave('./cs_by_perc.pdf', w=12,h=5)

p = ggplot(data=data, aes(x=TupleID, y=cost, color=label))
p = p+geom_point()+scale_y_log10()
p = p+facet_grid(.~perc)
ggsave('./cs_by_dist.pdf', w=12,h=5)

p = ggplot(data=data, aes(x=TupleID, y=modifiedtupleamt, color=label))
p = p+geom_point()+scale_y_log10()
p = p+facet_grid(label~perc)
ggsave('./numtup_by_dist.pdf', w=12,h=5)



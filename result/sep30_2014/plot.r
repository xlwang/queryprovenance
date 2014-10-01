library(ggplot2)
library(plyr)

basedata = read.csv('qp.csv')
basedata$totaltime = basedata$totaltime / 1000000
basedata$solvetime = basedata$solvetime / 1000000
basedata$finishtime = basedata$finishtime / 1000000
basedata$preptime = basedata$preptime / 1000000

data = ddply(basedata,
  c('solver', 'cardinality', 'logsize', 'dbsize'),
  summarize,
  badcomplaints   =mean(badcomplaints),
  remaincomplaints=mean(remaincomplaints),
  fixedrate       =mean(fixedrate),
  noiserate       =mean(noiserate),
  preptime        =mean(preptime),
  solvetime       =mean(solvetime),
  finishtime      =mean(finishtime),
  totaltime       =mean(totaltime)
)


#data2 = data[data$cardinality %in% c(1, 5) & data$logsize %in% c(5, 20),]
#basedata2 = basedata[basedata$cardinality %in% c(1, 5) & basedata$logsize %in% c(5, 20),]

plotit = function(aes, basedat, dat) {
  colname = paste(aes$y)
  yname = colname
  sy = scale_y_continuous
  if (max(dat[,colname]) - min(dat[,colname]) > 1000) {
    yname = paste(colname, '(log)')
    sy = scale_y_log10
  } 
  jitter = position_jitter(width = .08, height= .05)
  data = dat
  basedata = basedat
  a = aes(x=dbsize, color=solver)
  a$y = aes$y
  p = ggplot(data, a, environment=environment())
  p = p + geom_point(data=basedata, a, alpha=0.5, position=jitter)
  p = p + geom_point(color='black') + geom_line() + facet_grid(logsize~cardinality, labeller=paste)
  p = p + sy(name=colname)
  ggsave(paste('pdfs/',colname, '_vs_dbsize.pdf', sep=''), p, scale=1.5)


  a = aes(x=logsize, color=solver)
  a$y = aes$y
  p = ggplot(data, a, environment=environment()) 
  p = p + geom_point(data=basedata, a, alpha=0.5, position=jitter)
  p = p + geom_point(color='black') + geom_line() + facet_grid(dbsize~cardinality, labeller=paste)
  p = p + sy(name=colname)
  ggsave(paste('pdfs/',colname, '_vs_logsize.pdf', sep=''), p, scale=1.5)

  a = aes(x=cardinality, color=solver)
  a$y = aes$y
  p = ggplot(data, a, environment=environment()) 
  p = p + geom_point(data=basedata, a, alpha=0.5, position=jitter)
  p = p + geom_point(color='black') + geom_line() + facet_grid(dbsize~logsize, labeller=paste)
  p = p + sy(name=colname)
  ggsave(paste('pdfs/',colname, '_vs_card.pdf', sep=''), p, scale=1.5)
}


plotit(aes(y=totaltime), basedata, data)
plotit(aes(y=badcomplaints), basedata, data)
plotit(aes(y=remaincomplaints), basedata, data)
plotit(aes(y=fixedrate), basedata, data)
plotit(aes(y=noiserate), basedata, data)
plotit(aes(y=preptime), basedata, data)
plotit(aes(y=solvetime), basedata, data)
plotit(aes(y=finishtime), basedata, data)


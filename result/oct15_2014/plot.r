library(ggplot2)
library(plyr)

basedata = read.csv('qp.csv')
basedata$solver = paste(basedata$solver, '-', basedata$complaintperc, sep='')
basedata$totaltime = basedata$totaltime / 1000000
basedata$solvetime = basedata$solvetime / 1000000
basedata$finishtime = basedata$finishtime / 1000000
basedata$preptime = basedata$preptime / 1000000
basedata$correctidx = basedata$badqueryindex == basedata$fixedqueryindex
basedata$diffidx = basedata$badqueryindex - basedata$fixedqueryindex
basedata$correctsize = as.numeric(basedata$correctidx & (basedata$origclausesize == basedata$fixedclausesize))
basedata$correctidx = as.numeric(basedata$correctidx)

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
  totaltime       =mean(totaltime),
  correctidx      =mean(correctidx),
  correctsize     =mean(correctsize),
  diffidx         =mean(diffidx)
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
  jitter = position_jitter(width = .08, height= .0)
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
plotit(aes(y=correctidx), basedata, data)
plotit(aes(y=correctsize), basedata, data)
plotit(aes(y=preptime), basedata, data)
plotit(aes(y=solvetime), basedata, data)
plotit(aes(y=finishtime), basedata, data)
plotit(aes(y=diffidx), basedata, data)







basedata = basedata[basedata$correctidx == 1,]
basedata$correctsizecondidx = basedata$correctsize

data = ddply(basedata,
  c('solver', 'cardinality', 'logsize', 'dbsize'),
  summarize,
  correctsizecondidx     =mean(correctsizecondidx)
)

plotit(aes(y=correctsizecondidx), basedata, data)


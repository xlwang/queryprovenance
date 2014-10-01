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
  badcomplaints   =median(badcomplaints),
  remaincomplaints=median(remaincomplaints),
  fixedrate       =median(fixedrate),
  noiserate       =median(noiserate),
  preptime        =median(preptime),
  solvetime       =median(solvetime),
  finishtime      =median(finishtime),
  totaltime       =median(totaltime)
)


#data2 = data[data$cardinality %in% c(1, 5) & data$logsize %in% c(5, 20),]
#basedata2 = basedata[basedata$cardinality %in% c(1, 5) & basedata$logsize %in% c(5, 20),]

plotit = function(colname, basedat, dat) {
  yname = colname
  sy = scale_y_continuous
  if (max(dat$colname) - min(dat$colname) > 1000) {
    yname = paste(colname, '(log)')
    sy = scale_y_log10
  } 
  data = dat
  basedata = basedat
  a = aes(x=dbsize, color=solver, y=data[,colname])
  p = ggplot(data, a, environment=environment())
  p = p + geom_point(color='black') + geom_line() + facet_grid(logsize~cardinality, labeller=paste)
  p = p + geom_point(data=basedata, aes(x=dbsize, y=basedata[,colname]), alpha=0.5)
  p = p + sy(name=colname)
  ggsave(paste('pdfs/',colname, '_vs_dbsize.pdf', sep=''), p, scale=1.5)


  #data2 = data[data$cardinality %in% c(1, 5),]# & data$logsize %in% c(5, 20),]
  p = ggplot(data, aes(x=logsize, y=data[,colname], color=solver), environment=environment()) 
  p = p + geom_point(color='black') + geom_line() + facet_grid(dbsize~cardinality, labeller=paste)
  p = p + geom_point(data=basedata, aes(x=logsize, y=basedata[,colname]), alpha=0.5)
  p = p + sy(name=colname)
  ggsave(paste('pdfs/',colname, '_vs_logsize.pdf', sep=''), p, scale=1.5)

  p = ggplot(data, aes(x=cardinality, y=data[,colname], color=solver), environment=environment()) 
  p = p + geom_point(color='black') + geom_line() + facet_grid(dbsize~logsize, labeller=paste)
  p = p + geom_point(data=basedata, aes(x=cardinality, y=basedata[,colname]), alpha=0.5)
  p = p + sy(name=colname)
  ggsave(paste('pdfs/',colname, '_vs_card.pdf', sep=''), p, scale=1.5)
}


plotit('totaltime', basedata, data)
plotit('badcomplaints', basedata, data)
plotit('remaincomplaints', basedata, data)
plotit('fixedrate', basedata, data)
plotit('noiserate', basedata, data)
plotit('preptime', basedata, data)
plotit('solvetime', basedata, data)
plotit('finishtime', basedata, data)


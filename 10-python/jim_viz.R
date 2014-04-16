#load the injury data
dl.2010 <- read.delim("C:/Users/julbright/Dropbox/GA/TJ Research/documents-export-2014-04-15/2010DL.txt")
dl.2011 <- read.delim("C:/Users/julbright/Dropbox/GA/TJ Research/documents-export-2014-04-15/2011DLlist.txt")
dl.2012 <- read.delim("C:/Users/julbright/Dropbox/GA/TJ Research/documents-export-2014-04-15/2012DL.txt")
dl.2013 <- read.delim("C:/Users/julbright/Dropbox/GA/TJ Research/documents-export-2014-04-15/2013 DL data.txt")

#load some required packages
require('ggplot2')
require('lubridate')


#load some nice variables that might be nice to have.
days.in.season<-180
players.in.season<-750


#some data conversion gets frontloaded up here.
dl.2013$Days<-as.double(dl.2013$Days)
dl.2013$On.Date.text<-as.character(dl.2013$On.Date)
dl.2013$On.Date<-parse_date_time(dl.2013$On.Date.text, 'mdy')
dl.2013$on.month<-month(dl.2013$On.Date)

#lets get some initial visualizations down
bp <- ggplot(dl.2013, aes(factor(Injury.type.strain.),Days))
bp <- bp + geom_boxplot(aes(fill=Injury.type.strain.))
bp <- bp + theme(axis.text.x = element_text(angle = 90, hjust = 1), legend.position='none')
bp + labs(title = '2013 Days on Disabled List by Injury Type')


## set the levels in order we want
theTable <- within(dl.2013, 
                   Injury.type.strain. <- factor(Injury.type.strain., 
                                      levels=names(sort(table(Injury.type.strain.), 
                                                        decreasing=TRUE))))
## make a bar plot
bar.p <- ggplot(theTable,aes(x=Injury.type.strain.))
bar.p <- bar.p + geom_bar(binwidth=1)
bar.p <- bar.p + theme(axis.text.x = element_text(angle = 90, hjust = 1), legend.position='none')
bar.p + labs(title = ' 2013 Count of Injuries by Type')

month.bar <- ggplot(dl.2013, aes(x = on.month))
month.bar <- month.bar + geom_bar(binwidth = .5)
month.bar <- month.bar + theme(axis.text.x = element_text(angle = 90, hjust = 1), legend.position = 'none')
month.bar + labs(title='2013 Injuries by Month of Season')

## garon -garon.reeves@gmail.com
## this is just at the exploratory plots stage
## lot of work to go, but just want to get a file out here
batdata <- read.csv('batting.csv')
salarydata <- read.csv('salaries.csv')
masterdata <- read.csv('master.csv')
baseball.df <- merge(batdata,salarydata)
baseball.df$batavg <- baseball.df$H/baseball.df$AB
miniball <- baseball.df[1:1000,]
miniball <- subset(miniball, AB>99)
fit <- lm(salary ~ G_old, data=miniball)
plot(miniball$salary,miniball$batavg)
plot(salary ~ batavg + G_old, data=miniball) # what a mess
## by the way, one of things I suspect is that when all is said and done,
## there will be a better correlation between this years batting average
## and next year's salary, not this year's salary... but that's out of
## my league write now.
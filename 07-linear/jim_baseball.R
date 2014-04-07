#I couldn't figure out a way to load these in from a URL, but I think it's possible! This is my second-best
#solution, which is lame.
batting <- read.csv("~/GitHub/gadsdata/baseball/batting.csv")
master <- read.csv("~/GitHub/gadsdata/baseball/master.csv")
salaries <- read.csv("~/GitHub/gadsdata/baseball/salaries.csv")


#first was to test merging. looks like it worked so then I merged the last list.
b_s <- merge(batting, salaries)
bsm <- merge(b_s, master, by.x="playerID", by.y = "playerID")
#important to note that this is the granularity here is the 'player-season.' one player will 
#have multiple entries if they played for multiple seasons,

plot(sort(bsm$salary))

#salary should probalby be in log
bsm$log.salary<-log(bsm$salary)

plot(sort(bsm$log.salary))

g <- ggplot(bsm, aes(x=RBI, y=log.salary))
g <- g + geom_point()

lin.log.sal_RBI<-lm(log.salary ~ RBI, data=bsm)

#this doesn't work because SOMEONE has a salary of negative infinity. I'm just going to discard that person.

clean1<-bsm[bsm$log.salary!=-Inf,]

lin.log.sal_RBI<-lm(log.salary~RBI, data=clean1)
plot(lin.log.sal_RBI)

#definitely something going on here. 

#is there an optimal (from a salary standpoint) bodytype for baseball?


g2<-ggplot(clean1, aes(x=weight, y=log.salary))
g2<-g2+geom_point()
print(g2)

lin.log.salary_weight_height<-lm(log.salary~height+weight, data=clean1)
                                 
#the model thinks so, but i'm willing to bet if we control for some performance stuff, it doesn't matter.
#let's find out.

salary<-lm(log.salary ~ weight + height + RBI + HR, data=clean1)
summary(salary)

#after controlling for RBI and HR, the significance of height pretty much disappears. But HR has a much smaller coefficient
#than RBI. That's a bit odd, but it might be because they're collinear. Let's' check their correlation!



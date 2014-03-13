# first attempt

switch <- NULL
no_switch <- NULL

for (i in 1:100) {

winning_door <- sample(1:3,1)
initial_pick <- 1

if (winning_door==1) hall_reveal<-sample(2:3,1)
if (winning_door==2) hall_reveal<-3
if (winning_door==3) hall_reveal<-2

switch_pick <- NULL
if (hall_reveal==3) switch_pick<-2
if (hall_reveal==2) switch_pick<-3

if (initial_pick==winning_door) no_switch=c(no_switch, "win") else no_switch=c(no_switch, "lose")
if (switch_pick==winning_door) switch=c(switch, "win") else switch=c(switch, "lose")

}

# second attempt

resample <- function(x, ...) x[sample.int(length(x), ...)] # need this bc sample messes up with length 1 vectors

doors <- c(1:3)
switch_strategy<-NULL
noswitch_strategy<-NULL

for(i in 1:1000) {
  (winning_door <- sample(doors,1))
  (initial_pick <- sample(doors,1))
  (monty_reveal <- resample(doors[-c(initial_pick, winning_door)],1))
  
  (switch_pick <- doors[-c(initial_pick, monty_reveal)])
  
  if(winning_door==initial_pick) {
    noswitch_strategy<-c(noswitch_strategy, "win") 
    switch_strategy<-c(switch_strategy, "lose")
  } else {
    noswitch_strategy<-c(noswitch_strategy, "lose") 
    switch_strategy<-c(switch_strategy, "win")    
  }
}

best_strategy <- c(sum(switch_strategy=="win"), sum(noswitch_strategy=="win"))
names(best_strategy) <- c("switch", "no_switch")
(best_strategy)

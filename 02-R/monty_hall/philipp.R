# refined attempt (generalized for every door choice, uses vectors)

trials <- 1000 # edit per desired number of trials

resample <- function(x, ...) x[sample.int(length(x), ...)] # need this bc sample messes up with length 1 vectors
doors <- c(1:3)
switch_strategy<-NULL
noswitch_strategy<-NULL

for(i in 1:trials) {
  winning_door <- sample(doors,1)
  initial_pick <- sample(doors,1)
  monty_reveal <- resample(doors[-c(initial_pick, winning_door)],1)
  
  switch_pick <- doors[-c(initial_pick, monty_reveal)]
  
  # I realize that I technically don't need to populate more than one vector here, but what the heck...
  if(winning_door==initial_pick) {
    noswitch_strategy<-c(noswitch_strategy, "win") 
    switch_strategy<-c(switch_strategy, "lose")
  } else {
    noswitch_strategy<-c(noswitch_strategy, "lose") 
    switch_strategy<-c(switch_strategy, "win")    
  }
}

best_strategy <- c(sum(switch_strategy=="win"), sum(noswitch_strategy=="win"))/trials

cat("Win probability if not switching: \n")
print(best_strategy[2])
cat("Win probability if switching:\n")
print(best_strategy[1])


# # DISREGARD
# # first attempt (no vectors)
# 
# switch <- NULL
# no_switch <- NULL
# 
# for (i in 1:100) {
# 
# winning_door <- sample(1:3,1)
# initial_pick <- 1
# 
# if (winning_door==1) hall_reveal<-sample(2:3,1)
# if (winning_door==2) hall_reveal<-3
# if (winning_door==3) hall_reveal<-2
# 
# switch_pick <- NULL
# if (hall_reveal==3) switch_pick<-2
# if (hall_reveal==2) switch_pick<-3
# 
# if (initial_pick==winning_door) no_switch=c(no_switch, "win") else no_switch=c(no_switch, "lose")
# if (switch_pick==winning_door) switch=c(switch, "win") else switch=c(switch, "lose")
# 
# }



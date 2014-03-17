# Simple solution to the Monty Hall problem - deriving the simplest algorithm leads to the simplest explanation!
# With three doors, only way to win if don't switch is if you picked the winner at first
#    only way to win if you do switch is if you didn't pick the winner at first since Monty opens the only other non-winning door for you
# Possible improvements - vectorize, arbitrary number of doors

doors = 1:3
trials = 500
counter = 0
running_percent = vector("numeric", trials)

for (i in 1:trials)    {
  winner <- sample(doors,1)
  mypick <- sample(doors,1)
  
  #simulate "never switch" strategy
  if (winner == mypick)   {
    counter <- counter+1
  }
  running_percent[i] <- counter/i    # keep track of running average to create convergence chart
    
  # simulate "always switch" strategy
  # only win if I had not already picked the winner, no need to open doors, Monty will open the goat for me
  # NOT SHOWN - same as above except increment counter when winner != mypick
  
}

plot(1:trials,running_percent)
print(running_percent[trials])



# NOT USED - early test code to implement door opening - not necessary!
# remaining_doors = sample(doors[doors!=mypick],2)
# if (winner!=remaining_doors[1] )   {
#   print(paste("Opening door #", as.character(remaining_doors[1]), sep=""))  
# } else{
#   print(paste("Opening door #", as.character(remaining_doors[2]), sep=""))
# }


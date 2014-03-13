### function: monty()
### argument: numtries = number of simulations to run
### example: monty(50000)

monty <- function(numtries) {
    
    ## APPROACH 1: NOT SWITCHING
    
    # create a vector to store the results of not switching
    dontswitch <- vector(mode="logical", length=numtries)
    
    for(i in 1:numtries) {
    
        # which door has the car?
        car <- sample(1:3, 1)
 
        # I make a guess, and don't switch it
        guess <- sample(1:3, 1)
    
        # check if I won
        if(car == guess) {
            dontswitch[i] <- TRUE
        }
    }
    
    ## APPROACH 2: SWITCHING
    
    # create a vector to store the results of switching
    doswitch <- vector(mode="logical", length=numtries)
    
    for(i in 1:numtries) {
        
        # which door has the car?
        car <- sample(1:3, 1)
        
        # I make a guess
        guess <- sample(1:3, 1)
        
        # The following if/else code is completely unnecessary, because
        # if you pick incorrectly and then switch you are guaranteed to win.
        # And if you pick correctly and then switch you are guaranteed to lose.
        # Nevertheless, it's good to write for demo purposes.
        
        if(car != guess) {
            # I picked incorrectly, and they open the other door
            theyopen <- 6-car-guess
            # I switch my guess to be not my original guess, nor the one they opened
            newguess <- 6-theyopen-guess
        } else {
            # I picked correctly, and they open one other door
            if(car == 1) {
                theyopen <- sample(c(2,3), 1)
            } else if(car == 2) {
                theyopen <- sample(c(1,3), 1)
            } else {
                theyopen <- sample(c(1,2), 1)
            }
            # I switch my guess to be not my original guess, nor the one they opened
            newguess <- 6-theyopen-guess
        }
        
        # check if I won
        if(car == newguess) {
            doswitch[i] <- TRUE
        }
    }
    
    # calculate the win probability for each approach
    dontswitch.won <- sum(dontswitch)/numtries
    doswitch.won <- sum(doswitch)/numtries
    
    # print the results
    cat("Win probability if not switching:\n")
    print(dontswitch.won)
    cat("Win probability if switching:\n")
    print(doswitch.won)
    
}
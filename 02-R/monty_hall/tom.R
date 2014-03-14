inputs <- commandArgs(trailingOnly = TRUE)

## Reading the # of iterations from command line, otherwise defaulting to 1000
iterations <- ifelse(length(inputs) > 0 & !is.na(as.integer(inputs[1])), inputs[1], 1000)

items <- c('1'="goat", '2'="goat", '3'="car")

monty_hall <- function(x){
    draw <- sample(items, 3) #normally bad form to call global from inside function but this is R, and re-instantiating an object, however small, is an even bigger sin.
    ## also we're sampling the entire set here to do a random sort and then picking the first element as our selection
    choice <- draw[1]
    doors_left <- sample(draw[2:3],2)

    ## ie, since we sampled the remaining doors, we can assume that we're randomly picking door #1.  If door #1 is a car, we'll "display" door #2, then set door #1 to the result of the 1 door remaining.  If door #1 is a goat, we'll show door #1 and door #2 will be set to the result.
    door_remain <- ifelse(doors_left[1]=='goat', doors_left[2], doors_left[1])
    
    swap_doors <- sample(0:1, 1)
    ## boolean coersion 
    result <- ifelse(swap_doors, door_remain, choice)
    
    return(data.frame(iteration=x, switch_doors=swap_doors, win=ifelse(result=='car', 1, 0)))    
}

results <- lapply(1:iterations, monty_hall)
results <- do.call('rbind', results)

print(aggregate(win ~ switch_doors, data=results, mean))

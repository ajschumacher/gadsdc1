## Reading the # of iterations from command line, otherwise defaulting to 1000
inputs <- commandArgs(trailingOnly = TRUE)
iterations <- ifelse(length(inputs) > 0 & !is.na(as.integer(inputs[1])), inputs[1], 1000)

items <- c('1'="goat", '2'="goat", '3'="car")

monty_hall <- function(x){
    draw <- sample(items, 3) #normally bad form to call global from inside function but this is R, and re-instantiating an object is bad too.
    ## also we're sampling the entire set here to do a random sort and then picking the first element as our selection
    choice <- draw[1]
    doors_left <- sample(draw[2:3],2)

    ## ie, since we sampled the remaining doors, we can assume that we're randomly picking door #1.  If door #1 is a car, we'll "display" door #2, then set door #1 to the outcome of the 1 door remaining.  If door #1 is a goat, we'll show door #1 and door #2 will be set to the outcome.
    door_remain <- ifelse(doors_left[1]=='goat', doors_left[2], doors_left[1])
    
    swap_doors <- sample(0:1, 1)
    outcome <- ifelse(swap_doors, door_remain, choice)
    
    return(data.frame(iteration=x, switch_doors=swap_doors, win=ifelse(outcome=='car', 1, 0)))    
}

results <- lapply(1:iterations, monty_hall)
results <- do.call('rbind', results)
## Collapsing results by category (switch_doors)
print(aggregate(win ~ switch_doors, data=results, mean))


if(0){  ## not run
    swap_yes <- subset(results, switch_doors==1)
    swap_no <- subset(results, switch_doors==0)

    max_plot <- max(c(nrow(swap_yes), nrow(swap_no)))
    plot(1:max_plot, seq(0, 1, 1/(max_plot-1)), xlab="iterations", ylab="win percentage", type='n', las=1,frame.plot='false')
    
    swap_yes$mavg <- sapply(1:nrow(swap_yes), function(x) mean(swap_yes$win[1:x]))
    swap_no$mavg <- sapply(1:nrow(swap_no), function(x) mean(swap_no$win[1:x]))
    
    ## data plotting
    points(1:nrow(swap_yes), swap_yes$mavg, col='blue')
    points(1:nrow(swap_no), swap_no$mavg, col='dark red')
    
    ## expectation plotting
    abline(h=2/3, col='blue', lty = 2)
    abline(h=1/3, col='red', lty = 2)
}
inputs <- commandArgs(trailingOnly = TRUE)

## Reading the # of iterations from command line, otherwise defaulting to 1000
iterations <- ifelse(length(inputs) > 0 & !is.na(as.integer(inputs[1])), inputs[1], 1000)

items <- c('1'="goat", '2'="goat", '3'="car")

monty_hall <- function(x){
    draw <- sample(items, 3) #normally bad form to call global from inside function but this is R, and re-instantiating an object, however small, is an even bigger sin.
    
    choice <- draw[1]
    doors_left <- draw[2:3]
    
    door_opened <- sample(names(doors_left)[doors_left=='goat'],1)
    door_remain <- doors_left[names(doors_left)!= door_opened]
    
    swap_doors <- sample(0:1, 1)

    result <- ifelse(swap_doors, door_remain, choice)
    
    return(data.frame(iteration=x, switch_doors=swap_doors, win=ifelse(result=='car', 1, 0)))    
}

results <- lapply(1:iterations, monty_hall)
results <- do.call('rbind', results)

print(aggregate(win ~ switch_doors, data=results, mean))

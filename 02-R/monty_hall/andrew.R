SingleMonty <- function(){
  switch <- sample(c(T, F), 1)
  
  doors <- sample(c(F, F, T), 3, replace=F)
  car_index <- which(doors, T)
  print(paste('the car is behind door number:', as.character(car_index)))
  
  selection <- sample(c(F, F, T), 3, replace=F)
  choice_index <- which(selection, T)
  print(paste('you choose door number: ', as.character(choice_index)))
  
  remainder <- as.character(which((doors|selection) %in% c(F)))
  print(remainder)
  reveal_index <- as.numeric(sample(c(remainder), 1))
  print(paste('door number', as.character(reveal_index), 'is revealed to have a goat'))
  
  if (switch) {
    choice_index <- which(!c(1, 2, 3)%in%c(choice_index, reveal_index), T)
    print(paste('you switch your choice to:', choice_index))
  } else {
    print(paste('you stay strong with your choice of:', choice_index))
  }
  
  if (doors[choice_index]) {
    win <- T
    print('you win the car!')
  } else {
    win <- F
    print('you lose!')
  }
  print("-------------")
  return(data.frame(switch=as.numeric(switch), win=as.numeric(win)))
}

FullMonty <- function(plays) {
  results <- data.frame()
  for (p in 1:plays) {
    r <- SingleMonty()
    results <- rbind(results, r)
  }
  results$trials <- 1:plays
  return(results)
}

plays <- 1000
results <- FullMonty(plays)
results_summary <- aggregate(win ~ switch, data=results, FUN=mean)


SingleMonty <- function(){
  switch <- sample(c(T, F), 1)
  doors <- sample(c(F, F, T), 3, replace=F)
  car_index <- which(doors, T)
  selection <- sample(c(F, F, T), 3, replace=F)
  choice_index <- which(selection, T)
  remainder <- as.character(which((doors|selection) %in% c(F)))
  reveal_index <- as.numeric(sample(c(remainder), 1))
  if (switch) {
    choice_index <- which(!c(1, 2, 3)%in%c(choice_index, reveal_index), T)
  }
  if (doors[choice_index]) {
    win <- T
  } else {
    win <- F
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


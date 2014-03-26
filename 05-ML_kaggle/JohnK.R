library(class)
tenfold.cross.validator <- function(train.data, labels, K) {
  num <- length(train.data)
  result.set <- list(1:10)
  for(n in 1:10) {
    indices <- sort(sample(1:num, round(0.5 * num)))
    train.set <- train.data[indices]
    test.set <- train.data[-indices]
    
    result.set[num] <- knn(train.set, test.set, labels, k=K)
  }    
}
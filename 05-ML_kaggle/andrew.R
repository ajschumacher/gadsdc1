# clear some space
rm(list=ls())

# bring in my kNN implementation
kNN <- function(d.train, d.test, l.train, k, dist.function) {
  output <- apply(d.test, 1, FUN=function(x) {
    scores <- apply(d.train, 1, FUN=function(y) { dist.function(y, x) })
    k_rows <- order(scores)[1:k]
    label <- names(sort(table(l.train[k_rows]), decreasing=T))[1]
    return(label)
  })
  return(output)
}

# define an example distance function
Euclidean <- function(x, y) {
  return(sqrt(sum((x-y)^2)))
}

# define an n fold cross validation function
nFoldCrossVal <- function(data, labels, n, CLASS, ...) {
  #split the data
  split <- sample(n, nrow(data), replace=T)
  
  # apply accross splits and return accuracies
  accuracies <- sapply(1:n, function(i){
    d.test <- data[split==i, ]
    d.train <- data[split!=i, ]
    l.test <- labels[split==i]
    l.train <- labels[split!=i]
    result <- CLASS(d.train, d.test, l.train, ...)
    score <- sum(result==l.test)/length(l.test)
    return(score)
  })
  
  # return the mean of the accuracies
  final_score <- mean(accuracies)
  return(final_score)
}


nFoldCrossVal(iris[, 1:4], iris[, 5], 10, knn, k=3, dist.function=Euclidean)
accuracies <- sapply(1:40, function(x) {
  a <- nFoldCrossVal(iris[, 1:4], iris[, 5], 10, kNN, k=x, dist.function=Euclidean)
  return(a)
})
plot(1:40, accuracies)
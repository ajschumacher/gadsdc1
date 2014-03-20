# Define a couple example distance functions
Euclidean <- function(x, y) {
  return(sqrt(sum((x-y)^2)))
}

Manhattan <- function(x, y) {
  return(sum(x-y))
}

# My K nearest neighbors implementation
kNN <- function(k, d.train, d.test, lables, dist.function) {
  output <- apply(d.test, 1, FUN=function(x) {
    scores <- apply(d.train, 1, FUN=function(y) { dist.function(y, x) })
    k_rows <- order(scores)[1:k]
    label <- names(sort(table(labels[k_rows]), decreasing=T))[1]
    return(label)
  })
  return(output)
}

# A function to compare the results of the kNN to actual values
Compare <- function(l.test, l.result) {
  correct <- sum(as.numeric(l.test == l.result))
  percent <- correct/length(l.test)
  return(percent)
}

# Splitting the iris dataset into training and testing sets
train_rows <- sample(1:150, 100)
test_rows <- (1:150)[!(1:150)%in%train_rows]
d.train <- iris[train_rows, 1:4]
l.train <- iris[train_rows, 5]
d.test <- iris[test_rows, 1:4]
l.test <- iris[test_rows, 5]

# kNN-ing 
kNN_Euclidean_5 <- kNN(5, d.train, d.test, labels, Euclidean)
kNN_Manhattan_5 <- kNN(5, d.train, d.test, labels, Manhattan)
Compare(l.test, kNN_Euclidean_5)
Compare(l.test, kNN_Manhattan_5)

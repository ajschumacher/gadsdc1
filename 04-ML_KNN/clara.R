# Define a function as described to implement 1NN

one.nearest.neighbor <- function(test_data, training_data, labels) {
  test.data.labels <- apply(test_data, 1, one.nearest.neighbor.single, training_data, labels)
  return(test.data.labels)
}

euclidean.distance <- function(vector1, vector2) {
  diff.vector = vector2 - vector1
  dot.product.sum <- diff.vector %*% diff.vector
  return(sqrt(dot.product.sum))
}
# euclidean.distance(c(0, 3), c(4, 0))

one.nearest.neighbor.single <- function(test_vector, training_data, labels) {
  distances <- apply(training_data, 1, euclidean.distance, test_vector)
  shortest.distance <- min(distances)
  short.dist.index <- match(shortest.distance, distances)
  return(labels[short.dist.index])
}
# one.nearest.neighbor.single(c(5, 4, 4, 3), training_data[, 1:4], training_data[, 5])

data_chooser <- as.logical(sample(c(0, 1), 150, replace=TRUE))
training_data <- iris[data_chooser, ]
test_data <- iris[!data_chooser, ]

test.labels <- one.nearest.neighbor(test_data[, 1:4], training_data[, 1:4], training_data[, 5])
correct.test.labels <- mapply("==", test.labels, test_data$Species)
print(c("1NN Correctness:", sum(correct.test.labels)/length(correct.test.labels)))

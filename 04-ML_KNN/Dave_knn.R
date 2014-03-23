#making the function
distance <- function(x, y){
  sqrt(sum((x-y)^2))
}

knnfun <- function(traindata, labels, testdata){
  testlabels <- c()
  for(i in 1:nrow(testdata)) { 
    distfun <- apply(traindata, 1, distance, testdata[i, ])
    testlabels <- c(testlabels, labels[which.min(distfun)])
    }
  return(testlabels)
}

#create the training set
iris_sample <- sample(1:nrow(iris), 100, replace=FALSE)
iris_training <- iris[iris_sample, 1:4]
iris_training_labels <- as.character(iris[iris_sample, 5])
iris_test <- iris[-iris_sample,1:4]

#generate the results
iris_test_labels <- knnfun(iris_training, iris_training_labels, iris_test)



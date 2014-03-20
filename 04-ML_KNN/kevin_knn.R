# function: myknn()
#
# arguments: train (data frame of numeric training data)
#            train.class (vector of labels for training data)
#            test (data frame of numeric test data)
#            k (nearest neighbors to examine, default=1)
#
# returns: vector of predicted labels for test data

myknn <- function(train, train.class, test, k=1) {
    
    # initialize empty vector for predicted class labels
    test.class <- vector(length=nrow(test))
    
    for(i in 1:nrow(test)) {
        
        # compute Euclidian distances between a single row of the test data
        # ...and all rows of the training data
        distances <- apply(train, 1, function(m,n) sqrt(sum((m-n)^2)), test[i, ])
        
        # order the distances
        distances.order <- order(distances)
        
        # get the k class labels that are nearest to the row of test data
        nearest <- vector(length=k)
        for(j in 1:k) {
            nearest[j] <- train.class[distances.order[j]]
        }
        
        # of the k class that are nearest, pick the most common
        # note: this does not do random tiebreaking, which would be better
        test.class[i] <- which.max(tabulate(nearest))
    
    }
    
    # return a factor instead of integers
    factor(test.class, labels=levels(train.class))
    
}



### Let's try it out! ###

# split the Iris data into a training set (100) and test set (50)
set.seed(10)
train.index <- sample(1:150, 100)
iris.train <- iris[train.index, 1:4]
iris.train.class <- iris[train.index, 5]
iris.test <- iris[-train.index, 1:4]
iris.test.class <- iris[-train.index, 5]


### K = 1

# use myknn() with k=1
iris.mypred <- myknn(iris.train, iris.train.class, iris.test, k=1)
table(iris.mypred, iris.test.class, dnn=c("predicted", "actual"))

#            actual
#predicted    setosa versicolor virginica
#  setosa         16          0         0
#  versicolor      0         14         2
#  virginica       0          2        16

# compare the results with the official knn() function
library(class)
set.seed(13)
iris.pred <- knn(iris.train, iris.test, iris.train.class, k=1)
table(iris.pred, iris.test.class, dnn=c("predicted", "actual"))

#            actual
#predicted    setosa versicolor virginica
#  setosa         16          0         0
#  versicolor      0         14         2
#  virginica       0          2        16


### K = 3

# use myknn() with k=3
iris.mypred <- myknn(iris.train, iris.train.class, iris.test, k=3)
table(iris.mypred, iris.test.class, dnn=c("predicted", "actual"))

#            actual
#predicted    setosa versicolor virginica
#  setosa         16          0         0
#  versicolor      0         13         1
#  virginica       0          3        17

# use knn() with k=3
set.seed(13)
iris.pred <- knn(iris.train, iris.test, iris.train.class, k=3)
table(iris.pred, iris.test.class, dnn=c("predicted", "actual"))

#            actual
#predicted    setosa versicolor virginica
#  setosa         16          0         0
#  versicolor      0         13         1
#  virginica       0          3        17

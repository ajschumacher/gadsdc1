## 1NN on Iris 

## Pull this out because I hate invisible data sets.
mydata <- iris 

## Create a sample of 20 for testing set.
test_index <- sample(seq_along(mydata$Species), 20, replace=FALSE)
train <- mydata[-test_index,]
test <- mydata[test_index,]

knn_one <- function(test_data, training_data) {
    min_find <- apply(training_data[,1:4], 1, function(x,y) dist(rbind(x,y)), test_data)
    return(training_data[which.min(min_find),'Species'])    
}

test$predicted <- apply(test[,1:4], 1, knn_one, train)
cat("Success Rate: ", nrow(subset(test, Species==predicted)), " of 20.", fill=TRUE)
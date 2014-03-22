## 1NN on Iris 

## Create a sample of 20 for testing set.
normalize <- function(x) (x-mean(x))/sd(x)
normalized_data <- iris
normalized_data[,1:4] <- lapply(iris[,1:4], normalize)
regular_data <- iris

RunKNN <- function(mydata){
    test_index <- sample(seq_along(mydata$Species), 20, replace=FALSE)
    train <- mydata[-test_index,]
    test <- mydata[test_index,]

    knn_one <- function(test_data, training_data) {
        min_find <- apply(training_data[,1:4], 1, function(x,y) dist(rbind(x,y)), test_data)
        return(training_data[which.min(min_find),'Species'])    
    }

    test$predicted <- apply(test[,1:4], 1, knn_one, train)
    return(nrow(subset(test, Species==predicted)))
}

norm_result <- replicate(100, RunKNN(normalized_data))
reg_result <- replicate(100, RunKNN(regular_data))
cat("Normalized Result: ", mean(norm_result), fill=TRUE)
cat("Non-normed Result: ", mean(reg_result), fill=TRUE)


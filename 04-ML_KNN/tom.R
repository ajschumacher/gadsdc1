## 1NN on Iris 

## Create a sample of 20 for testing set.
normalize <- function(x) (x-mean(x))/sd(x)
normalized_data <- iris
normalized_data[,1:4] <- lapply(iris[,1:4], normalize)
regular_data <- iris

RunKNN_apply <- function(mydata){
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

RunKNN_merge <- function(mydata){
## This is how you would kinda do it in a database.
    test_index <- sample(seq_along(mydata$Species), 20, replace=FALSE)
    train <- mydata[-test_index,]
    test <- mydata[test_index,]

    knn_one <- function(test_data, training_data) {
        test_data$key <- seq_along(test_data[,1])
        big_df <- merge(training_data, test_data, by=NULL, all=TRUE)
        big_df$distance <- apply(big_df[,c(1:4,6:9)], 1, function(x){
            dist(rbind(c(x[1:4]), c(x[5:8])))
        })
        index <- aggregate(distance ~ key, data=big_df, which.min)
        return(big_df$Species[index$distance])
    }
    test$predicted <- knn_one(test[,1:4], train)
    return(nrow(subset(test, Species==predicted)))
}

norm_result <- replicate(100, RunKNN(normalized_data))
reg_result <- replicate(100, RunKNN(regular_data))
cat("Normalized Result: ", mean(norm_result), fill=TRUE)
cat("Non-normed Result: ", mean(reg_result), fill=TRUE)

system.time(replicate(20, RunKNN_apply(normalized_data)))
system.time(replicate(20, RunKNN_merge(normalized_data)))
## RunKNN_merge runs a lot slower in R.  Sadfase.



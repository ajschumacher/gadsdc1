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
        big_df$distance <- sqrt((big_df[,1]-big_df[,6])^2 + 
            (big_df[,2]-big_df[,7])^2 + 
            (big_df[,3]-big_df[,8])^2 + 
            (big_df[,4]-big_df[,9])^2)
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

# > system.time(replicate(20, RunKNN_apply(normalized_data)))
   # user  system elapsed 
   # 4.56    0.00    4.57 
# > system.time(replicate(20, RunKNN_merge(normalized_data)))
   # user  system elapsed 
   # 0.90    0.00    0.89 
## BOOYA!
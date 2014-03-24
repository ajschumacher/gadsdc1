# where are we so far?  have knn implemented for any k, should work with numeric and factor variables
# found that performance is a lot better with matrix rather than dataframe - basic scrubbing to remove factors

rm(list=ls())
data(iris)

# HELPER FUNCTIONS - split data into train and test sets, clean data frames into matrices for speed----------------

create_train_and_test <- function(data, split_percent = .5) {
  # function takes full data set and split into train and test set (really cross-validation?)
  # split_percent specifies how much of data to put into training set  
  
  total_obs <- 1:nrow(data)         # define vector 1:n to simplify getting complement of the random training sample below
  
  train_idxes <- sort(sample(total_obs, nrow(data)*split_percent, replace=F))
  test_idxes <- total_obs[-train_idxes]   
  
  train_data <- data[train_idxes,]
  test_data <- data[test_idxes,]
  
  return(list(train_data, test_data))  # return train and test as a list - way to return multiple outputs
}



matrixify <- function(data)   {  
  levels_list = list()      # create optional output list to capture levels of converted factors
  for (ii in 1:ncol(data))   {       # brief error checking of limited usefulness
    if (is.factor(data[,ii])) {
      levels_list[ii] <- list(levels(data[,ii]))
    }    
    if (is.character(data[,ii]))   {
      print("Uh oh, characters found. . .")
    }    
    data[,ii] <- as.numeric(data[,ii])     # convert each col to numeric - note: should have error checking here!
  }  
  data <- as.matrix(data)       # finally convert data to matrix - will retain rownames and colnames!
  return(data)
  
}


# A VARIETY OF KNN ALTERNATIVES FOR TESTING -------------------------------------------------

myknn_withk <- function(train_data, train_labels, test_data, k=1)  {
  # Take in data frames of data and labels, converts to matrix for speed, outputs data frame of labels for test_data
  # Can also look at k neighbors to determine winner - takes most frequent value of the resulting set of labels
  
  # convert data to matrix for speed (should handle numeric and factor variables but not chars)
  train_data <- matrixify(train_data)  
  test_data <- matrixify(test_data)
  
  # initialize output
  test_labels = c()  
  
  # Create helper function to use within apply step below - computes euclidean distance between x and y
  dist_helper <- function(x,y)    {
    return(dist(rbind(x,y)))
  }
  
  # for loop over test_data using apply to compute distances of each point from train_data
  # doubleapply actually increased running time by ~1% for iris with 75% as train - implemented separately
  for (ii in 1:nrow(test_data))     {
    dist_vector <- apply(train_data, 1, dist_helper, y=test_data[ii,])   # creates vector of distances from current test point to all points in training set
    dist_and_label <- cbind(dist_vector, train_labels)   # create a matrix that includes distances and labels for sorting
    dist_and_label <- dist_and_label[order(dist_and_label[,1]),]  # sort the matrix by distance
    winner <- names(        # take a table to count label frequencies of k nearest neighbors and return the winner
      which.max(
        table(
          dist_and_label[1:k,2])))   
    test_labels <- c(test_labels,as.numeric(winner))   # returned as a char, convert to numeric to make the factors work below
  }
  
  # convert output to a factor with original levels
  test_labels <- factor(test_labels)
  levels(test_labels) <- levels(train_labels)    
  return(test_labels)
  
}

# THE ORIGINAL FUNCTION 
# myknn <- function(train_data, train_labels, test_data)  {
#   # Main function - takes in train_data and test_data data frames of features plus factor of labels on the training data
#   # Outputs predicted factor of labels for test_data
#   
#   # Initialize output as a char vector - will convert to factor later
#   test_labels = rep("TBD",nrow(test_data))
#   
#   # Create helper function to use within apply step below - computes euclidean distance between x and y
#   dist_helper <- function(x,y)    {
#     return(dist(rbind(x,y)))
#   }
#   
#   for (ii in 1:nrow(test_data))     {
#     dist_vector <- apply(train_data, 1, dist_helper, y=test_data[ii,])   # creates vector of distances from current test point to all points in training set
#     ii_min <- which.min(dist_vector)          # datatypes note: names(ii_min) = original idx in the full data set, ii_min = idx in train_data
#     test_labels[ii] <- train_labels[ii_min]    # assign test_label of current point to label of closest point in test set
#   }
#   
#   test_labels <- factor(test_labels)
#   levels(test_labels) <- levels(train_labels)     # convert to a factor for consistency - couldn't do in one step?
#   return(test_labels)
#   
# }
# 
# 
# THE ORIGINAL FUNCTION WITH DOUBLE APPLY RATHER THAN FOR LOOP AND APPLY
# myknn_doubleapply <- function(train_data, train_labels, test_data)  {
#   # Main function - takes in train_data and test_data data frames of features plus factor of labels on the training data
#   # Outputs predicted factor of labels for test_data
#   # same as above except done without for loops - use apply to loop through both test and train
#   
#   test_labels = rep("TBD",nrow(test_data))
#   
#   # Create helper function to use within apply step below - computes euclidean distance between x and y
#   # Note: here's where you would change the norm
#   dist_helper <- function(x,y)    {
#     return(dist(rbind(x,y)))
#   }
#   
#   # Create another helper to accomplish what would be inside a for loop for the test data
#   test_loop_helper <- function(y, train_data)  {
#     dist_vector <- apply(train_data, 1, dist_helper, y)   # one apply inside the function to loop through train_data
#     ii_min <- which.min(dist_vector)          
#     test_labels <- train_labels[ii_min]
#     return(test_labels)
#   }
#   
#   test_labels <- apply(test_data,1,test_loop_helper,train_data=train_data)   # the magic second apply
#   
# 
#   test_labels <- factor(test_labels)
#   levels(test_labels) <- levels(train_labels)     # convert to a factor for consistency - couldn't do in one step?
#   return(test_labels)
#   
# }
# 
# 



# NOW FOR THE MAIN EVENT--------------------------------------

# apply the function to split into train and test and create feature and label structures
# Could modify data and split_percent - inputs to a function!
train_outputs <- create_train_and_test(data = iris, split_percent = .75)
full_train_data <- train_outputs[[1]]
full_test_data <- train_outputs[[2]]

train_data <- full_train_data[1:4]
train_labels <- full_train_data[[5]]
test_data <- full_test_data[1:4]
test_labels <- full_test_data[[5]]


# run full knn - with matrixify and settable k
mytime<-system.time(predicted_labels <- myknn_withk(train_data, train_labels, test_data,k=5))
accuracy <- 1-sum(predicted_labels != test_labels)/length(test_labels)
print(mytime)
print(accuracy)


# Call main knn function and measure accuracy - without matrixify!
# mytime<-system.time(predicted_labels <- myknn(train_data, train_labels, test_data))
# accuracy <- 1-sum(predicted_labels != test_labels)/length(test_labels)
# print(mytime)
# print(accuracy)


# # Whew, that's slow!  Try to convert train and test as matrix -------------------------
# 
# train_data<-as.matrix(train_data)
# test_data<-as.matrix(test_data)
# 
# # Call main knn function and measure accuracy - with externally produced matrices
# mytime<-system.time(predicted_labels <- myknn(train_data, train_labels, test_data))
# accuracy <- 1-sum(predicted_labels != test_labels)/length(test_labels)
# print(mytime)
# print(accuracy)


# # Note: Double Apply actually increases system time by 1%! - note: does not include matrixify
# mytime<-system.time(predicted_labels <- myknn_doubleapply(train_data, train_labels, test_data))
# accuracy <- 1-sum(predicted_labels != test_labels)/length(test_labels)
# print(mytime)
# print(accuracy)

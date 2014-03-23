#Implement a one-nearest-neighbor algorithm as a function in R that 
#takes three arguments:
  
# A data frame of numeric columns, the training data.
# A vector of labels for the training data.
# A data frame with the same columns as the first data frames, this one 
# the data to predict for.
# The function should return a vector of predicted labels for the test data. 
# Choose a function name and a distance metric to use. 
# You can test your function with the iris data.

# Define a function as described to implement 1NN

library(plyr)

my_function_name <- function(training_data, labels, test_data) {}

euc_distance <- function(a, b){
  dist <- sqrt(sum((a - b)**2))
}
#currently, knn_function just returns the shortest distance computed.  
#Need to modify it to return the actual row from which the shortest distance
#is computed.  
# knn_function <- function(tst_iris, trn_iris) {
#   apply(tst_iris, 1, function(tst_row) {
#   return(min(apply(trn_iris, 1, function(trn_row) {
#     return(sqrt(sum((tst_row[1:4] - trn_row[1:4])**2)));
#     })))
#   })
# }
#apply(train_iris, 1, function(m,n) return(m - n), .5)
#container
test_labels <- as.character(seq_len(nrow(test_data)))

for (row_num in nrow(test_iris)) {
  dist_list <- apply(train_iris, 1, function(a,b) {
    euc_distance(a,b); } , test_iris[row_num,] 
)}


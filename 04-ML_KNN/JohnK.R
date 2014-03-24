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

#Doh!  Not supposed to use built in R features (like dist) so will do this the ugly way.  


first_nearest_neighbor <- function(training_data, labels, test_data) {

	euc_distance <- function(a, b){
	  dist <- sqrt(sum((a - b)**2))
	}


	test_labels <- as.character(seq_len(nrow(test_data)))

	for (test_row in 1:nrow(test_data)) {
	  	
	  	dist_list <- apply(training_data, 1, function(a,b) {
	    			euc_distance(a,b); 
	    		} , test_data[test_row,] 
		)
    nn.index <- match(min(dist_list), dist_list) #hmm, apparently which.min would do this too.
    
    test_labels[test_row] <- labels[nn.index]
    #Uncomment above line to turn in function after testing.  
    #test_labels[test_row] <- iris$Species[nn.index]
    	
	}

	return(test_labels)

}
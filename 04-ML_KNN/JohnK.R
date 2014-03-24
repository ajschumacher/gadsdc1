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

#Adding tests
#Need to pass an array of T,F to iris to make my random sample
sampled <- as.logical(sample(c(0,1), 150, replace=TRUE))

train.set <- iris[sampled, 1:4]
train.labels <- iris[sampled, 5]

test.set <- iris[!sampled, 1:4]

fnn.result <- first_nearest_neighbor(train.set, train.labels, test.set)

side.by.side <- cbind(fnn.result, as.character(iris[!sampled, 5]))
colnames(side.by.side) <- c("predicted", "actual")

# predicted    actual      
# [1,] "setosa"     "setosa"    
# [2,] "setosa"     "setosa"    
# [3,] "setosa"     "setosa"    
# [4,] "setosa"     "setosa"    
# [5,] "setosa"     "setosa"    
# [6,] "setosa"     "setosa"    
# [7,] "setosa"     "setosa"    
# [8,] "setosa"     "setosa"    
# [9,] "setosa"     "setosa"    
# [10,] "setosa"     "setosa"    
# [11,] "setosa"     "setosa"    
# [12,] "setosa"     "setosa"    
# [13,] "setosa"     "setosa"    
# [14,] "setosa"     "setosa"    
# [15,] "setosa"     "setosa"    
# [16,] "setosa"     "setosa"    
# [17,] "setosa"     "setosa"    
# [18,] "setosa"     "setosa"    
# [19,] "setosa"     "setosa"    
# [20,] "setosa"     "setosa"    
# [21,] "setosa"     "setosa"    
# [22,] "setosa"     "setosa"    
# [23,] "setosa"     "setosa"    
# [24,] "setosa"     "setosa"    
# [25,] "versicolor" "versicolor"
# [26,] "versicolor" "versicolor"
# [27,] "versicolor" "versicolor"
# [28,] "versicolor" "versicolor"
# [29,] "versicolor" "versicolor"
# [30,] "versicolor" "versicolor"
# [31,] "versicolor" "versicolor"
# [32,] "versicolor" "versicolor"
# [33,] "versicolor" "versicolor"
# [34,] "virginica"  "versicolor"
# [35,] "versicolor" "versicolor"
# [36,] "virginica"  "versicolor"
# [37,] "versicolor" "versicolor"
# [38,] "versicolor" "versicolor"
# [39,] "versicolor" "versicolor"
# [40,] "versicolor" "versicolor"
# [41,] "virginica"  "versicolor"
# [42,] "versicolor" "versicolor"
# [43,] "versicolor" "versicolor"
# [44,] "versicolor" "versicolor"
# [45,] "versicolor" "versicolor"
# [46,] "versicolor" "versicolor"
# [47,] "versicolor" "versicolor"
# [48,] "versicolor" "versicolor"
# [49,] "versicolor" "versicolor"
# [50,] "virginica"  "virginica" 
# [51,] "virginica"  "virginica" 
# [52,] "virginica"  "virginica" 
# [53,] "virginica"  "virginica" 
# [54,] "virginica"  "virginica" 
# [55,] "virginica"  "virginica" 
# [56,] "virginica"  "virginica" 
# [57,] "virginica"  "virginica" 
# [58,] "virginica"  "virginica" 
# [59,] "virginica"  "virginica" 
# [60,] "virginica"  "virginica" 
# [61,] "versicolor" "virginica" 
# [62,] "virginica"  "virginica" 
# [63,] "virginica"  "virginica" 
# [64,] "virginica"  "virginica" 
# [65,] "virginica"  "virginica" 
# [66,] "virginica"  "virginica" 
# [67,] "versicolor" "virginica" 
# [68,] "virginica"  "virginica" 
# [69,] "versicolor" "virginica" 
# [70,] "virginica"  "virginica" 
# [71,] "virginica"  "virginica" 
# [72,] "virginica"  "virginica" 
# [73,] "virginica"  "virginica" 

side.by.side <- data.frame(side.by.side)
side.by.side[side.by.side$predicted != side.by.side$actual, 1:2]

# predicted     actual
# 34  virginica versicolor
# 36  virginica versicolor
# 41  virginica versicolor
# 61 versicolor  virginica
# 67 versicolor  virginica
# 69 versicolor  virginica
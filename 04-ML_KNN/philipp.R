#############################################################
# implementing k-nearest-neighbors prediction algorithm (k=1)
#############################################################

## JUST THE FUNCTION

knn_generate <- function(training_data, training_labels, test_data){
  apply(test_data, 
        1, 
        function(test_row) {
          training_labels[
            which.min(
              apply(training_data, 1, function(training_row){dist(rbind(training_row, test_row))})
            )
            ]
        }
  )
}

## TESTING THE FUNCTION

# # creating an implementing dataset
# iris_training <- iris[1:10,1:4]
# iris_training_labels <- iris[1:10, 5]
# iris_test <- iris[11:20,1:4]

# create real dataset (randomly select rows from training data to remove and send to test data)
iris_sample <- sample(1:nrow(iris), 10, replace=FALSE)
iris_training <- iris[iris_sample, 1:4]
iris_training_labels <- iris[iris_sample, 5]
iris_test <- iris[-training_sample,1:4]

# generate result
iris_test_labels <- knn_generate(iris_training, iris_training_labels, iris_test)

# benchmark predicted values against real values from dataset
benchmark_fake_real <- cbind(iris_test_labels,iris[-training_sample,5])
sum(benchmark_fake_real[,1]==benchmark_fake_real[,2])/nrow(benchmark_fake_real)
                                                

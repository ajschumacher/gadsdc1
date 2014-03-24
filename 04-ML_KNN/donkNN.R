#Implement a one-nearest-neighbor algorithm as a function in R that takes three arguments:
#A data frame of numeric columns, the training data.
#A vector of labels for the training data.
#A data frame with the same columns as the first data frames,
#this one the data to predict for.
#The function should return a vector of predicted labels for the test data.
#Choose a function name and a distance metric to use.
#You can test your function with the iris data.
#Define a function that calculates distance between two points
FindDistance <- function(train,test){
  distance <- sqrt(sum((train-test)^2))
  return(distance)
}
#Define a function that identifies a category of a record based upon its attributes.
OneKNN <- function(TrainingFrame, TrainingLabels, TestFrame) {
  # Develop a Distance Vector that returns the distances between every
  # Test coordinate and Training Coordinate
  for (i in 1:nrow(TestFrame)){
    DistanceVector <- apply(TrainingFrame,1, FindDistance, TestFrame[i,])
  }
  #Sort the resulting vector from lowest to highest distance
  SortedDistances <- sort(DistanceVector)
  #Return the Index of the lowest Distance Value
  ShortestDistanceIndex <- which.min(DistanceVector)
  #Assign the Specific Training Labels to a Resulting Vector based upon the Index value
  #of the shortest distance.
  ResultVector <- TrainingLabels[ShortestDistanceIndex]
  #return the result
  return(ResultVector)
}
# Checking the function works as I expect:
#
# First, generating both test and training datasets. This I totally stole from
# another student as i was having difficulty creating a test set of data that
# did not overlap the training set.
IrisSample <- sample(1:nrow(iris),120,replace=FALSE)
IrisTraining <- iris[IrisSample, 1:4]
IrisTest <- iris[-IrisSample,1:4]
IrisTrainingLabels <- as.character(iris[IrisSample,5])
# Call the function with the dataset I have generated.
ResultForIris <- OneKNN(IrisTraining, IrisTrainingLabels, IrisTest)
print(ResultForIris)

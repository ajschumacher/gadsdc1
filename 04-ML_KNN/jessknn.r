#Implement a one-nearest-neighbor algorithm as a function in R that takes three arguments:
#A data frame of numeric columns, the training data.
#A vector of labels for the training data.
#A data frame with the same columns as the first data frames, this one the data to predict for.


eucdist <- function(x, y) {
    return(sqrt(sum((x-y)^2)))}

jessknn <- function(traindata, trainlabels, testdata){
  apply(testdata, 1, function(testrow) {
    trainlabels[which.min(apply(traindata, 1, function(trainrow)
    {dist(rbind(trainrow, testrow))}))]})}

for testrow in 1:
	nrow(testdata)
	{dist_list <- apply(trainingdata, 1, function(a,b) {
	 eucdist(a,b);} , testdata[testrow])

index <- sample(1:125, 100)
traindata <- sample(1:125, 100)
trainlabels <- iris[index, 1:4]
testdata <- iris[index, 1:4]
iristestlabels <- jessknn(traindata, trainlabels, testdata)
 

my_e_dis <- function(x,y){
  z <- sqrt(sum(c((x[1]-y[1])^2, (x[2]-y[2])^2,(x[3]-y[3])^2,(x[4]-y[4])^2)));
}

my_knn <- function(trainingData, trainingDataLabel, testData, k=1, distanceMethod=1){
  
  res <- list()
  for (i in 1:dim(testData)[1]){
    min_dis <- apply(trainingData,1,my_e_dis, testData[i, ]);
    k_index <- which.min(min_dis);
    
    #And the result is
    #print (trainingDataLabel[k_index])
    
    res[i] <- trainingDataLabel[k_index];
  }
  
  return (res)
}


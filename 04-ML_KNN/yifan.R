
OneNN1 <- function(training_data, labels, test_data,rowTest,smallVec) {
  if(is.array(test_data) == T) {
    test_data_row <- test_data[rowTest]
  } else {
  test_data_row <- test_data[rowTest,]
  }
  smallPos = 1
  currentPos = 1
  smallDis=Inf
  fun1 <- function(v) {
    lol <- attr(v,"names")
    if(is.null(lol)) {
      result <- abs(v-test_data_row)
    } else {
    lol <- as.array(lol)
    result <- sqrt(sum(apply(lol,1,EuDis,v=v,test_data_row=test_data_row)))
    #result <- sqrt((v[c1]-test_data_row[1,c1])^2+(v[c2]-test_data_row[1,c2])^2+(v[c3]-test_data_row[1,c3])^2+(v[c4]-test_data_row[1,c4])^2)
    }
    if (result < smallDis) {
      smallDis <<- result
      smallPos <<- currentPos
    }
    currentPos <<- currentPos+ 1   
    return (smallPos)
  }
  if(is.atomic(training_data)){
    training_data <- as.array(training_data)
  }
  small <- apply(training_data,1,fun1)
  smallVec[rowTest] = tail(small,n=1) 
  rowTest <- rowTest-1
  if(rowTest > 0) {
     smallVec <- OneNN1(training_data,labels,test_data,rowTest,smallVec)  
  }
  return (smallVec)

}

EuDis <- function(c,v,test_data_row) {
  return ((v[c]-test_data_row[1,c])^2)
}

# Define a function as described to implement 1NN
OneNN <- function(training_data, labels, test_data) {
  if(is.atomic(test_data)) {
    test_data <- as.array(test_data)
  }
  rowTest <- nrow(test_data)
  smallVec <- rep(0,rowTest)
  smallVec <- OneNN1(training_data,labels,test_data,rowTest,smallVec)
  result = labels[smallVec]
  return (result)
}
###TEST WITH iris package,perfect
r1<-OneNN(iris[,1:4],iris[,5],iris[12:15,1:4]) 
if(identical(iris[12:15,5],r1)){print (T)}
###TEST With cars package, not perfect prediction, since just has one feature
r2<-OneNN(cars[,1],cars[,2],cars[,1])
if(identical(cars[,2],r2)){print (T)}
#Clear Environment
Compare(r2,cars[,2])
rm(OneNN,OneNN1,EuDis)


#create test sets from iris data
iris1.rows<-sample(nrow(iris),75, replace=FALSE)
iris.rows<-1:nrow(iris)
iris2.rows<-iris.rows[-sort(iris1.rows)]

to_guess<-iris[iris1.rows,1:4]
testing <-iris[iris2.rows,]
labels <-iris[iris1.rows,5]


nested_dude<-function(x,y){
  distance<-dist(rbind(x,y))
  return(distance)
}
knn <- function(to_guess, testing){
  distances<-vector("double",0)
  current_distance <- vector("double",0)

  for (x in nrow(to_guess)){

    current_distance<-rbind(current_distance,apply(testing[,1:4], 1, nested_dude, y = to_guess[x,]))

    min_distance<-which.min(current_distance)
    distances<-rbind(distances, min_distance)
  }
  return (distances)
}


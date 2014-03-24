
#create test sets from iris data
iris1.rows<-sample(nrow(iris),75, replace=FALSE)
iris.rows<-1:nrow(iris)
iris2.rows<-iris.rows[-sort(iris1.rows)]

to_guess<-iris[iris1.rows,1:4]
testing <-iris[iris2.rows,1:4]
to_guess.labels <-iris[iris1.rows,5]
testing.labels<-iris[iris2.rows,5]

get_distance<-function(x,y){
  distance<-dist(rbind(x,y))
  return(distance) 
}


min_finder<-function(x){
  which.min(x)
}


knn <- function(to_guess, testing){
  all_distances<-apply(testing, 1, get_distance, y = to_guess[1,])
  for (x in 2:nrow(to_guess))
    {
    #this now returns an array where each column represents one of the rows from the
    #to_guess set, and its row value is how far it is from that row in testing. 
    all_distances <- cbind(all_distances, apply(testing, 1, get_distance, y = to_guess[x,]))
    
  }
  all_distances<-cbind(all_distances,testing.labels)
  each_min <- apply(all_distances[1:75], 2, which.min)
  
}


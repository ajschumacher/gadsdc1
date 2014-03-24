howdy_neighbor <- function(dataset) {
    tmp.df <- dataset[sample(1:150,150),]
    distance <- rep(0,30)
    orig_flwr <- rep('',30)
    guessed_flwr <- rep('',30)
    results <- data.frame(distance,orig_flwr,guessed_flwr,stringsAsFactors=0)
    for ( j in 121:150) {
      mydist <- 1000
      for ( i in 1:120) {
          distance <- sqrt(sum((tmp.df[j,1:4]-tmp.df[i,1:4])**2))
          true_flower <- tmp.df[j,"Species"]
          if (distance < mydist) {
              assgn_flower <- tmp.df[i,"Species"]
              mydist <- distance
              #print(mydist) 
              #print(paste("assigned flower ", assgn_flower))
              #print(paste("true flower", true_flower))
          }
      results[j,] <- c(mydist,true_flower,assgn_flower)
        }
    }
return(results)
#to get sophisticated, and really be able to pass a generic dataset,
#    not just iris.  So I need to do row and column datacounts and set i and j 
#    to the appropriate values
}
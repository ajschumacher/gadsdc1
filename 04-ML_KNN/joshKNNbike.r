# okay, missed a good part of this class, so trying to force
# feed the material as I write this
# I'm basically learning this by rereading all lecture materials, 
# googling the hell out of KNN on the web and
# studying (aping) the brilliant code used by Kevin
# my personal rule is to not ape a technique unless I can figure out
# what it is, why he's using it, and why its better than the crude methods
# I've been trying to use

#I'm making this a function, honestly, because its required as part of
# assignment, but I realize this is an opportunity to use this on my bike data
#project.. so may actually be a great way to guess bike traffic based on time 
#of day.. or month.. or day of the week... awesome.

# start the function by defining it.. see ?function for better description.. notice my
# variable names are super-duper obvious.. cuz my memory sucks and I get confused
joshKNNbike <- function(original_dataframe, dataframe_labels, testing_dataframe, kvalue) {
  
  #make empty vector for outputted, predicted labels, ensure vector matches size of testing
  #dataframe using R's built in rowcounting function "nrow", then use "vector" instance to
  #generate an empty vector of the appropriate size.  see ?nrow and ?vector for more details
  testing_dataframe_label <- vector(length = nrow(testing_dataframe))
  #okay, so now we begin a "for" loop.. this is a good way to tackle the problem, because the
  #for loop lets you go through the table one line at a time, and you can set it to run for
  #exactly the number of rows you have.. but you already know this.. doesn't hurt to be super
  #obvious... also note that this will have a second loop in it.. more xplaining to follow
  for (i in 1:nrow(testing_dataframe)){ #this first part defines the for loop and sets it to 
    #run for the same number of times as the testing dataframe has rows
    
    # okay, this part uses Euclid's equation to calculate total distance (really hypotenuse) 
    #between data points on a graph, for each row of the testing_dataframe it computes
    #distance, sequentially, between that row for ALL rows of the original dataset. It
    #does this to find the closest instance in the entire original dataset to this particular
    #"training" row.  Thats how you "stereotype" and assume that the data point is like whatever
    #is most similar PLEASE NOTE that the "apply" function used here has some weird juju, the 1
    #in the function is a setting for rows, where 2 would be columns..going
    #on with the function itself and how it assigns what to the two input variables
    euclidian_distance <- apply(original_dataframe, 1, function(m,n) sqrt(sum(m-n)^2), 
                                testing_dataframe[i,]) #here is where the entire original dataset's distane
                                                       #is computed against one row at a time of the testing 
                                                       #data, dataset grows as rows sum up
    ordered_euclidian_distances <- order(euclidian_distance) #sorts distances in ascending order
    
    most_similiar_labels_in_original_data <- vector(length = kvalue) #initializes empty vector based on number of k neighborss
    for (j in 1:kvalue) {
      most_similiar_labels_in_original_data[j] <- dataframe_labels[ordered_euclidian_distances[j]]
      
    }
    #okay, this code basically counts which label is most common in the "closest" population..
    #so if k = 5, and four of the nearest neighbors are red, and one is blue, 
    #this will output red as the most common occurence
    testing_dataframe_label[i] <- which.max(tabulate(most_similiar_labels_in_original_data))
    
  }
  
  factor(testing_dataframe_label, labels=levels(dataframe_labels))
  
  
} #END OF FUNCTION - due to curly bracket


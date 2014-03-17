#trees
##Structure and Contents of trees:
* Number of records: 31
* Columns: 3

        #numeric Tree diameter in inches
        trees[,1]
        trees$Girth
        #numeric Height in ft
        trees[,2]
        trees$Height
        #numeric Volume of timber in cubit ft
        trees[,3]
        trees$Volume
* Missing Values: 0


##The history of tree:
 * This data set provides measurements of the girth, height and volume of timber in 31 felled black cherry trees. Note       that girth is the diameter of the tree (in inches) measured at 4 ft 6 in above the ground.
 * Source 
  Ryan, T. A., Joiner, B. L. and Ryan, B. F. (1976) The Minitab Student Handbook. Duxbury Press.
 * References
  Atkinson, A. C. (1985) Plots, Transformations and Regression. Oxford University Press.

##Has others used it:
This [website](http://people.ysu.edu/~gkerns/useR/tutorial/useR-B/tasks/pdf/mlr.pdf "Multiple Linear Regression") uses trees dataset to do some research. 

##How do you acquire and load the dataset into R? (Include code.)

    #put the trees dataset to variable x:
    x = trees

##What are some simple statistics describing the dataset?

    #run summary(trees)
>
  Girth           |      Height     |     Volume 
    :--------------|:----------------|:-------
 Min.   : 8.30    |  Min.   :63     | Min.   :10.20  
 1st Qu.:11.05  |   1st Qu.:72  |1st Qu.:19.40  
 Median :12.90 |  Median :76   |Median :24.20  
 Mean   :13.2   |Mean   :76      |Mean   :30.17  
 3rd Qu.:15.25  |3rd Qu.:80    |  3rd Qu.:37.30  
 Max.   :20.60   |Max.   :87      |  Max.   :77.00  

What are the structure and contents of your dataset? (Number of records, columns, missing values, etc.)
> nrow(stackloss) #number of observations
[1] 21
> ncol(stackloss) #number of variables
[1] 4
> sum(is.na(stackloss)) #number of missing observations
[1] 0
What is the history of your dataset (How was it created?)
“Obtained from 21 days of operation of a plant for the oxidation of ammonia (NH3) to nitric acid (HNO3). 
The nitric oxides produced are absorbed in a countercurrent absorption tower”. 
(Brownlee, cited by Dodge, slightly reformatted by MM.)

Has your dataset been written about? What have others used it for?
The data was used by Brownlee, K. A. for the publication of
"Statistical Theory and Methodology in Science and Engineering."
How do you acquire and load the dataset into R? (Include code.)
What are some simple statistics describing the dataset?
> summary(stackloss)
    Air.Flow       Water.Temp     Acid.Conc.      stack.loss   
 Min.   :50.00   Min.   :17.0   Min.   :72.00   Min.   : 7.00  
 1st Qu.:56.00   1st Qu.:18.0   1st Qu.:82.00   1st Qu.:11.00  
 Median :58.00   Median :20.0   Median :87.00   Median :15.00  
 Mean   :60.43   Mean   :21.1   Mean   :86.29   Mean   :17.52  
 3rd Qu.:62.00   3rd Qu.:24.0   3rd Qu.:89.00   3rd Qu.:19.00  
 Max.   :80.00   Max.   :27.0   Max.   :93.00   Max.   :42.00 


References

Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole. 

Dodge, Y. (1996) The guinea pig of multiple regression. In: Robust Statistics, Data Analysis, and Computer Intensive Methods; In Honor of Peter Huber's 60th Birthday, 1996, Lecture Notes in Statistics 109, Springer-Verlag, New York. 
 

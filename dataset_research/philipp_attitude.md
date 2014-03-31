# Dataset Research (The Chatterjee–Price Attitude Data)

## What are the structure and contents of the dataset?

This dataset contains the aggregated results from a survey of the clerical employees of a large financial organization.
The numbers give the percent proportion of favourable responses to seven questions in each department.

<pre>
> str(attitude)
'data.frame':	30 obs. of  7 variables:
 $ rating    : num  43 63 71 61 81 43 58 71 72 67 ...
 $ complaints: num  51 64 70 63 78 55 67 75 82 61 ...
 $ privileges: num  30 51 68 45 56 49 42 50 72 45 ...
 $ learning  : num  39 54 69 47 66 44 56 55 67 47 ...
 $ raises    : num  61 63 76 54 71 54 66 70 71 62 ...
 $ critical  : num  92 73 86 84 83 49 68 66 83 80 ...
 $ advance   : num  45 47 48 35 47 34 35 41 31 41 ...
</pre>

## What is the history of the dataset? Have others written about it?

The dataset comes from the textbook below and is used to explain the basic concepts of multiple linear regression models. Though the authors claim it is derived from an actual survey, I'm inclined to think the data is probably manufactured for notional purposes.
Chatterjee, S. and Price, B. (1977) Regression Analysis by Example. New York: Wiley. (Section 3.7, p.68ff of 2nd ed.(1991))

## How is the dataset loaded?

Easy as cake! The dataset is built in to R by default.
<pre>
> data(attitude)
</pre>

## What are some simple statistics describing the dataset? 

<pre>
> summary(attitude)
     rating        complaints     privileges       learning         raises         critical        advance     
 Min.   :40.00   Min.   :37.0   Min.   :30.00   Min.   :34.00   Min.   :43.00   Min.   :49.00   Min.   :25.00  
 1st Qu.:58.75   1st Qu.:58.5   1st Qu.:45.00   1st Qu.:47.00   1st Qu.:58.25   1st Qu.:69.25   1st Qu.:35.00  
 Median :65.50   Median :65.0   Median :51.50   Median :56.50   Median :63.50   Median :77.50   Median :41.00  
 Mean   :64.63   Mean   :66.6   Mean   :53.13   Mean   :56.37   Mean   :64.63   Mean   :74.77   Mean   :42.93  
 3rd Qu.:71.75   3rd Qu.:77.0   3rd Qu.:62.50   3rd Qu.:66.75   3rd Qu.:71.00   3rd Qu.:80.00   3rd Qu.:47.75  
 Max.   :85.00   Max.   :90.0   Max.   :83.00   Max.   :75.00   Max.   :88.00   Max.   :92.00   Max.   :72.00 
</pre>
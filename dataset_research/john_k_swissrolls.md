R Research Swiss Rolls Dataset
=================
![swiss roll](http://people.cs.uchicago.edu/~dinoj/manifold/original_7p5_12p5_400_scaled.jpg)
![swiss rolls](http://people.cs.uchicago.edu/~dinoj/manifold/swissroll.gif)

###What are the structure and contents of your dataset? (Number of records, columns, missing values, etc.)
The Swiss Rolls dataset is a simple 1600 x 3 dimension dataset.
It consists of 1600 observations of an 3 variables which represent 3 dimensional coordinates.
###What is the history of your dataset (How was it created?)
Although information on this dataset appears to be thin (due to a lot of the cited)
papers being behind paywalls on scientific journal websites), the swiss roll dataset
appears to have been created in 2004 by Dinoj Surendran while he was studying at the
University of Chicago.  

His intended purpose of creating the data set was to use it for testing dimensionality
reduction techniques.  It gets its name due to the fact that the 3 dimensional version (which is generated
by taking the coordinates in a 2 dimensional plot created from a Gaussian distribution
and mapping it to a 3 dimensional table with (x,y) -> (x cos x, y, x sin x))
looks uncannily similar to the dessert snack Hostess Ho-Hos, generically called "Swiss Rolls".
###Has your dataset been written about? What have others used it for?
The Swiss Rolls dataset is, itself, not very interesting.  It is simply a standard "hello world"
3 dimensional data set which is universally known among academics working on various topics of
dimensionality reduction techniques and algorithms.  This is not suprising, considering that
testing of dimensionality reduction techniques was the intended purpose of the dataset.  

The Swiss Rolls dataset is used extensively in documentation for various scientific and statistical
computing libraries to demonstrate packaged tools for dimensionality reduction.  It is included in
examples and tutorials for scikit-learn (Python) and cems (R).  
###How do you acquire and load the dataset into R? (Include code.)
There are two different ways in which I acquired the dataset, since it is not
included with R.
* Method 1 - Download the dataset from the creator's [website](http://people.cs.uchicago.edu/~dinoj/manifold/swissroll.html) and load it
using the R read.table command:

```

swissroll <- read.table('http://people.cs.uchicago.edu/~dinoj/manifold/swissroll.dat')

```

* Method 2 - Install the cems package, which includes a swissroll() function which
will automatically generate a swiss rolls dataset

```
library(cems)
d <- swissroll(2000, nstd = 0.5, height = 5, phi = 2*pi)

```
###What are some simple statistics describing the dataset?
```
summary(swissroll)
       V1                 V2               V3
 Min.   :-15.7080   Min.   : 3.925   Min.   :-11.041  
 1st Qu.:  0.1369   1st Qu.: 7.522   1st Qu.: -3.110  
 Median :  5.0114   Median :10.094   Median :  4.281  
 Mean   :  4.1284   Mean   : 9.998   Mean   :  2.242  
 3rd Qu.:  9.4901   3rd Qu.:12.486   3rd Qu.:  7.476  
 Max.   : 12.6059   Max.   :16.133   Max.   : 14.172
```

The swiss roll dataset contains 1600 observed datapoints in 3 dimensions.
Its a 1600 x 3 data frame.  

Further information regarding the dataset, courtesy of R:

```
> str(swissroll)
'data.frame':	1600 obs. of  3 variables:
 $ V1: num  -5.215 -0.422 -6.135 6.213 6.345 ...
 $ V2: num  7.09 8.43 5.69 8.31 7.66 ...
 $ V3: num  6.729 7.896 6.089 2.362 0.532 ...

 > typeof(swissroll[1,1,1])
[1] "double"
```

# Abalone Dataset

## Description

The Abalone dataset contains the physical measurements of abalones, which are large, edible sea snails.

## Structure and contents

There are 4177 rows and 9 columns. The columns include 1 categorical predictor (sex), 7 continuous predictors (Length, Diameter, Height, Whole weight, Shucked weight, Viscera weight, Shell weight), and an integer response variable (number of rings). [More details are available here](http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.names).

There are no missing values.

## History of the dataset

The dataset comes from a 1994 study "The Population Biology of Abalone (_Haliotis_ species) in Tasmania. I. Blacklip Abalone (_H. rubra_) from the North Coast and Islands of Bass Strait". It was donated to the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Abalone) in 1995 by Sam Waugh from the Department of Computer Science at the University of Tasmania (Australia).

The original dataset contained missing values, though those were removed before the dataset was donated.

Although the physical measurements can be used to predict the number of rings (and thus its age) with some accuracy, it is noted that information not present in the dataset (weather patterns and location, hence food availability) could be used to improve the accuracy of predictions.

## Past usage of the dataset

The dataset was first written about by Sam Waugh for his PhD thesis, in which he used the data to compare different classification algorithms. Since then, the dataset has been used in dozens of papers dealing with both classification and regression algorithms. 

## Loading the data into R

```r
# read the dataset into a data frame
abalone <- read.csv("http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data", header=FALSE)

# add column names
names(abalone) <- c("sex", "length", "diameter", "height", "weight.whole",
    "weight.shucked", "weight.viscera", "weight.shell", "rings")

# confirm that there are 4177 observations
nrow(abalone)

# confirm that there are no missing values
sum(is.na(abalone))
```

## Dataset statistics

```
sex          length         diameter          height        weight.whole    weight.shucked  
 F:1307   Min.   :0.075   Min.   :0.0550   Min.   :0.0000   Min.   :0.0020   Min.   :0.0010  
 I:1342   1st Qu.:0.450   1st Qu.:0.3500   1st Qu.:0.1150   1st Qu.:0.4415   1st Qu.:0.1860  
 M:1528   Median :0.545   Median :0.4250   Median :0.1400   Median :0.7995   Median :0.3360  
          Mean   :0.524   Mean   :0.4079   Mean   :0.1395   Mean   :0.8287   Mean   :0.3594  
          3rd Qu.:0.615   3rd Qu.:0.4800   3rd Qu.:0.1650   3rd Qu.:1.1530   3rd Qu.:0.5020  
          Max.   :0.815   Max.   :0.6500   Max.   :1.1300   Max.   :2.8255   Max.   :1.4880  
 weight.viscera    weight.shell        rings       
 Min.   :0.0005   Min.   :0.0015   Min.   : 1.000  
 1st Qu.:0.0935   1st Qu.:0.1300   1st Qu.: 8.000  
 Median :0.1710   Median :0.2340   Median : 9.000  
 Mean   :0.1806   Mean   :0.2388   Mean   : 9.934  
 3rd Qu.:0.2530   3rd Qu.:0.3290   3rd Qu.:11.000  
 Max.   :0.7600   Max.   :1.0050   Max.   :29.000  
```

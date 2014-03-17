# Abalone dataset
These data are used for predicting the age of abalone from various physical measurements. Age in abalone can be measured accurately by cutting the shell, staining it, and counting rings under a microscope. However, this method is tedious, so other easier-to-obtain physical measurements may be used to predict age.

## Structure and contents
The abalone dataset contains 4176 records of 9 variables. The number of rings is the value to predict, using the other 8 attributes.

| Variable name | Data type  | Meas. unit | Description |
| ------------- | ---------- | ---------- | ----------- |
| Sex           | nominal    | n/a        | M, F, I (infant) |
| Length        | continuous | mm         | Longest shell measurement |
| Diameter      | continuous | mm         | perpendicular to length |
| Height        | continuous | mm         | with meat in shell |
| Whole weight  | continuous | grams      | whole abalone |
| Shucked weight | continuous | grams     | weight of meat |
| Viscera weight | continuous | grams     | gut weight (after bleeding) |
| Shell weight  | continuous | grams      | afer being dried |
| Rings         | integer    | n/a        | +1.5 gives age in years |

Records with missing values (usually the number of rings) were removed from the original dataset.

## Dataset history

The data originates from a study done by the Marine Research Laboratories in Hobart Tasmania:

>Warwick J Nash, Tracy L Sellers, Simon R Talbot, Andrew J Cawthorn and
>    Wes B Ford (1994) "The Population Biology of Abalone (_Haliotis_
>    species) in Tasmania. I. Blacklip Abalone (_H. rubra_) from the North
>    Coast and Islands of Bass Strait", Sea Fisheries Division, Technical
>    Report No. 48 (ISSN 1034-3288)

The dataset was donated to the UCI Machine Learning Repository in December 1995 by Sam Waugh, Department of Computer Science, University of Tasmania. (A university at which, incidentally, I have twice held a position as a special researcher.)

## Past usage

## Acquisition

```
> abalone.data <- read.csv('http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data')
> names(abalone.data) <- c('sex', 'length', 'diameter', 'height', 'whole.weight', 'shucked.weight', 'viscera.weight', 'shell.weight', 'rings')
```

## Data summary
```
Sex          Length         Diameter          Height      
 F:1307   Min.   :0.075   Min.   :0.0550   Min.   :0.0000  
 I:1342   1st Qu.:0.450   1st Qu.:0.3500   1st Qu.:0.1150  
 M:1527   Median :0.545   Median :0.4250   Median :0.1400  
          Mean   :0.524   Mean   :0.4079   Mean   :0.1395  
          3rd Qu.:0.615   3rd Qu.:0.4800   3rd Qu.:0.1650  
          Max.   :0.815   Max.   :0.6500   Max.   :1.1300  
  Whole weight    Shucked weight   Viscera weight     Shell weight   
 Min.   :0.0020   Min.   :0.0010   Min.   :0.00050   Min.   :0.0015  
 1st Qu.:0.4415   1st Qu.:0.1860   1st Qu.:0.09337   1st Qu.:0.1300  
 Median :0.7997   Median :0.3360   Median :0.17100   Median :0.2340  
 Mean   :0.8288   Mean   :0.3594   Mean   :0.18061   Mean   :0.2389  
 3rd Qu.:1.1533   3rd Qu.:0.5020   3rd Qu.:0.25300   3rd Qu.:0.3290  
 Max.   :2.8255   Max.   :1.4880   Max.   :0.76000   Max.   :1.0050  
     Rings       
 Min.   : 1.000  
 1st Qu.: 8.000  
 Median : 9.000  
 Mean   : 9.932  
 3rd Qu.:11.000  
 Max.   :29.000
 ```
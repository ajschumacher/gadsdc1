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
> abalone.data <- read.csv('http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data', as.is=TRUE)
> names(abalone.data) <- c('Sex', 'Length', 'Diameter', 'Height', 'Whole weight', 'Shucked weight', 'Viscera weight', 'Shell weight', 'Rings')
```

## Data summary
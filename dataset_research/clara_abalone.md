# Abalone dataset
These data are used for predicting the age of abalone from various physical measurements. Age in abalone can be measured accurately by cutting the shell, staining it, and counting rings under a microscope. However, this method is tedious, so other easier-to-obtain physical measurements may be used to predict age.

## Structure and contents
The abalone dataset contains 4176 records of 9 variables. The number of rings is the value to predict, using the other 8 attributes.

| Variable name | Data type  | Meas. unit (before scaling) | Description |
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

Records with missing values (usually the number of rings) were removed from the original dataset. The continuous data values were scaled for use with artificial neural networks, by dividing them by 200. (I have no idea why this scaling was necessary.)

## Dataset history

The data originates from a study done by the Marine Research Laboratories in Hobart Tasmania:

>Warwick J Nash, Tracy L Sellers, Simon R Talbot, Andrew J Cawthorn and
>    Wes B Ford (1994) "The Population Biology of Abalone (_Haliotis_
>    species) in Tasmania. I. Blacklip Abalone (_H. rubra_) from the North
>    Coast and Islands of Bass Strait", Sea Fisheries Division, Technical
>    Report No. 48 (ISSN 1034-3288)

The dataset was donated to the UCI Machine Learning Repository in December 1995 by Sam Waugh, Department of Computer Science, University of Tasmania. (A university at which, incidentally, I have twice held a position as a special researcher.)

## Past usage

The abalone data set was originally used in a data science context in Waugh's PhD thesis, "Extending and benchmarking Cascade-Correlation: Extensions to the Cascade-Correlation Architecture and Benchmarking of Feed-forward Supervised Artificial Neural Networks". It was also used in "A Quantitative Comparison of Dystal and Backpropagation", presented  by David Clark, Zoltan Schreter, and Anthony Adams at the Australian Conference on Neural Networks. The set is also cited in many more papers, some of which are listed [here, at the bottom of the page](http://archive.ics.uci.edu/ml/datasets/Abalone).

## Acquisition

```
> abalone.data <- read.csv('http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data')
> names(abalone.data) <- c('sex', 'length', 'diameter', 'height', 'whole.weight', 'shucked.weight', 'viscera.weight', 'shell.weight', 'rings')
```

## Data summary

| Sex | Number of observations |
| --- | ---------------------- |
|  M  | 1527 |
|  F  | 1307 |
|  I  | 1342 |

|      | Length | Diameter | Height | Whole | Shucked | Viscera | Shell | Rings |
| ---- | ------ | -------- | ------ | ----- | ------- | ------- | ----- | ----- |
| Min  | 0.075  | 0.0550   | 0.0000 | 0.0020| 0.0010  | 0.0005  | 0.0015| 1     |
|Median| 0.545  | 0.4250   | 0.1400 | 0.7997| 0.3360  | 0.17100 | 0.2340| 9     |
| Mean | 0.524  | 0.4079   | 0.1395 | 0.8288| 0.3594  | 0.1806  | 0.2389| 9.932 |
| Max  | 0.815  | 0.6500   | 1.1300 | 2.8255| 1.4880  | 0.7600  | 1.0050| 29    |
| Cor  | 0.557  | 0.5750   | 0.5581 | 0.5408| 0.4212  | 0.5043  | 0.6280| 1.000 |

Correlation reported with respect to the number of rings.
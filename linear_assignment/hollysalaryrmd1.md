Predicting salary from job description text - Holly Waisanen-Hatipoglu, 6 April 2014
========================================================

## Load data sets and identify some reasonable regression variables


```r
full_test <- read.csv("test.csv")
```

```
## Warning: cannot open file 'test.csv': No such file or directory
```

```
## Error: cannot open the connection
```

```r
full_train <- read.csv("train.csv")
```

```
## Warning: cannot open file 'train.csv': No such file or directory
```

```
## Error: cannot open the connection
```

```r
train <- full_train
```

```
## Error: object 'full_train' not found
```

```r

sum(is.na(full_test))
```

```
## Error: object 'full_test' not found
```

```r
sum(is.na(full_train))
```

```
## Error: object 'full_train' not found
```

```r

str(full_train)
```

```
## Error: object 'full_train' not found
```


No NAs is good to see (though there may be troublesome blanks).  The data set is very wordy though, with few variables taking either continuous numeric or "small" categorical forms (e.g. relatively few factors).  For example, Category takes 28 different values - using these as regression variables would be equivalent to creating 27 new features.  We will seek to limit problem size by deriving features from some of the text variables.

In particular, we will attempt to use three types of variables to derive SalaryNormalized:
1) Inclusion of the top 20 most popular words used in Title
2) ContractType and ContractTime since these have relatively few unique factors
3) A condensed form of LocationNormalized using the location_tree.txt file - ran out of time!

Note that we will eventually want to cross-validate and pull subsets out of the full_train set.  

## Finding and creating variables for the Top 20 words in Title
First we create a helper function to create our Term Document Matrix.

```r
library(tm)
get.tdm <- function(doc.vec) {
    # function creates a term-document matrix from the selected input vector
    # will be used on a single text column of a data frame in our application
    control <- list(stopwords = TRUE, removePunctuation = TRUE, removeNumbers = TRUE, 
        minDocFreq = 2)
    doc.corpus <- Corpus(VectorSource(doc.vec))
    doc.dtm <- TermDocumentMatrix(doc.corpus, control)
    return(doc.dtm)
}
```


Actually calling this tdm function proved a bit expensive to run on the Full Description, so we selected to run on Title, deriving the top 20 words used across all Titles in the training database.


```r
my.tdm <- get.tdm(full_train$Title)
```

```
## Error: object 'full_train' not found
```

```r
wordcounts <- rowSums(as.matrix(my.tdm))
```

```
## Error: object 'my.tdm' not found
```

```r
numpops = 20
popwords <- head(sort(wordcounts, decreasing = T), numpops)
```

```
## Error: object 'wordcounts' not found
```

```r
popwords <- names(popwords)
```

```
## Error: object 'popwords' not found
```

```r
print(popwords)
```

```
## Error: object 'popwords' not found
```


We have our top 20 words, let's keep moving and start constructing our other variables.


## Getting Contract variables for free
Since ContractType and ContractTime have only 3 factors each, they won't be too expensive to add to the linear model.  Let's do one more check to understand the distribution of these factors across examples.


```r
table(train$ContractType)
```

```
## Error: object 'train' not found
```

```r
table(train$ContractTime)
```

```
## Error: object 'train' not found
```


Hmm, some troubling blanks.  Let's throw them in anyway and see what we get.

## Creating the model matrices and running some initial fits
We will create a matrix X of features to fit.  First up is our popular words.  We will create one new feature for each popular word and set the variable to 0 or 1 depending on whether the word is in the Title of the given instance. 


```r
popmat <- rep(0, nrow(train))  # wasn't sure how to create the cbinds without a 0s col first!
```

```
## Error: object 'train' not found
```

```r
header_row <- c(0, popwords)
```

```
## Error: object 'popwords' not found
```

```r

for (ii in popwords) {
    blankcol <- rep(0, nrow(train))
    blankcol[grep(ii, train$Title, ignore.case = T)] <- 1
    popmat <- cbind(popmat, blankcol)
}
```

```
## Error: object 'popwords' not found
```

```r
colnames(popmat) <- header_row
```

```
## Error: object 'header_row' not found
```


Now let's add in the Contract variables --> note, there is some extremely suspicious cbinding going on here!  I wasn't sure how to fully use model.matrix with my new popular word matrix without referencing variable names directly.

```r
mm <- model.matrix(SalaryNormalized ~ ContractType + ContractTime, data = train)
```

```
## Error: object 'train' not found
```

```r
X <- cbind(mm[, 2:5], popmat[, 2:(numpops + 1)])
```

```
## Error: object 'mm' not found
```

```r
Y <- train$SalaryNormalized
```

```
## Error: object 'train' not found
```

```r
print(colnames(X))
```

```
## Error: object 'X' not found
```

Got my X, got my Y, let's lm!

```r
lmfit <- lm(Y ~ X)
```

```
## Error: object 'Y' not found
```

```r
print(summary(lmfit))
```

```
## Error: object 'lmfit' not found
```

Not a great R^2 around 22%.  That makes me suspicious that this will generalize well, but let's try some regularized models to see if that helps before we start cross-validating.

## Regularized linear models
Allrighty, what shall we learn with glmnet?

```r
library(glmnet)
```

```
## Loading required package: Matrix
## Loading required package: lattice
## Loaded glmnet 1.9-5
```

```r
set.seed(31)
cv.ridge = cv.glmnet(X, Y, alpha = 0, nfolds = 10)
```

```
## Error: object 'X' not found
```


```r
plot(cv.ridge)
```

```
## Error: object 'cv.ridge' not found
```


```r
cv.lasso = cv.glmnet(X, Y, alpha = 1, nfolds = 10)
```

```
## Error: object 'X' not found
```


```r
plot(cv.lasso)
```

```
## Error: object 'cv.lasso' not found
```


For ridge, I'd likely select a lambda in the neighborhood of 10^7 with 24 variables.  For lasso, it's 10^6 with about 17.  All in all, seems like all the variables are of similar importance, but putting together with the R^2 result above, they just don't add up to a great model!  

## Time to predict - I have run out of energy and time!


## Here's the start of my cross val logic

```r
create_train_and_test <- function(data, train_percent = 0.5) {
    # function takes full data set and split into train and test set (really
    # cross-validation?)  split_percent specifies how much of data to put into
    # training set
    
    total_obs <- 1:nrow(data)  # define vector 1:n to simplify getting complement of the random training sample below
    
    train_idxes <- sort(sample(total_obs, nrow(data) * train_percent, replace = F))
    test_idxes <- total_obs[-train_idxes]
    
    train_data <- data[train_idxes, ]
    test_data <- data[test_idxes, ]
    
    return(list(train_data, test_data))  # return train and test as a list - way to return multiple outputs
}


# set up train and test subsets for crossvalidation
nparts = 4
partpercent = 1 - 1/nparts

# insert for loop here
cross_val_output <- create_train_and_test(full_train, partpercent)
```

```
## Error: object 'full_train' not found
```

```r
train <- cross_val_output[[1]]
```

```
## Error: object 'cross_val_output' not found
```

```r
test <- cross_val_output[[2]]
```

```
## Error: object 'cross_val_output' not found
```

```r

# now do all that stuff above over each of the partitions - isolate which
# features to use
```



## And a couple of comments on locs
After running Aaron's hint on the txt file - 

cat location_tree.txt | sed 's/~/,/g' | sed 's/"//g' > location_tree.csv

- I was able to read.csv with a few extra cols added at the end to catch locations (in Scotland) with extra commas in the deeper levels.  It appears that locs[,4] corresponds roughly to LocationNormalized in the training data.  I would have tried to train on a slightly binned version of locs[,2] for a manageable number of features.


```r
locs <- read.csv("location_tree.csv", header = F, col.names = c(1, 2, 3, 4, 
    5, 6, 7))
```

```
## Warning: cannot open file 'location_tree.csv': No such file or directory
```

```
## Error: cannot open the connection
```

```r
print(sort(table(locs[, 2]), decreasing = T))
```

```
## Error: error in evaluating the argument 'x' in selecting a method for function 'print': Error in table(locs[, 2]) : object 'locs' not found
## Calls: sort -> table
```


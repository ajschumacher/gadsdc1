library(ggplot2)

### Read in the data

# This script presumes you have already downloaded the test and training set
# files into your working directory. To download these files, you must create
# a Kaggle account and agree to the competition rules.

# define the classes for the columns
colClasses <- c(rep("integer", 4), "character", rep("factor", 2), "integer",
    "factor", "integer", "factor", rep("integer", 3), rep("factor", 2),
    "integer", rep("factor", 7), "integer")

# read in full training and test sets
train <- read.csv("train.csv", colClasses=colClasses)
test <- read.csv("test_v2.csv", colClasses=colClasses)

# add new features to training set
train$plan <- paste0(train$A, train$B, train$C, train$D, train$E, train$F,
    train$G)
train$hour <- as.integer(substr(train$time, 1, 2))

# trainsub is subset of training that only shows purchases
trainsub <- train[!duplicated(train$customer_ID, fromLast=TRUE), ]

# trainex is subset of training that excludes purchases
trainex <- train[duplicated(train$customer_ID, fromLast=TRUE), ]

# trainex2 is subset of training that only shows last quote before purchase
trainex2 <- trainex[!duplicated(trainex$customer_ID, fromLast=TRUE), ]

# testsub is subset of test that shows last quote for each customer
testsub <- test[!duplicated(test$customer_ID, fromLast=TRUE), ]

# add "changed" feature: anyone who changed from their last quote
changed <- ifelse(trainsub$plan == trainex2$plan, "No", "Yes")
trainsub$changed <- as.factor(changed)
trainex2$changed <- as.factor(changed)


### VIZ 1

shoptrain <- data.frame(maxpoint=trainex2$shopping_pt, dataset=rep("train",
    nrow(trainex2)))
shoptest <- data.frame(maxpoint=testsub$shopping_pt, dataset=rep("test",
    nrow(testsub)))
shoppingpoints <- rbind(shoptrain, shoptest)
shoppingpoints$dataset <- as.factor(shoppingpoints$dataset)
ggplot(shoppingpoints) + aes(factor(maxpoint)) + geom_histogram() +
    facet_grid(dataset ~ .) + labs(x="Number of Shopping Points",
    y="Frequency", title="Comparing Number of Shopping Points in
    Training vs Test Sets")
ggsave("kevin_viz01.png")


### VIZ 2

s <- split(trainex2, trainex2$shopping_pt)
s2 <- sapply(s, function(x) sum(x$changed=="No")/nrow(x))
acclastentry <- data.frame(numentries=as.integer(names(s2)),
    accuracy=s2)
ggplot(acclastentry) + aes(numentries, accuracy) + geom_line() +
    geom_point() + scale_x_continuous(breaks=1:12) +
    theme(panel.grid.minor=element_blank()) +
    labs(x="Number of Shopping Points", y="Prediction Accuracy",
    title="Effect of Number of Shopping Points on Predictive Power
    of Last Quote")
ggsave("kevin_viz02.png")


### VIZ 3

s3 <- split(trainsub, trainsub$hour)
s4 <- sapply(s3, function(x) sum(x$changed=="Yes")/nrow(x))
s5 <- as.data.frame(table(trainsub$hour))$Freq
changebyhour <- data.frame(hour=as.integer(names(s4)),
    percentchanged=s4, count=s5)
ggplot(changebyhour) + aes(hour, percentchanged, color=count) +
    geom_point(size=4) + labs(x="Hour of Purchase", y="Percent Changed",
    title="Effect of Purchase Hour on Likelihood of Changing from Last Quote")
ggsave("kevin_viz03.png")

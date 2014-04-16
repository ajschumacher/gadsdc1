# script:  salary predictions
#
# arguments: sal_train (data frame of UK job postings, including description, location(normalized)
#            and job posting )
#                 attributes:
#                     Id,Title,FullDescription,LocationRaw,LocationNormalized,
#                     ContractType,ContractTime,Company,Category,SalaryRaw,
#                     SalaryNormalized,SourceName
#            location_tree (text file of various United Kingdom locations, with various length
#                 of the tree depending on specificity of location, other factors)
#            test (CSV of job postings with the following attributes)
#                   attributes:
#                     "Id","Title","FullDescription","LocationRaw","LocationNormalized",
#                   "ContractType","ContractTime","Company","Category","SourceName"
# Munging Tasks:
#
#
# 1) Additional munging which will be used to enhance training AND test data:
#       A) We can improve "location normalized" by adding a higher level location category.
#          This will help for dealing with the variation caused by regional cost of living
#          differences.
# returns:
sal_train <- read.csv("/Users/johnkabler/gadsdata/salary/train.csv")
con <- file("/Users/johnkabler/gadsdata/salary/location_tree.txt")
text <- readLines(con)

# Parse locations tree
#1:
#get rid of crazy stuff in each line
#use this function
#      substring(line, 2, (nchar(line) - 1))

loc_clean_text <- sapply(text, function(i) {
  substring(i, 2, (nchar(i) - 1))
}, USE.NAMES=FALSE)
#2:
#Split each string into its component parts

parsed.loc <- sapply(loc_clean_text, function(row) {
  strvec <- strsplit(row,"~")
  lvec <- length(unlist(strvec))
  c(unlist(strvec)[lvec:1])
}, USE.NAMES=FALSE)

#3
#Let's flatten this thing
#Sometime, I really hate native R.  No matter what I did,
#the stupid sapply returned a nested list for no good reason.
#Let's use plyr.  Its sane, because Hadley is the man.
library(plyr)

flat.loc <- ldply(1:length(parsed.loc), function(i) {
  #unlist(parsed.loc[i])[1:3]
  loc_list <- unlist(parsed.loc[i])
  if (length(loc_list)< 5) {
    loc_list[4] <- "none"
    loc_list[5] <- "none"
    return(loc_list[1:5])
  } else {
    loc_list[1:5]
  }
})

colnames(flat.loc)<- c("neighborhood", "city", "county", "region", "country")


salary.munge <- function(sal.data, loc.data) {


  sal_loc <- merge(sal.data, loc.data, by.x = "LocationNormalized",
                   by.y="neighborhood",all.x=TRUE)
  sal_loc$DegreeRequired <- ifelse(grepl("[dD]egree|[uU]niversity", sal_loc$FullDescription),
                                   1,0)

  sal_loc$Technical <- ifelse(grepl("[eE]ngineer|[sS]oftware|[sS]cienti(fic|st)|[Pp]rogramm(ing|er)|[dD]eveloper",
                                    sal_loc$FullDescription), 1, 0)

  #if the description doesn't have key words, but title does, let's set it to 1

  sal_loc$Technical <- ifelse(grepl("[eE]ngineer|[sS]oftware|[sS]cienti(fic|st)|[Pp]rogramm(ing|er)|[dD]eveloper",
                             sal_loc$Title),1,sal_loc$Technical)


  #Ok, let's do the executive, management, senior stuff too.

  sal_loc$Leadership <- ifelse(grepl("[eE]xecutive|[mM]anage(er|ment)|[lL]ead|[vV]ice|[Ss]enior|[cC]hief",
                                     sal_loc$FullDescription), 1,0)

  sal_loc$Leadership <- ifelse(grepl("[eE]xecutive|[mM]anage(er|ment)|[lL]ead|[vV]ice|[Ss]enior|[cC]hief",
                                     sal_loc$Title),1, sal_loc$Leadership )
  #Now let's factorize the various fields for which we have a manageable number of
  #categories

  sal_loc$Category <- as.factor(sal_loc$Category)
  sal_loc$county <- as.factor(sal_loc$county)
  sal_loc$DegreeRequired <- as.factor(sal_loc$DegreeRequired)
  sal_loc$Technical <- as.factor(sal_loc$Technical)
  sal_loc$Leadership <- as.factor(sal_loc$Leadership)

  return sal_loc

}

n <- 5
chunks <- sample(n, nrow(sal_train), replace=TRUE)
chunk <- sample(n, 1)
test.sal <- sal_train[chunk == chunks, ]
train.sal <- sal_train[chunk != chunks, ]



trn_sal_loc <- salary.munge(train.sal, flat.loc)
tst_sal_loc <- salary.munge(test.sal, flat.loc)





#Now let's start doing the lms and add features in bit by bit.

test.fit1 <- lm(SalaryNormalized ~ Technical
                , data=trn_sal_loc)
summary(test.fit1)

model1.vals <- predict(test.fit1, data=trn_sal_loc)

#let's build an rmse function

sal.rmse <- function(pred.vals, sal.data) {
  sqrt(mean((pred.vals-sal.data$SalaryNormalized)^2))
}
#rmse.1 <- sqrt(mean((model1.vals-trn_sal_loc$SalaryNormalized)^2))
rmse.1 <- sal.rmse(model1.vals, trn_sal_loc)
#> rmse.1
#[1] 15282.96

test.fit2 <- lm(SalaryNormalized ~ Technical + Category,
                data=trn_sal_loc)
model2.vals <- predict(test.fit2, data=trn_sal_loc)
#rmse.2 <- sqrt(mean((model2.vals-trn_sal_loc$SalaryNormalized)^2))
rmse.2 <- sal.rmse(model2.vals, trn_sal_loc)
rmse.2
#[1] 14467.27
#better

test.fit3 <- lm(SalaryNormalized ~ Technical + Category + Leadership,
                data=trn_sal_loc)
model3.vals <- predict(test.fit3, data=trn_sal_loc)
#rmse.3 <- sqrt(mean((model3.vals-trn_sal_loc$SalaryNormalized)^2))
rmse.3 <- sal.rmse(model3.vals, trn_sal_loc)
rmse.3
#[1] 14341.9
test.fit4 <- lm(SalaryNormalized ~ Technical + Category + Leadership + county,
                data=trn_sal_loc)
model4.vals <- predict(test.fit4, data=trn_sal_loc)
#rmse.4 <- sqrt(mean((model4.vals-trn_sal_loc$SalaryNormalized)^2))
rmse.4 <- sal.rmse(model4.vals, trn_sal_loc)
rmse.4
#[1] 16203.91
#worse.  Now I'll get rid of location and attempt degree required

test.fit5 <- lm(SalaryNormalized ~ Technical + Category + Leadership + DegreeRequired,
                data=trn_sal_loc)
model5.vals <- predict(test.fit5, data=trn_sal_loc)
#rmse.5 <- sqrt(mean((model5.vals-trn_sal_loc$SalaryNormalized)^2))
rmse.5 <- sal.rmse(model5.vals, trn_sal_loc)
rmse.5
#[1] 14324.25

#This is the best fit with basic lm.

<<<<<<< HEAD
library(glmnet)
sal_set <- model.matrix(SalaryNormalized ~ Technical + Category + Leadership + DegreeRequired 
                        , data=sal_loc)
sal <- sal_loc$SalaryNormalized
regularized.fit <- glmnet(sal_set, sal)
str(regularized.fit)
#Bad weekend, ran out of time, need to work on glm approaches later.  
=======
#Bad weekend, ran out of time, need to work on glm approaches later.
>>>>>>> lm_cleanup

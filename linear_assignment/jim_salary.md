Predicting Salary Based on Job Description
==========================================

First, let's get the data
```{R}
train <- read.csv("C:\\Users\\JIM~1.ANC\\AppData\\Local\\Temp\\Rtmp8Ca3cw\\data2decd3c7169")
test <- read.csv("C:\\Users\\JIM~1.ANC\\AppData\\Local\\Temp\\Rtmp8Ca3cw\\data2dec49043501")
location_tree <- read.table("C:\\Users\\JIM~1.ANC\\AppData\\Local\\Temp\\Rtmp8Ca3cw\\data2dec502e64d9", quote="\"")
```

Let's try that DAAG library package for their cv.lm function
```{R}
install.packages("DAAG")
require(DAAG)
```
First lets take a look at the scattermatrix to see what we have
```{R}
plot(train)
```
That seems useless. lets try a few exploratory scatter plots.
```{R}
plot(x=train$SalaryNormalized) 
```
Looks ok to keep untransformed. but there are a few high values up there. That
should be something to keep an eye on in case they have too much leverage.

I love boxplots, so lets look by category
```{R}
bp<-boxplot(train$SalaryNormalized~train$Category, colour=train$Category)
```

We can now try to run the model just using the Category as the feature set.
```{R}
cvm1<-cv.lm(df = train, form.lm=formula(SalaryNormalized~Category), m=3)
```
The mse for this is approximately 2 million. that seems high.

lets add some more details to the model by using grepl for some potential key words
```{R}
train$has.technology<-grepl('technology', train$FullDescription)
train$has.financial<-grepl('financial', train$FullDescription)
train$has.senior<-grepl('senior', train$FullDescription)
train$has.manage<-grepl('manage',train$FullDescription)
```

cvm2<-cv.lm(df=train, form.lm=formula(SalaryNormalized~has.technology + has.financial + has.senior + has.manage + Category + ContractType + ContractTime))

#this still looks weird. lets just forget it and use GLMNET!

require(glmnet)


x<-model.matrix(~has.technology + has.financial + has.senior + has.manage + Category + ContractType + ContractTime, data = train)

y<-train$SalaryNormalized

m<-glmnet(x, y)
plot(m, label=TRUE)


cvm1<-cv.glmnet(x, y) #default to lasso is fine.
plot(cvm1)
cvm1$lambda.min

#looks like glmnet likes lambda at 6.47
#let's see what coefficients it liked:
coef(cvm1, s="lambda.min")

#well, it kept them all. i don't really like that. I'd prefer a 
#simpler model, so I'm going to use the 1se lambda.
coef(cvm1, s='lambda.1se')

>>that looks a little better, so I think we can try this against the test data.


predictions<-predict(cvm1, newx=test)

m<-glmnet(x,y,lambda=11.3)
summary(m)
predictions<-predict(m, s="lambda.1se", newx=x)

#im going to do this by hand because sometimes I forget how the models do it
train$pred<-predictions
train$resid<-train$SalaryNormalized-train$pred
train$sq.resid<-train$resid**2
sqrt(mean(train$sq.resid)) #14199. this is the same as the orignal DAAG value. curious.



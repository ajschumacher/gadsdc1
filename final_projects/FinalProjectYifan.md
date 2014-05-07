#Walmart Recruiting - Store Sales Forecasting

##Goal:
Use historical markdown data to predict store sales. [model file](https://github.com/liyifan5923013/DataScience_demo/blob/master/walmart/Walmart-Data.R)

##Dataset:
 * stores.csv: Include 45 stores and their type and size 
 * train.csv: Historical training data and label, from 2010-02-05 to 2012-11-01
 * test.csv: Testing data without label, from 2012-12-02 to 2013-07-26
 * features.csv: All feature set, includes: Temperature, Fuel_Price, MarkDown1-5, CPI, Unemployment, IsHoliday

##Approach:

- Generate Date as a ‘percentage’, from 1/365 to 365/365
- Using linear regression to get missing CPI and unemployment rate
Fill missing Markdowns with 0
- Using weight to denote 5 in a holiday week, and 1 in a non-holiday week [evaluation](http://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/details/evaluation)
- Used three machine learning algorithms:
	1. linear regression: lm{stats}
	2. regularization: glmnet{glmnet}
	3. least absolute deviation: rq{quantreg} 
- The most effective for this competition is rq, then lm, then glmnet

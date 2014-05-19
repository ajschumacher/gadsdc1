#Walmart Recruiting - Store Sales Forecasting

##Goal:
Use historical markdown data to predict store sales. [My model file](https://github.com/liyifan5923013/DataScience_demo/blob/master/walmart/Walmart-Data.R)
Walmart has a lot of markdown events on holidays. They want to know how those markdown events can increase the sales and to what extend. So they held this Kaggle competition, given 
some of the weekly sales data from 2010-02-05 to 2012-11-01, and all the corresponding factors(features) that could affect the sales,
like CPI, unemployment rate, markdown events, etc. To let participants predict the sales for 2012-12-02 to 2013-07-06, given all
those factors. A good prediction can lead to an interview with Walmart and potential job opportunities.

##Dataset:
 * stores.csv: Include 45 stores and their type and size 
 	The stores have type A and B for training data, but has type A, B and C for testing data. Stores who have C type has a size
 	between A and B type stores.(After Data Visualization) That is a headache and may render the type feature not as important as
 	size feature.
 * train.csv: Historical training data and label, from 2010-02-05 to 2012-11-01
 	This table has the store, dept, date, isHoliday(to indicate the week is a holiday week or not) and weekly sales.
 * test.csv: Testing data without label, from 2012-12-02 to 2013-07-26
 	This table has the store, dept, date, isHoliday(to indicate the week is a holiday week or not).
 * features.csv: All feature set, includes: Temperature, Fuel_Price, MarkDown1-5, CPI, Unemployment, IsHoliday.
 	All those features are related in the store, dept and date, can be combined with train.csv and test.csv to a bigger dataframe.
 	

##Approach:
- Generate Date as a ‘percentage’, from 1/365 to 365/365. I used this variable, thanks to [Gimperion](https://github.com/Gimperion),
  is because intuition tells us that the weekly-sales may have a non-linear relationship with the date in a time of the year.
  I called this feature "totalDate" and by trial and error, make it poly(totalDate,3) to be a useful feature in my model.
- Using linear regression to get missing CPI and unemployment rate
  There is missing CPI information in the feature.csv. I used temperature and fuel price to predict missing CPIs,
  and use CPI and temperature to pridict missing unemployment rate. After the filling of the missing data, the prediction result
  gets better.
- Fill missing Markdowns with 0
  There is some missing data on the Markdown features(Markdown1-5). Since it is not possible to speculate what the missing data
  is, so just fill with 0.
- Using weight to denote 5 in a holiday week, and 1 in a non-holiday week [evaluation](http://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/details/evaluation)
  Since the evaluation method is weighted absolute deviation, and the holiday week is weighted 5 and non-holiday week is weighted 1.
  So I derived the weight matrix does exactly that.
- Used three machine learning algorithms:
	1. linear regression: lm{stats}
	I used Linear regression to get a sense of the data, and improved my model(by keep on uploading my output data to Kaggle competition
	and see if the calculated error gets smaller.
	2. regularization: glmnet{glmnet}
	I used regularization using the same model(modelmatrix) as the linear regression. Surprisingly, the regularization model constantly
	underperforms the linear regression. 
	3. least absolute deviation: rq{quantreg}
	The linear regression uses sum of square error, while the evaluation method in Kaggle uses sum of (weighted) absolute error. I 
	searched online and found out R has a package quantile regression that do exactly that.
	Surprisingly, when I choose tau = 0.5, the result is the same as linear regression. I tried a few different taus, and I find
	that tau = 26/50.
- The most effective for this competition is rq, then lm, then glmneta

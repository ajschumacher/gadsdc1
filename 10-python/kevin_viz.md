# Project Visualizations: Allstate Kaggle competition

My class project is entering the [Allstate Purchase Prediction Challenge](http://www.kaggle.com/c/allstate-purchase-prediction-challenge) on Kaggle. The goal is to predict the exact car insurance options purchased by individual customers. The data available for training the model is the history of car insurance quotes that they reviewed, as well as data about the customer and their car. For a prediction to be counted as correct, you must successfully predict the value for all seven options, and each option has 2 to 4 possible values, thus you could view this as a classificiation problem with over 2,000 possible classes.

Here is my [R code](kevin_viz.R) for reading in the data and creating the visualizations.

[Visualization 1](kevin_viz01.png) compares the number of shopping points (per customer) in the training set versus the test set.

[Visualization 2](kevin_viz02.png) shows how the predictive accuracy of the final quote in the training set varies by the number of shopping points.

[Visualization 3](kevin_viz03.png) shows how likely a customer is to change from their last quote when purchasing, depending upon time of day.

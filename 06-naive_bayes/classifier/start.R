# Say we have:
#  * train_features
#  * train_labels
#  * test_features
# Then define a training function such that you can do:
my_model <- my_naive_bayes_trainer(train_features, train_labels)
predictions <- my_naive_bayes_predictor(my_model, test_features)

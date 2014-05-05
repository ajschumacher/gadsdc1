#Predicting Partisan Affiliation of Twitter Users

##[Github Repo for the Project](https://github.com/johnkabler/voter_data_project)

##Motivation

United States elections are extremely polarized. Increasingly, turnout, rather than issues, determines the winner in elections.
  * 2010 midterms:  Republican gains were not due to increased number of Republican voters, but rather a [decreased number of Democratic voters]() participating.

  * 2014 midterms:  Projections indicate that the Republicans have a [greater than 50%]() chance of taking control of the Senate due to weak midterm turnout of Democratic Party constituents.

For both major political parties, finding voters who fit the characteristics of a Democratic or Republican voter, and making contact with them is crucial to raising turnout.  These characteristics have historically been limited to demographic information, such as race, age, income, etc.
This is at best a blunt instrument.  Not all black Americans support the Democratic party, many stereotypically Republican constituencies lean Democratic on certain key issues (for example, there are strong percentages of below 50 Republicans who support decriminalization of marijuana)
A better way would be to base identification of likely supporters based on what they say, think, and write.  While the first two are difficult, writing by individuals has become widely available on platforms such as Facebook and Twitter.

Since a large percentage of Twitter users have their regional location attached to their profile, this allows researchers and campaigners to align groups of potential voters with specific regions of the country.  Perhaps just as importantly, it allows campaigns to know when and where their efforts are being wasted.


##Can we predict a person’s partisan affiliation based on their tweets?



By taking a sample of real-world Twitter messages (also known as "tweets") whose writers have a known party affiliation, we will attempt to create an actionable, accurate predictive model.  The predictive model should allow a researcher or campaign worker to identify an unknown user's likely partisan affiliation based only on the user's tweet(s).

###Training Data

Makindo, a Seattle based technology startup, has successfully compiled a list of 976 Twitter users with a known party affiliation.  Makindo was able to identify Twitter users by their name and location, and successfully merge these Twitter profiles with the user's respective Florida voter record.  The resulting data set is a list consisting of:

  * Twitter Username
  * Twitter Message (Tweet)
  * Twitter User's Partisan Affiliation

The original set of 976 tweets is not of an ideal size for this task.  To increase the size of the corpus of partisan tagged tweets, I wrote a Python script to take each of the 976 usernames and then use the Twitter Application Programming Interface (API) to fetch the 20 most recent tweets each user had written.  This led to a dataset of roughly 20,000 tweets with a partisan affiliation attached to them.

###Approach

1. Data Preprocessing:
  * The dataset is pulled into a Python Pandas "dataframe" object (you can read more about [Python Pandas here]() )

2. Classification Approach 1

  * Using a standard bag-of-words/n-gram approach, the dataset is converted to a vector
  of stemmed words, with the high frequency "stop words" removed.

  * The vector was then passed into a Multinomial Naive Bayes classifier.

  Initial tests of this approach showed poor accuracy due to the tremendous amount of
  non-political oriented text which introduced noise into the classification process.

3. Classification Approach 2

  * The dataset is converted into a numerical matrix through a vectorization process, and then run through the Python package [Gensim]().
  Gensim is a topic modeling library which will process the text into a series of "topic clusters" using a topic modeling algorithm known as
  Latent Dirichlet Allocation (LDA).  Each tweet will then be related to one or more topics, with
  a corresponding numerical weighted association.  The LDA technique was selected due to
  the poor performance of using 'bag of words' and n-gram techniques when used in the later stages
  of classification described below.  Simple 'bag of words' and n-gram strategies, while
  more than adequate for basic classification tasks such as identifying spam emails,
  introduces too much noise when being used to identify partisanship.  This is likely due
  to the fact that the vast majority of tweets created by typical users are not themselves
  partisan in nature.  The noise introduced by non-partisan, non-topical tweets was too high
  for the classification techniques below.  For more information on topical modeling
algorithms and LDA, read [this article](http://www.cs.princeton.edu/~blei/papers/Blei2012.pdf)
published by Princeton University's Computer Science department.

  * The topic modeling algorithm will output, for each tweet, a vector of topics
and their relative weights.  These outputs will be utilized as features for each
tweet, and will be fed into various classifiers for comparison.  The classifiers
include:

    * Multinomial Naive Bayes
    * Linear Support Vector Classifier
    * Random Forest


4 . Possible Improvements

  * Feature Engineering

    * In addition to a topic model generated feature for each tweet,
    use of a good sentiment tagging strategy would likely aid in successfully predicting
    the partisan affiliation of the author of a tweet.  Intuitively, knowing whether
    someone is positively or negatively mentioning a given topid would aid in determining
    their political leanings.

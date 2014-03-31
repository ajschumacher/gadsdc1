Dons Notes on ClassifyEmail.R
=======================================================

Collect some of the R techniques you learn as you go through the code. Include them here.

R Technique: file.path: This function outputs a file path.

R Technique: runif: This function produces a randomly distributed number between two numbers

R Technique: cbind: This function combines datasets together by the column. Essentially, it adds columns. In order for this to work the number of rows needs to be equal

R Technique: rbind: This function combines datasets together by the row. Essentially, it adds rowss. In order for this to work the number of columns needs to be equal



There are also some negative points to be made about this code. Include observations along those lines here.

-I noticed a lot of places in the code where  generally "reserved" words are used as variables.  for example, "c", "text", etc.
-There was some slight inconsistency in naming standards. this was evident in the inconsistency in capipalization of second words in variable names.

Running the code, you'll encounter a harmless warning, twice. What is this warning and what does it mean?

The warning is essentially stating that it is looking for a carraige return or something to denote the end of a file but it isn't finding it.

Later, you'll get an actual error. What is it, why did it occur, and how did you fix it?

The error occurs because because it is looking for a hardspam file but it doesn't find it and thus it creates a dataset of 0 columns.  Therefore when it tries to rbind with the other datasets it can't and it throws an error.

How many emails are in the training and test sets of this example code as we're running it?

2551(EasySpam) + 500(Spam) + 250(HardHam)

Does the code calculate word frequencies? How/does it use them?

The code does calculate word frequencies. it uses the word frequencies tp calculate the probability an e-mail is spam.

What is the training step of Naive Bayes? What does it "learn"? How does this compare to KNN?

The training step for this machine learning paradigm is to simply count the words that are used and the frequencies of each in each e-mail. This is different from KNN because the algorithm  because frequency of an attribute is measured instead of trying ot categorize based upon euclidian distance.  This would typically be better for datasets where features are discrete rather than continuous sets.  Word matches are perfect for this.

What are what the code calls density and occurrence? What is used to predict?

Density: Is the fraction of individual word occurances for an individual word over the total number of words in the corpus.
Occurance: If there is an occurance of a word, occrurance gives 1 divided by the total number of words


Does it matter whether a word appears in the test set that didn't appear in the training set? What happens?

It does matter. The algorithm is essentially looking for matches; when a match is found the probabiliy of spam increases. Non-matches still retain a small probability of spam.

Which "type" of Naive Bayes does the code implement? (See: http://blog.datumbox.com/machine-learning-tutorial-the-naive-bayes-text-classifier/)

What are some of the differences between this code and the method described by Paul Graham? Which method do you think would get better performance?




```{r}

```


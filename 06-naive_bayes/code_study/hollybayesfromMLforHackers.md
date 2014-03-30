Review of Naive Bayes spam classification from Machine Learning for Hackers - Holly WH 27Mar14
========================================================


### Collect some of the R techniques you learn as you go through the code. Include them here.
* Terms from the tm package
  * VectorSource -> takes in a vector of strings, outputs something to be used as input to Corpus 
  * Corpus -> takes in the output of VectorSource, outputs something to be used by TermDocumentMatrix
  * TermDocumentMatrix -> takes in the output of Corpus plus a vector of control variables and returns a sparse matrix
* Other useful things
  * file.path - file handling, create paths from (relative) directories and file names
  * rowSums (and colSums) - sum across dimensions of a matrix, sum() sums across all dimensions
  * intersect (and union, setdiff) - treating each vector as a set, return vector of items in both sets
  * match - vector of (first) matches of arg1 in arg2, x %in% table is the T/F version
  * ifelse - nice function to consolidate if, else flow - if arg1 == T, then output arg2, else output arg3
  * transform - another way of adding columns to a data frame 
  * do.call - executes a function call (not completely sure) - used to convert list of length 3 vectors to an m by 3 matrix
  * ggplot / ggsave -> informative for exporting charts

    
### There are also some negative points to be made about this code. Include observations along those lines here
There is some duplication of lines where functions could be used more effectively.  For example, count.word() could call get.tdm() instead of duplicating its lines.   The creation of tdms and densities for the training data frames (e.g. lines 142-163, lines 165-189) could have been encapsulated in a single function that takes in a path and spits out the massaged dataframe.

The count.word() helper function constructs an expensive tdm to get one word frequency and then throws out the tdm once out of that functions scoping.  It would be more efficient to create the full tdm / frequencies and query lines from it as needed rather than calling count.word() anew for each count.

I had a little confusion about variable names in the training dataframes, e.g. frequency is a word count, not a frequency.  I also wish the structure of the data frames was defined before classify_email() so that I knew what occurence meant without reading ahead.

    
    
### Running the code, you'll encounter a harmless warning, twice. What is this warning and what does it mean?
One of the files in hard_ham does not end with a newline character and R is concerned that the final may be unintentionally incomplete.  The warning is issued twice because this file is run through separate classifiers for spam and ham.
    
### Later, you'll get an actual error. What is it, why did it occur, and how did you fix it? 
hard_ham2 does not appear to exist.  I commented out or modified roughly 15 references to the file and its expected data structures to remove the error.
    
### How many emails are in the training and test sets of this example code as we're running it?
There are 1000 total emails in the training set: 500 spam and 500 easy ham.  There are a total 3046 test emails: 250 hard ham, 1400 easy ham 2, and 1396 spam 2.  
    
### Does the code calculate word frequencies? How/does it use them?
The frequency column appears to be a total count of each word across the entire corpus.  This count (not really a frequency) is used to define the density, the total count of each word divided by all the words in the corpus.  Neither frequency nor density appears to be used in the Naive Bayes computation.  frequency is used in the plots for html and table though through duplicate calculation via count_word().

    
### What is the training step of Naive Bayes? What does it "learn"? How does this compare to KNN?
The training step pulls out every word in every document in the corpus and counts the number of times each word appears. Then two kinds of frequencies or "probabilities" are computed: 1) occurence is the proportion of documents in the corpus which contain the word at least once, and 2) density is the proportion of words in the corpus which are the given word (i.e. word count over total number of words in corpus).   Occurence is the probability that will be used in testing.

As in knn, we are looping over all points in the training set to compare the similarity to our test point.  In this case, the similarity is captured indirectly by condensing the training space into a corpus of word counts and a spam / ham label. 

    
### What are what the code calls density and occurrence? What is used to predict?
As above, occurence is the proportion of documents in the corpus which contain the word at least once, and density is the proportion of words in the corpus which are the given word.   Occurence is the probability that will be used in prediction.
    
### Does it matter whether a word appears in the test set that didn't appear in the training set? What happens?
Words in the test set which are not in the training are incorporated in the calculation with a fixed probability c = 1e-6.   I expect this 1 in a million chance to be much smaller than the usual occurance probabilities in the training set, especially since each training set has only 500 emails!  This will tend to drag down the probabilities but since it drags down for both the spam probability and ham probability for completely new words, I believe it's a wash in the comparison. 
    
### Which "type" of Naive Bayes does the code implement? 
See: http://blog.datumbox.com/machine-learning-tutorial-the-naive-bayes-text-classifier/

This appears to implement a Bernoulli Naive Bayes model since it scores based on the number of documents containing a term normalized by the total number of documents, defined here as "occurence".  Using our variable "density" would correspond to a Multinomial model.  To create a Binary Multinomial model, we'd have to normalize our document count (the numerator in occurence) by the sum of unique words in each document across all documents.


    
### What are some of the differences between this code and the method described by Paul Graham? Which method do you think would get better performance?

This code implements two classifiers and triggers a positive any time p(spam|xi) > p(ham|xi).  Graham's method implements a single classifer to detect whether a message is spam and triggers a positive when p(spam|xi)>.9.  I would expect the two classifer method to do better since it does not rely on choosing a threshold, but by my analysis, 47% of the spam2 collection is marked as ham, so clearly some more work is needed to understand true comparative performance.
    
Graham's method also looked at the most "interesting" words in the set, that is the words that had the strongestdisparity in frequency between the spam and ham training sets.  This makes intuitive sense as I'm not sure how longer spam emails prevent their spam score from being overwhelmed by neutral text.  Perhaps again, this is a wash since the neutral words would presumably wash out from appearing in both classifer corpuses (or neither).

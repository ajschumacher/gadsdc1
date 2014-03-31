###Collect some of the R techniques you learn as you go
###through the code. Include them here.

* file.path is a cool convenience function for quickly storing path variables
* runif() command allows for creating random uniform distributions by taking in
an n for number of arguments, a min and a max (respectively)
* Other file commands, including
  * opening
  * reading
  * closing





###There are also some negative points to be made about this code. Include observations along those lines here.

* One thing that drove me crazy was the inconsistent naming in the helper functions.  For example, the get.tdm function returns doc.dtm.  Is it tdm or dtm?? c'mon man.  






###Running the code, you'll encounter a harmless warning, twice. What is this warning and what does it mean?

The warning is just the readLines function whining about how some of the files
don't end with a newline.  Not a big deal.  It still reads the lines in.  


###Later, you'll get an actual error. What is it, why did it occur, and how did you fix it?

This error is a big problem.  Essentially, the error itself is complaining that
it can't perform an rbind operation on 3 different matrices, because the second
one (hardham2.final) doesn't have the proper number of columns.  Upon inspection
it is an empty matrix with no data.  By tracing back its variables and seeing
empty inputs, you eventually arrive at the fact that the path it is using
(data/hardham2) doesn't exist, because the hardham2 folder isn't in the dataset.

To fix this I went to the Machine Learning for Hackers Github
repo and downloaded the missing data.  Once the missing hardham2 folder was in
place, there was no error in the code execution.




###How many emails are in the training and test sets of this example code as we're running it?

* Training Set
  * Easy Ham: 2551
  * Hard Ham: 250
  * Spam:  500
* Test Set
  * Easy Ham: 1400
  * Hard Ham: 248
  * Spam: 1396


###Does the code calculate word frequencies? How/does it use them?

* Yes.  It calculates term frequencies within each email message and stores them in a Term Document Matrix. First, it only builds the TDM with words which appear more than once in the entire corpus.  This is due to a setting in the TM function TermDocumentMatrix's minDocFreq setting.  

* Term frequencies are utilized to calculate term occurrence (the likelihood a given email that is spam contains the term) and term density (the percentage of total terms which is made up of said term).  




### What is the training step of Naive Bayes? What does it "learn"?
How does this compare to KNN?

* The training step is simply to ingest a corpus of known spam, and then calculate the probability a given term will appear in a spam message.  This probability is stored in a table of terms.  

* When an unknown message (test data) is passed in, the terms pulled from the test are "matched" with the training set, and then the matched probabilities are multiplied.  

* This differs from KNN because instead of any kind of distance function, we are actually calculating a probablistic estimate based on two different comparisons, and picking the closer of the two.

What are what the code calls density and occurrence? What is used to predict?

* Occurrence is the probability that a given record contains a term 1 or more times.  

* Density is the proportion of total terms made up by a single term.  




### Does it matter whether a word appears in the test set that didn't appear in the training set? What happens?

* The word is essentially ignored, but its appearance contributes to the equation in the form of adding 1 to the msg.freq length, which offsets it not being in the probability calculation, essentially using the C variable in its place.  




### Which "type" of Naive Bayes does the code implement? (See: http://blog.datumbox.com/machine-learning-tutorial-the-naive-bayes-text-classifier/)

* It only counts an "occurrence" one time, and doesn't continue factoring this for a given likelihood function.  This means that it is using Binarized Multinomial Naive Bayes.



### What are some of the differences between this code and the method described by Paul Graham? Which method do you think would get better performance?

* Paul uses Multinomial Naive Bayes, instead of Binarized.  

* Paul wrote his code in Lisp.  (ok, ok, probably not the point)

* Paul's method, if implemented in R, would run slower, but perform better.  Instead of randomly pulling out default variables, he tuned his to ensure he didn't have false positives.

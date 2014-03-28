### Collect some of the R techniques you learn as you go through the code. Include them here. ###

* dir(): lists the files in a directory
* file(): create a connection to a file
* ggsave(): saves a ggplot
* intersect(): performs intersection between sets

### There are also some negative points to be made about this code. Include observations along those lines here. ###

* The most annoying thing is the commenting of functions. For example, get.tdm() is described as "Create a TermDocumentMatrix (TDM) from the corpus of SPAM email" (line 70). No! That's not correct. It's a generic function that creates a TDM from any corpus passed to it. This is legitimately confusing, especially when it is used to create a TDM from a corpus of HAM email.
	* Similar example for classify.email(): "The function returns the naive Bayes probability that the given email is SPAM" (line 109). Not an accurate statement.
	* Similar example for spam.classifier(): "attempt to classify the HARDHAM data" (line 250). Again, not accurate.
* Minor quibble: the code uses "c" as an argument to classify.email(), which is not recommended since "c" is a common function.
* In general, I found the ordering of the code blocks to be confusing. Perhaps it is in a logical order if you are reading a book and the pieces of code are being explained in this order, but if you're not reading the book, it appears to be a jumble of functions, plots, and code to execute those functions.

### Running the code, you'll encounter a harmless warning, twice. What is this warning and what does it mean? ###

* This is the only warning I encountered: "In readLines(con): incomplete final line found on 'data/spam/00136.faa39d8e816c70f23b4bb8758d8a74f0". I'm not positive why this is occurring, but I'm guessing it has to do with the special characters at the end of the email.

### Later, you'll get an actual error. What is it, why did it occur, and how did you fix it? ###

* Line 296: "Error in rbind(easyham2.final, hardham2.final, spam2.final) : number of columns of matrices must match (see arg 2)". This occured because we never downloaded a "hardham2" set of emails. I fixed it by removing the second argument.
* Maybe this is a Windows-only issue, but I also got an error on Line 139: "Error in seq.default(which(text == "")[1] + 1, length(text), 1) : wrong sign in 'by' argument". To fix it, I had to change the encoding from "latin1" to "native.enc" in the get.msg() function, as described on the book's [errata page](http://www.oreilly.com/catalog/errataunconfirmed.csp?isbn=0636920018483).

### How many emails are in the training and test sets of this example code as we're running it? ###

* training = 500 "spam" + 2550 "easy ham"
* test = 250 "hard ham" + 1400 "easy ham 2" + 1396 "spam 2"

### Does the code calculate word frequencies? How/does it use them? ###

* Yes, it counts the total number of times a word occurs in a matrix. It is used to calculate "density" (see below for definition).

### What is the training step of Naive Bayes? What does it "learn"? How does this compare to KNN? ###

* The training step of Naive Bayes is reading in the text for a given class (spam or ham), and for each word, calculating the "occurrence" (see below for definition).
* For each class, it learns the probability of seeing a given feature (a particular word).
* KNN learns the "locations" of all points, each of which has a class, but it doesn't really learn the "big picture" of the data. Naive Bayes, on the other hand, only sees the big picture, but on an individual feature level. That's how I think about it!

### What are what the code calls density and occurrence? What is used to predict? ###

* Occurrence: For each word that appears in the matrix, what percentage of the emails does it occur in (at least once)?
	* Example: If there are 500 emails in a corpus, an occurrence of 0.01 means that the word appears in 5 emails.
	* Occurrence is used in the classify.email() function as the P(xi | C) to calculate the likelihood function.
* Density: For each word that appears in the matrix, what percentage of all words does it represent?
	* Example: If there are 10000 words in a corpus, a density of 0.001 means that the word appears a total of 10 times.
	* As far as I can tell, density is not used to predict anything.

### Does it matter whether a word appears in the test set that didn't appear in the training set? What happens? ###

* If it appears in the test set but not the training set, classify.email() sets the score for that word to be 1e-6.

### Which "type" of Naive Bayes does the code implement? ###

* Binarized Multinomial Naive Bayes, because "occurrence" does not care whether a word appears more than once in a given email. Quote from the [article](http://blog.datumbox.com/machine-learning-tutorial-the-naive-bayes-text-classifier/): "The reasoning behind this is that the occurrence of the word matters more than the word frequency and thus weighting it multiple times does not improve the accuracy of the model."

### What are some of the differences between this code and the method described by Paul Graham? Which method do you think would get better performance? ###

* Differences:
	* Paul counts the total occurrences of a word, rather than a max of one per email.
	* Paul doubles the "weight" of words in ham emails, which this code doesn't.
	* Paul only considers words that occur at least 5 times, and I think this code's minimum is 2.
	* Paul sets the classification threshold at 0.9 rather than 0.5.
	* Paul scores a word that has never been seen at 0.4 instead of 1e-6.
	* Paul only uses the 15 most "interesting" words, whereas this code uses all the words.
* My guess is Paul's code will work better since he tuned his algorithm based on its real-world results, whereas this code was written as a teaching tool and thus was optimized for simplicity rather than accuracy.

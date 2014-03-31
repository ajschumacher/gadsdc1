# this needs to be reset depending on where this is run
setwd('/Users/andrew/Desktop/Projects/gadsdc1/06-naive_bayes/classifier/andrew')

rm(list=ls())
library(tm)

# build a term document matrix from files in a given directory
getTDM <- function(path, tdm_control) {
  directory <- DirSource(directory=path, encoding="latin1")
  doc_corp <- Corpus(directory)
  tdm <- TermDocumentMatrix(doc_corp, tdm_control)
  return(tdm)
}

# build training set of features
buildTrain <- function(tdm_pos, tdm_neg) {
  occ_pos <- apply(as.matrix(tdm_pos), 1, function(x) {
    length(x[x > 0]) / length(x)
  })
  df_pos <- data.frame(names=rownames(tdm_pos), pos=as.numeric(occ_pos))
  occ_neg <- apply(as.matrix(tdm_neg), 1, function(x) {
    length(x[x > 0]) / length(x)
  })
  df_neg <- data.frame(names=rownames(tdm_neg), neg=as.numeric(occ_neg))
  print(typeof(df_neg$neg))
  df_train <- merge(x=df_pos, y=df_neg, by=c('names'))
  df_train$prob <- (df_train$pos + df_train$neg) / 2
  df_train$spam_prob <- df_train$pos / (df_train$pos + df_train$neg)
  return(df_train)
}

# classification function to opearte on a single test message
classifyEmail <- function(path, tdm_control, model, prior, d_val=0.5, n=10) {
  # read in message to vector
  con = file(path, open="rt", encoding="latin1")
  text = paste(readLines(con), collapse="\n")
  close(con)
  
  # create the tdm
  tdm <- TermDocumentMatrix(Corpus(VectorSource(text)), tdm_control)
  words <- rownames(tdm)
  
  # df of spam probs
  probs_spam <- sapply(words, function(x) {
    if (nrow(model[model$names==x, ]) > 0){
      return(model[model$names==x, c('spam_prob')])
    } else {
      return(d_val)
    }
  })
  
  # df of probs
  probs <- sapply(words, function(x) {
    if (nrow(model[model$names==x, ]) > 0){
      return(model[model$names==x, c('prob')])
    } else {
      return(d_val)
    }
  })
  
  # subset to top_n spam_probs and probs
  interest_spam <- abs(probs_spam - 0.5)
  top_n <- order(interest_spam, decreasing=TRUE)
  probs_spam <- probs_spam[top_n]
  probs <- probs[top_n]
  
  # bayesian formula
  result <- (prod(probs_spam) * prior)
  return(result)
}


tdm_control <- list(stopwords = T, removePunctuation = T, removeNumbers = T, minDocFreq = 2)
w_dir <- getwd()
easy_ham_path <- c(paste0(w_dir, '/emails/easy_ham/'))
spam_path <- c(paste0(w_dir, '/emails/spam/'))
easy_ham_tdm <- getTDM(path=easy_ham_path, tdm_control=tdm_control)
spam_tdm <- getTDM(path=spam_path, tdm_control=tdm_control)
model <- buildTrain(spam_tdm, easy_ham_tdm)

hard_ham_path <- c(paste0(w_dir, '/emails/hard_ham/'))
test_email <- paste0(hard_ham_path, list.files(hard_ham_path)[1])
print(test_email)
classifyEmail(path=test_email, tdm_control=tdm_control, model=model, prior=0.5)

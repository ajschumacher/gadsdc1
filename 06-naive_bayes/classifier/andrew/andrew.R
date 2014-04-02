# this needs to be reset depending on where this is run
setwd('C:/Users/linville_a/Desktop/gadsdc1/06-naive_bayes/classifier/andrew')

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
  
  # vector of positive occurences
  occ_pos <- apply(as.matrix(tdm_pos), 1, function(x) {
    length(x[x > 0]) / length(x)
  })
  names(occ_pos) <- rownames(tdm_pos)
  
  # vector of negative occurences
  occ_neg <- apply(as.matrix(tdm_neg), 1, function(x) {
    length(x[x > 0]) / length(x)
  })
  names(occ_neg) <- rownames(tdm_neg)
  
  # combine occurences in a list and return
  occ_list <- list('pos'=occ_pos, 'neg'=occ_neg)
  return(occ_list)
}

# classification function to opearte on a single test message
classifyEmail <- function(path, tdm_control, model, prior, d_val=0.5) {
  
  # read in message to vector
  con = file(path, open="rt", encoding="latin1")
  text = paste(readLines(con), collapse="\n")
  close(con)
  
  # create the tdm and extract words
  tdm <- TermDocumentMatrix(Corpus(VectorSource(text)), tdm_control)
  words <- rownames(tdm)
  
  # prob spam
  probs_spam <- sapply(words, function(x) {
    if (is.na(model$pos[x])) {
      return(d_val)
    } else {
      return(model$pos[x])
    }
  })
  prob_spam <- prod(probs_spam) * prior
  
  # prob ham
  probs_ham <- sapply(words, function(x) {
    if (is.na(model$neg[x])) {
      return(d_val)
    } else {
      return(model$neg[x])
    }
  })
  prob_ham <- prod(probs_ham) * prior
  
  # compare spam and ham probs and return
  result <- as.numeric(prob_spam > prob_ham)
  return(result)
}

# wrapper on classifyEmail to operate on a full directory of emails
classifySet <- function(path, tdm_control, model, prior, d_val=0.000001) {
  
  # get emails into a list
  emails <- list.files(path)
  
  # apply across email for vector of results
  result <- sapply(emails, function(x) {
    email_path= paste0(path, x)
    is_pos <- classifyEmail(email_path, tdm_control, model, prior, d_val)
    return(is_pos)
  })
  
  # return
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
result <- classifySet(path=hard_ham_path, tdm_control=tdm_control, model=model, prior=0.5)

#summarizing the results
mean(result)
# 0.004

length(result)
# 250

sum(is.na(result))
# 0


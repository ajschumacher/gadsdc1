import numpy as np
import pandas as pd
#Let's pull in the voter data I scraped from twitter (code is in separate file)
tweets_party = pd.read_csv('tweets_party.csv')
# ### Now that we have our tweets text in a list, let's start running sklearn
from sklearn.feature_extraction.text import CountVectorizer
# #### Let's build a better vectorizer by extending the CountVectorizer function and overwriting the "build_analyzer" function with a customized stemmer pulled in from nltk
import nltk.stem
english_stemmer = nltk.stem.SnowballStemmer('english')
class StemmedCountVectorizer(CountVectorizer):
    def build_analyzer(self):
        analyzer = super(StemmedCountVectorizer, self).build_analyzer()
        return lambda doc: (english_stemmer.stem(w) for w in analyzer(doc))

vectorizer = StemmedCountVectorizer(min_df=1, stop_words='english')
counts = vectorizer.fit_transform(tweets_party.tweet)

from sklearn.naive_bayes import MultinomialNB


classifier = MultinomialNB()

# Here we need to cast the dtype of party_affiliation.  The classifier
# doesn't always pick it up, and it will choke and spit out an error
targets = np.asarray(tweets_party.party_affiliation, dtype="|S6")


classifier.fit(counts,targets)

#insert mean, stereotypically partisan phrases here.
examples = ['I love Jesus, lets go hunting!', 'Legalize marijuana now! Peace and love']


example_counts = vectorizer.transform(examples)


predictions = classifier.predict(example_counts)


predictions

# ##  output: array(['REP', 'DEM'],
#       dtype='|S3')

#Success!!  

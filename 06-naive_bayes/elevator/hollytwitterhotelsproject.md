Social media and brand marketing for the hotel industry
========================================================

Brands are increasingly looking to build a deeper engagement with their customers and view social media an opportunity to create ongoing conversations about the brand, its products, and the customers' needs and wants.  Some brand conversations are initiated by customers, usually revolving around customer service or reviews.  Other conversations are initiated by brand marketing organziations and try to drum up buzz around existing marketing programs or new campaigns developed specifically for social channels.  This study will examine this second kind of conversation and attempt to understand the effectiveness of brand led campaigns at generating this buzz and fostering genuine customer response.  

In this study, we will look at how the top brands in the hotel industry are using Twitter and attempt to measure the customer response.  In the case that brands are pushing marketing-specific hashtags or initiating campaigns, we will quantify who is using these hashtags and attempt to derive sentiment.  In parallel, we will also gather Twitter data for all references to a few selected brands (not just promotional hashtags) and again attempt to quantify who is driving the conversations (brands, hotels, or customers), which conversations gain traction, and derive overall sentiment. 

This study will document a variety of data handling and machine learning techniques, coupled with manual inspection for categorization.  First step is to understand and set up a feed to the Twitter JSON API, possibly on an AWS instance for full time data capture.  Data will be analyzed in Python, likely using the NLTK package.  I am also interested to explore other Natural Language Processing packages (e.g. Google's word2vec, others?), and will need to determine a training corpus to use to determine the positivity or negativity of words in Twitter.  Plotting may be run in R or Python.  

I will be interested in determining other appropriate unsupervised learning techniques to make sense of the data, but need to research further once I have the data pulls in progress. 


### Tactical planning as of 29 March 2014

1) Week of Mar 30 - Determine official twitter accounts for brand and loyalty programs for five top full service hotel brands (Marriott, Hilton, Hyatt, Sheraton, Holiday Inn).  Collect and review one week of tweets and extract hashtags.  Identify promotional hashtags (e.g. #BeAWeekender, #TravelBrilliantly) and top brand twitter accounts to follow longer term by April 6.

2) Weeks of Apr 6 and 13 - Pull two weeks of references to promotional hashtags.  Analysis questions will include - How many are by the hotel company (corporate or hotels) vs. consumers?  Are these being retweeted?  Can we determine consumer sentiment?

3) Weeks of Apr 6 and 13 - In parallel, pull two weeks of all Twitter references to selected hotel companies (keep ongoing?).  Analysis questions will include - Again, how many are by the hotel company vs. consumers?  What conversations are gaining the largest audience?  Can we determine the proportion that a referring to the brand overall vs. a specific hotel?  Can we detect sentiment?

4) April in general - research tools and NLP methods. Will begin with loading JSON data into Python, parsing out hashtags and understanding Twitter data in general.  Further project outline by week of April 20.

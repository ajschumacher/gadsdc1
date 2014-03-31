## Identifying Partisan Affiliation Via Analysis of Tweets

Using data sourced from a political microtargeting startup (Makindo),
I'd like to construct a predictive model of partisan affiliation based on
various terms used in messages on the microblogging platform known as Twitter.

Based on certain words, phrases, etc, is the person tweeting a Republican, Democrat,
or Non-Partisan/Independent?  Ideally, identification of phrases/words which have seemingly
nothing to do with politics (foods, music, movies, stores, restaurants,etc) could help
identify the likely partisan affiliation of a person whether or not they ever discuss politics
on Twitter.  

### Timeline as of March 31st (Activities may be revised based on feasibility of project)

* March 31 - April 6th
  * Munge/analyze Florida Voter History Files received from Makindo
  * Evaluate feasibility of locating voters on Twitter, and/or utilizing Makindo join.
  * "Joined" voters represent Voter History records of people who have been "matched" to their Twitter profile.  The voter history records provide a known partisan affiliation.  
    * This is the key to the training data
* April 7th - April 14th
  * Sample tweets from various geographic locations in the state of Florida
    * Set up a pipeline which will collect JSON data for 3 different geo-bounded locations in Florida using the Twitter API
    * This will be test data
  * Use the Makindo "Joined" voters:  
    * Scrape all tweets for each "Joined" voter for several months
    * Store in CSV file(s)
* April 15th - April 21st
  * Test various machine learning/supervised/unsuperivsed learning techniques on training data.  
  * Guage accuracy.  
* TBD

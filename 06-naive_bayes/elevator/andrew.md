Andrew's Project Ideas:
=======================

I know this probably isn't cool at this point, but I'm still operating with three separate project ideas. The first two are fallbacks if the third doesn't work out (if I can't get data). If the third doesn't work out, I think I might prefer to do the second, but am still undecided.

###1. Kaggle: Allstate Purchas Prediction Challenge
Predict the plan choices of Allstate shoppers given a limited subset of the quotes they've viewed. This is a competition hosted by [Kaggle](http://www.kaggle.com/c/allstate-purchase-prediction-challenge), so all the data is available online.

###2. Kaggle: Facial Keypoints Detection
Predict the location of facial keypoints. This is another challenge hosted by [Kaggle](http://www.kaggle.com/c/facial-keypoints-detection). I've started working through this already, in part because it dovetails nicely with my application presentation. I've written the benchmark models described in the [Getting Started with R](http://www.kaggle.com/c/facial-keypoints-detection/details/getting-started-with-r) page. All of my code is on [GitHub](https://github.com/andlinville/facial-keypoints). I've also begun working my way through [Viola and Jones' paper](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.110.4868) on object detection referenced at the end of the R tutorial, to get a sense of next steps.

###3. 730DC Click prediction
[730DC](http://730dc.tumblr.com/) is a work-day-morning (hence the name and logo) email newsletter that gives information about local dc news and events. The newsletter is geared towards millenials, and is run by some folks at the Atlantic. It is relatively new, and has a growing base of subscribers, which as of this writing totals 730. Each issue contains about 10-12 pieces (Weds holds a preview of events for the week ahead, and so contains about double the number of pieces), each containing a topic word, and a 2-4 line description (of an article, an event, etc.) with hyperlinks somewhere in the description.

I want to try to write a classifier, similar to the spam filters that we've discussed in class, that would predict the likelihood that a given user will click one of the hyperlinks in a given piece based on the text of that piece. The classifier could be broadly useful: as an editorial tool going forward, for its depiction of the user base, etc.

The main obstacle is getting the click data. I have a friend at the Atlantic who is involved in producing the newsletter. I have an email out to him about whether this would be feasible. Fingers crossed--I think it could be a really cool project!
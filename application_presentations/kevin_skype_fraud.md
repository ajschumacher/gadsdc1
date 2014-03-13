## Detecting Fraudulent Skype Users via Machine Learning

My presentation is about using machine learning to detect fraud on Skype, and is based upon an [excellent paper by Microsoft Research](http://research.microsoft.com/pubs/205472/aisec10-leontjeva.pdf) published in November 2013. The paper provides a great introduction to the modern machine learning workflow and does not require a statistics background to understand. Alternatively, you can read a [less technical article](http://www.cso.com.au/article/536286/new_research_signals_trouble_skype_fraudsters/) summarizing the paper.

Although Skype already had measures in place to detect fraud (e.g., credit card fraud, spam instant messages), the research team's goal was to **improve the detection of "stealthy fraudulent users" that evade Skype's defenses** for a prolonged period. They built a machine learning classifier that flagged potentially fraudulent users, and was able to detect 68% of these users with a false positive rate of 5%. The novelty in their approach was the fusing of disparate data types (profile information, Skype product usage, and Skype social activity) into a single classifier.

My presentation slides are on [Speaker Deck](https://speakerdeck.com/justmarkham/detecting-fraudulent-skype-users-via-machine-learning).

My blog post about the presentation is on [Data School](http://www.dataschool.io/detecting-fraudulent-skype-users-via-machine-learning/).
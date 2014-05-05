cd ~/Desktop/programming/Python/twitter

full_term_list = ["HiltonHotels", "HiltonHHonors", "HiltonWorldwide", "Hilton", "Marriott", "MarriottIntl", "RenHotels", "sheratonhotels", "spg", "westin", "whotels", "starwood", "starwoodbuzz", "ihgrewardsclub", "HolidayInn", "hotelindigo", "crowneplaza", "hyatttweets", "#TravelBrilliantly", "#BeAWeekender", "#spglife", "#RDiscover", "#DiscoverIHG", "#gotmysweaton", "#ineedthatbreak"]
term_string = ", ".join(full_term_list)

# Following code extracts a few relevant data fields out of the Twitter Streaming API
# Create as individual lists then lump into a dict and create as a dataframe

import pandas
import re

filename = "output_follow_Apr20_to_May3.txt"
full_term_list = [term.lower() for term in full_term_list]

fp = open(filename)
count = 0
users = []
created = []
text = []
retweets = []
hashtags = []
tweetid = []
favorite = []
list_of_term_list = []

error_lines = []

for ii in range(270000):     
  line = fp.readline()    # each tweet is a line
  try:
      line = eval(line)     # and now each line is a dict
      if line['lang'] == 'en':   # select only english labeled texts
        users.append(line['user']['screen_name'].lower())   # and start creating vectors (will dataframe in a bit)
        created.append(line['created_at'])
        text.append(re.sub(',',' ', line['text']).lower())    # replace commas with spaces for csv output
        retweets.append(line['retweet_count'])  
        tweetid.append(line['id'])
        favorite.append(line['favorite_count'])
        count += 1
    
        # May be multiple hashtags in the tweet - capture all in a space separated string
        tag_list = ''
        for tag in line['entities']['hashtags']:
            tag_list += tag['text'].lower() + " "   
        hashtags.append(tag_list) 
    
        # Similarly may be multiple terms - search text and user for items in term_list    
        term_list = ""
        for term in full_term_list:
            if line['text'].lower().find(term) >=0 or line['user']['screen_name'].lower().find(term) >= 0:
                term_list += term + " "
        list_of_term_list.append(term_list)
        
  except:
        error_lines.append(ii)
     
# now make the dataframe by creating a dict and then using pandas.DataFrame to convert
data = {'id':tweetid, 'user':users, 'text':text, 'terms':list_of_term_list, 'hashtags':hashtags, 'created':created, 'retweets':retweets, 'favorites':favorite} 
tweet_df = pandas.DataFrame(data)  

tweet_df.to_csv('csvout.csv', encoding='utf-8')
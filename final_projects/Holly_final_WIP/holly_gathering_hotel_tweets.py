# Text of twitter capture file - updated 20 Apr 14, keys and secrets removed

#!/usr/bin/env python

from TwitterAPI import TwitterAPI
import time

consumer_key = 
consumer_secret = 
access_token_key = 
access_token_secret = 

file_location = "output_follow.txt"

# create new iterations by using term_string above
full_term_list = ["HiltonHotels", "HiltonHHonors", "HiltonWorldwide", "Hilton", "Marriott", "MarriottIntl", "RenHotels", "sheratonhotels", "spg", "westin", "whotels", "starwood", "starwoodbuzz", "ihgrewardsclub", "HolidayInn", "hotelindigo", "crowneplaza", "hyatttweets", "#TravelBrilliantly", "#BeAWeekender", "#spglife", "#RDiscover", "#DiscoverIHG", "#gotmysweaton", "#ineedthatbreak"]
term_string = ", ".join(full_term_list)
FOLLOW_TERM = term_string

delay = 8 # seconds

while True:
    try:
        api = TwitterAPI(consumer_key, consumer_secret,
                         access_token_key, access_token_secret)
        r = api.request('statuses/filter', {'track':FOLLOW_TERM})
        with open(file_location, "a") as output:
            for item in r.get_iterator():
                output.write(str(item) + "\n")
                #print(item['text'] if 'text' in item else item)
            delay = max(8, delay/2)
    except:
        print "Error"
        print time.ctime()
        print "Waiting " + str(delay) + " seconds"
        time.sleep(delay)
        delay *= 2
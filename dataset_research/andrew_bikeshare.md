#Capital Bikeshare System Data

Capital Bikeshare is a bikeshare system based in Washington DC, Northern Virginia and Maryland. Users can checkout any of the system's bikes, ride for 30 minutes, and dock their bike in any location for no charge. The system has expanded considerably since its inception in 2008 and now includes about 250 docking stations, 2.5K bikes and 40K annual members. Capital Bikeshare makes its usage data available for free on its website [here](http://capitalbikeshare.com/trip-history-data). Each ride is a single observation in the data, and the fields include start and end time, start and end location, bike identifier and membership status.

###Getting the Data
I was unable to download the data directly from the website with R. Instead I downloaded each quarter's dataset by hand into a directory called 'data'

```shell
cd data
ls | cat
2010-4th-quarter.csv
2011-1st-quarter.csv
2011-2nd-quarter.csv
2011-3rd-quarter.csv
2011-4th-quarter.csv
2012-1st-quarter.csv
2012-2nd-quarter.csv
2012-3rd-quarter.csv
2012-4th-quarter.csv
2013-1st-quarter.csv
2013-2nd-quarter.csv
2013-3rd-quarter.csv
```

From there, the following code reads and appends all the data:

```R
setwd("/Users/andrew/Desktop/Projects/dataset-research")

# take a look at each dataset
# store field names in a vector
files <- list.files('data')
fields <- c()
datasets <- list()
for (f in files) {
  print(f)
  quarter_data <- read.csv(paste0('./data/', f), stringsAsFactors=F)
  print(nrow(quarter_data))
  datasets <- c(datasets, list(quarter_data))
  fields <- c(fields, names(quarter_data))
}

# dealing with field names (this is done somewhat manually)
fields <- unique(fields)
clean_fields <- c(
  'duration', 'start.date', 'end.date', 'start.station', 'end.station', 'bike', 'subscription',
  'duration.sec', 'start.station', 'start.terminal', 'end.station', 'end.terminal', 'subscription', 
  'duration.sec', 'start.terminal', 'end.terminal', 'subscription', 'subscription', 'subscription','start.date'
  )

# append datasets
trip_history <- NULL
for (d in datasets) {
  names(d) <- clean_fields[fields %in% names(d)]
  if (! "start.terminal" %in% names(d)) {
    m_start <- rep(NA, nrow(d))
    m <- regexpr("[0-9]{5}", d$start.station)
    m_start[m!=-1] <- regmatches(d$start.station, m)
    d$start.terminal <- m_start
    m_end <- rep(NA, nrow(d))
    m <- regexpr("[0-9]{5}", d$end.station)
    m_end[m!=-1] <- regmatches(d$end.station, m)
    d$end.terminal <- m_end
  }
  if ("duration.sec" %in% names(d)) {
    d$duration.sec <- NULL
  }
  col_sort <- c('duration', 'start.date', 'start.station', 'start.terminal', 'end.date',
                'end.station', 'end.terminal', 'bike','subscription')
  d <- d[, col_sort]
  trip_history <- rbind(trip_history, d)
}

# 'data.frame':	5996361 obs. of  9 variables:
# $ duration      : chr  "14h 26min. 2sec." "0h 8min. 34sec." "0h 12min. 17sec." "0h 15min. 53sec." ...
# $ start.date    : chr  "12/31/2010 23:49" "12/31/2010 23:37" "12/31/2010 23:27" "12/31/2010 23:21" ...
# $ start.station : chr  "10th & U St NW (31111)" "10th & U St NW (31111)" "Park Rd & Holmead Pl NW (31602)" "Calvert St & Woodley Pl NW (31106)" ...
# $ start.terminal: chr  "31111" "31111" "31602" "31106" ...
# $ end.date      : chr  "1/1/2011 14:15" "12/31/2010 23:46" "12/31/2010 23:39" "12/31/2010 23:37" ...
# $ end.station   : chr  "10th & U St NW (31111)" "14th & R St NW (31202)" "14th St & Spring Rd NW (31401)" "14th St & Spring Rd NW (31401)" ...
# $ end.terminal  : chr  "31111" "31202" "31401" "31401" ...
# $ bike          : chr  "W00771" "W01119" "W00973" "W00914" ...
# $ subscription  : chr  "Casual" "Registered" "Registered" "Registered" ...
```
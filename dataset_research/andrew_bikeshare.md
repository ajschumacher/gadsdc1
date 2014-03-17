###Capital Bikeshare System Data

Capital Bikeshare is bikeshare system that began in Washington, DC in 2008. Different membership levels are available: 1 day, 7 days, 1 year. Members can checkout any of the system's bikes, ride for 30 minutes, and dock their bike in any location for no charge. The system has expanded considerably since its inception and now includes about 250 docking stations, 2.5K bikes and 40K annual members. Capital Bikeshare makes its usage data available for free on its website [here](http://capitalbikeshare.com/trip-history-data). Each ride is a single observation in the data, and the fields include start and end time, start and end location, bike identifier and membership status.

#Getting the Data
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
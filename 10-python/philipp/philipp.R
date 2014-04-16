setwd("/Users/philipp/Desktop")

data <- read.csv("Consumer_Complaints.csv")
head(data)
str(data)

library(ggplot2)
library(maps)

test <- as.Date(data$Date.received, format = "%m/%d/%Y")

# first image
one <- ggplot(data, aes(Product))
one + geom_bar()

# second image
two <- qplot(test, geom="histogram") + geom_histogram(colour = "darkgreen", fill = "white")
two
update_labels(two, list(x = "Date", y = "Monthly Complaint Volume"))


# third image
pie <- ggplot(data, aes(x = factor(1), fill = Company.response)) +
  geom_bar(width = 1)
three <- pie + coord_polar(theta = "y")
three
update_labels(three, list(x = "", y = "(Count of complaints)"))



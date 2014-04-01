batting <- read.csv("/Users/johnkabler/gadsdata/baseball/batting.csv")
salaries <- read.csv("/Users/johnkabler/gadsdata/baseball//salaries.csv")
master <- read.csv("/Users/johnkabler/gadsdata/baseball/master.csv")


rbi_year <- batting[, c("playerID", "yearID", "RBI")]

sal_year <- salaries[, c("playerID", "yearID", "salary")]

rbi_sal_year <- merge(rbi_year, sal_year)

rbi_sal_year <- rbi_sal_year[!is.na(rbi_sal_year[, 3]), ]

fit <- lm(salary ~ RBI + yearID, data=rbi_sal_year)
summary(fit)
# Call:
#   lm(formula = salary ~ RBI + yearID, data = rbi_sal_year)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -5962692 -1526947  -540657   644991 27615522 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -2.812e+08  4.832e+06  -58.20   <2e-16 ***
#   RBI          2.770e+04  6.029e+02   45.94   <2e-16 ***
#   yearID       1.413e+05  2.417e+03   58.47   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 2745000 on 21891 degrees of freedom
# Multiple R-squared:  0.1955,  Adjusted R-squared:  0.1954 
# F-statistic:  2660 on 2 and 21891 DF,  p-value: < 2.2e-16

# I want to isolate to a single year, since inflation complicates things. 

rbi_sal_2012 <- rbi_sal_year[rbi_sal_year$yearID == 2012, ]

# There are still a lot of zeros for RBI.  It seems that these are non-hitting players??

fit2012 <- lm(salary ~ RBI, data=rbi_sal_2012)
summary(fit2012)

# Call:
#   lm(formula = salary ~ RBI, data = rbi_sal_2012)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -6879865 -2345848 -1911065  1346971 24676053 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  2633897     196402   13.41   <2e-16 ***
#   RBI            47194       5533    8.53   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 4647000 on 852 degrees of freedom
# Multiple R-squared:  0.07868,  Adjusted R-squared:  0.07759 
# F-statistic: 72.76 on 1 and 852 DF,  p-value: < 2.2e-16

plot(salary ~ RBI, data=rbi_sal_2012)

# It looks like the pitchers are throwing this off, because there are a lot of
# highly paid players clustered at zero.  

rbi_sal_2012_corrected <- rbi_sal_2012[rbi_sal_2012$RBI != 0, ]
plot(salary ~ RBI, data=rbi_sal_2012_corrected)

fit_2012_clean <- lm(salary ~ RBI, data=rbi_sal_2012_corrected)
summary(fit_2012_clean)
# 
# Call:
#   lm(formula = salary ~ RBI, data = rbi_sal_2012_corrected)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -6952783 -2879396 -2091309  1410739 24682011 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  2530201     329967   7.668 8.32e-14 ***
#   RBI            48909       7364   6.641 7.67e-11 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 5131000 on 534 degrees of freedom
# Multiple R-squared:  0.0763,  Adjusted R-squared:  0.07457 
# F-statistic: 44.11 on 1 and 534 DF,  p-value: 7.667e-11

plot(salary ~ RBI, data=rbi_sal_2012_corrected)
abline(fit_2012_clean, col="red")

#Much better

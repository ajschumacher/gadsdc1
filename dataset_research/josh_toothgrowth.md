Okay, my dataset is on measuring the Toothgrowth of Guinea Pigs based on how much Vitamin C
they are given and on how its administered (via Orange Juice, or straight up absorbic acid (vitamin c)
The research was conducted sometime before 1952, when a biostatistician named CI Bliss used it in a treatise on bio statistics
, with it being revisited multiple times by different folks writing textbooks on data analysis.

Dataset is comprised of three variables - length of tooth, type of vitamin c supplement, and number of milligrams dosed
[,1]	 len	 numeric	 Tooth length
[,2]	 supp	 factor	 Supplement type (VC or OJ).
[,3]	 dose	 numeric	 Dose in milligrams.

loading the dataset into a data frame was easy, since its built into R..
just typed:
ToothGrowth <- ToothGrowth
and its loaded
to find out simple statistics.. just typed in:
summary(ToothGrowth)
and got:
     len        supp         dose      
 Min.   : 4.20   OJ:30   Min.   :0.500  
 1st Qu.:13.07   VC:30   1st Qu.:0.500  
 Median :19.25           Median :1.000  
 Mean   :18.81           Mean   :1.167  
 3rd Qu.:25.27           3rd Qu.:2.000  
 Max.   :33.90           Max.   :2.000  
 
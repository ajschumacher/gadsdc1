R Research Boston Dataset
=================


What are the structure and contents of your dataset? (Number of records, columns, missing values, etc.)
>The Boston data frame consists of 14 variables with 506 rows. Each column contains
>numeric data, many of which may be percentage values (<1). The column 'chas' however contains only 0 and 1,
>which likely represents a boolean.  There are no missing values or null values in any of the columns.

What is the history of your dataset (How was it created?)
>The dataset was originally used in a paper published in the Journal of Environmental Economics and Management by 
>Harrison and Rubinfeld entitled "Hedonic Housing Prices and the Demand for Clean Air." Much
>of the data is gleaned from 1970 census tract data, but it is a compilation from other sources as well. The original 
>purpose of the dataset was to explore the relationship between air pollution and housing prices. The other
>included variables were controls for possibly confounding effects. 

Has your dataset been written about? What have others used it for?
>I have personally used the data set once before in a book entitled "Data Mining for Business Intelligence"
>Shmueli, et al. The data set is used frequently for teaching purposes. Several websites
>have it available for download in excel or csv format. One [website] (http://www.cs.toronto.edu/~delve/data/boston/bostonDetail.html)
>also mentions its use for algorithm benchmarking.

How do you acquire and load the dataset into R? (Include code.)
>The dataset comes as part of a package called "MASS" and can be loaded with the following
>
>>install.packages("MASS")
>>library("MASS")
>>data(Boston)
>>View(Boston)
>

What are some simple statistics describing the dataset?
>The original dependent variable, *medv* ranges from 5 to 50, represnting
>home values from $5,000 to $50,000 . The original independent variable of 
>interest, *nox*, ranges from .3850 to .8710, representing nitrogen oxide
>amounts in parts per million. The *chas* variable consists of 471 observations equal to FALSE
>and 35 equal to TRUE, representing houses not on and on the Charles river, respectively.
>Without controlling for anything else, *nox* and *medv* correlate at -.427.
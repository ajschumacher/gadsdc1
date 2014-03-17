
euler8 <- function() {
  
  # Function solves Project Euler 8: find the largest multiple of 5 consecutive digits of given 1000 digit number
  # Brute force method used, trickiest bit was to get the 1000 digit number as a single string
  # Questions - most efficient ways to get substrings, printing mixed strings/numbers, reshaping the dataframe with reshape or plyr??
  # Could I / should I vectorize somehow?  Seems like it worked well enough without
  
  
  # Read in number from text file - defined colClasses else it will read in as numeric with scientific notation
  euler_tab <- read.table("euler8.txt",colClasses="character")  
  
  # Loop through the resulting dataframe and paste into a single string - is there a package that does this?
  # Note the sep option in paste to remove spaces between lines, see also required referencing to extract the string
  longline = ""
  for (i in 1:nrow(euler_tab))    {
    longline = paste(longline, euler_tab[i,1], sep="")   
  }
  
  # Iterate through the string constructing windows of five digits to test 
  # j is first elt of the window, k iteratively multiplies in all digits within the window
  # Catches new top_mult when the window product is greater than highest previously seen
  top_mult = 0
  for (j in 1:(nchar(longline)-4))    {
    curr_mult=1
    for (kk in 0:4)   {
      curr_mult <- curr_mult*as.numeric(substr(longline, j+kk,j+kk))  # complex way to extract a single digit as numeric - a better way?
    }
    if (curr_mult > top_mult) {
      top_mult <- curr_mult
    }
  }
  
  print(top_mult)

}

print(system.time(euler8()))
monty_hall <- function() {
  items <- c("goat", "goat", "car")
  doors <- sample(items, 3)
  #i <- 0
  #while(i < 4) {
  #  doors[i] <- sample(items,1)
  #  i <- i + 1
  #}

  contestant_choice <- sample(doors, 1)
  val <- match(contestant_choice, doors)
  doors <- doors[-val]
  host_choice <- "goat"
  val2 <- match(host_choice, doors)
  doors <- doors[-val2]
  print(doors)
}

game.result <- replicate(1000, monty_hall())
switch.wins <- game.result[game.result == "car"]
firstchoice.wins <- game.result[game.result == "goat"]
cat("The simulation ran 1000 times.")
cat("The probability a player's first choice gets the car is ", length(firstchoice.wins)/1000)
cat("The probability a player switch wins the car is ", length(switch.wins)/1000)





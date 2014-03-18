#Monty Hall Simulator



MontyHall<-function(strategy){
  
  #You have three doors, behind two of which are goats and one is a car.
  doors<-c('Goat','Goat','Car')
  
  #You select one at random.
  my.choice <-sample(doors, 1, replace=FALSE)
  
  #Of the two you have not chosen, Monty opens one and reveals a goat.
  current.doors<-c('Goat','Car')
  
  #You can either stay with your original choice
  if (strategy=="stay"){
    my.choice<-my.choice
  #Or you can switch to pick the other door      
  } else if (strategy=='switch'){
    my.choice <- current.doors[current.doors!=my.choice]
  }
  return (my.choice)
}

result.set.stay<-vector()
for (x in 1:100){
  result.set.stay<-rbind(result.set.stay, MontyHall('stay'))
}

result.set.switch<-vector()
for (x in 1:100){
  result.set.switch<-rbind(result.set.switch, MontyHall('switch'))
}
summary(result.set.stay)
summary(result.set.switch)
rm(list=ls())

source("myLib.R")

a <- list(as.double(5),"ab",as.double(10))

for(x in a){
  print(paste("processing ",x))
  tryCatch({
    z <- myFunc(x)
    print(paste("completed ",x))},
    error = function(e){
      print(paste("Error caught in while processing",x))
    })
   
}

print("Last statement")


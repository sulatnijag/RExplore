myFunc = function(z){
  ret <- tryCatch(
    {
      x = 1+z
    }, error=function(e){
      stop(e)
    },finally={
      print(paste0("finally message ", z))
    }
  )
}


.Last <- function(){
  print("message from .Last")
}
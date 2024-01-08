library(plumber)

r <- plumb("miPlumber.R")
r$run(port=8000)

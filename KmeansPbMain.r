library(plumber)
r <- plumb("AspiradorasPb.r")
r$run(port=8000)

# curl "http://localhost:8000/getCluster?calificacion=0.25211944&precio=0.93263805&peso=-0.77603279&potencia=0.00000000&largo=-0.03199491&ancho=0.43090931&alto=0.61576282"

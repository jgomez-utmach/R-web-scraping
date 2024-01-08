#* @param calificacion
#* @param precio
#* @param peso
#* @param potencia
#* @param largo
#* @param ancho
#* @param alto
#* @get /getCluster

function(calificacion, precio, peso, potencia, largo, ancho, alto) {
  campos <- c(calificacion, precio, peso, potencia, largo, ancho, alto)
  midist <- matrix(0, ncol=11, nrow=7)
  for(i in 1:7){
    c <- dist(x=c(campos[i], mycluster$centers[, i]))
    b <- as.matrix(c)
    distancia <- b[-1, 1]
    midist[i,] <- distancia
  }
  rownames(midist) <- c("Calificacion", "Precio", "Peso", "Potencia", "Largo", "Ancho", "Alto")

  dist_total <- apply(midist, 2, sum)
  num_cluster <- which.min(dist_total)
  res <- paste("cluster_numero:", num_cluster)
}

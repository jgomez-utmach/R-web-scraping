# SIMULANDO EL CALCULO DE LA DISTANCIA ENTRE LOS CENTROIDES Y
# LOS DATOS DE UN NUEVO ELEMENTO (campos)

# Nuevos datos
campos <- as.vector(data[1, ])
# Creo la matriz de 11x7: 11 clusters y 7 campos
midist <- matrix(0, ncol=11, nrow=7)

# Calculo la distancia entre los centroides y los datos de un nuevo elemento
for(i in 1:7){
  # Calculo la distancia entre los elementos de un vector
  c <- dist(x=c(campos[i], mycluster$centers[, i]))
  # Convierto el objeto dist en una matriz
  b <- as.matrix(c)
  # Elimino la primera fila y selecciono la primera columna
  distancia <- b[-1, 1]
  # Guardo la distancia en la matriz
  midist[i,] <- distancia
}
# Asigno los nombres de las filas
rownames(midist) <- c("Calificacion", "Precio", "Peso", "Potencia", "Largo", "Ancho", "Alto")

# dist() calcula la distancia entre los elementos de un vector ejm:
# dist(x=c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
# por columna calcula la distancia entre
# 1 y 2,3... luego entre 2 y 3,4... y así sucesivamente

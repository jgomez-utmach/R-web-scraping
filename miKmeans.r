data <- res_limpio

# Eliminamos las columnas que no nos interesan
quitar_col <- c(1, 6)
data <- data[, - quitar_col]

# Nota: Anteriormente dimos a los datos un formatode 4 decimales, OMITELO!!

# Ajustar lo datos a la misma escala (estandarización)
# scale(): Resta la media a cada valor y divide por la desviación típica
data <- scale(data)


# Calculando la suma de los cuadrados de la distancia euclídea entre
# cada punto observación y el centroide del cluster mas cercano

# REALIZANDO CALCULO PARA 1 CLUSTER
# Sumando la varianza de cada columna de datos y
# multiplicandolo por el número de filas menos 1
wss <- (nrow(data) - 1) * sum(apply(data, 2, var))

# REALIZANDO CALCULO PARA 2 a 15 CLUSTERS
# Obteniendo la suma de los cuadrados para cada número de clusters
for (i in 2:15) wss[i] <- sum(kmeans(data, centers = i)$withinss)

# Graficando para encontrar el número óptimo de clusters (codo)
plot(1:15, wss, type = "b", xlab = "Número de clusters", ylab = "Suma de cuadrados dentro de los clusters")

# Mi numero optimo de clusters es 11

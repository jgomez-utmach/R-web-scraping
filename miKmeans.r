data <- res_limpio

quitar_col <- c(1, 6)
data <- data[, - quitar_col]

data <- scale(data)
wss <- (nrow(data) - 1) * sum(apply(data, 2, var))
for (i in 2:15) wss[i] <- sum(kmeans(data, centers = i)$withinss)
plot(1:15, wss, type = "b", xlab = "Número de clusters", ylab = "Suma de cuadrados dentro de los clusters")


# CREANDO CLUSTERS CON K-MEANS

# Creo 11 clusters con kmeans
mycluster <- kmeans(data, 11, nstart = 5, iter.max = 30)

#Importo librería para graficas de radar
library(fmsb)

# Indico que quiero ordenar las graficas en un grid de 4 filas y 3 columnas
par(mfrow=c(4,3))

# Graficando los clusters en una grafica de radar
dat <- as.data.frame(t(mycluster$centers[1, ]))
dat <- rbind(rep(5, 7), rep(-1.5, 7), dat)
radarchart(dat)

dat <- as.data.frame(t(mycluster$centers[2, ]))
dat <- rbind(rep(5, 7), rep(-1.5, 7), dat)
radarchart(dat)

dat <- as.data.frame(t(mycluster$centers[3, ]))
dat <- rbind(rep(5, 7), rep(-1.5, 7), dat)
radarchart(dat)

dat <- as.data.frame(t(mycluster$centers[4, ]))
dat <- rbind(rep(5, 7), rep(-1.5, 7), dat)
radarchart(dat)

dat <- as.data.frame(t(mycluster$centers[5, ]))
dat <- rbind(rep(5, 7), rep(-1.5, 7), dat)
radarchart(dat)

dat <- as.data.frame(t(mycluster$centers[6, ]))
dat <- rbind(rep(5, 7), rep(-1.5, 7), dat)
radarchart(dat)

dat <- as.data.frame(t(mycluster$centers[7, ]))
dat <- rbind(rep(5, 7), rep(-1.5, 7), dat)
radarchart(dat)

dat <- as.data.frame(t(mycluster$centers[8, ]))
dat <- rbind(rep(5, 7), rep(-1.5, 7), dat)
radarchart(dat)

dat <- as.data.frame(t(mycluster$centers[9, ]))
dat <- rbind(rep(5, 7), rep(-1.5, 7), dat)
radarchart(dat)

dat <- as.data.frame(t(mycluster$centers[10, ]))
dat <- rbind(rep(5, 7), rep(-1.5, 7), dat)
radarchart(dat)

dat <- as.data.frame(t(mycluster$centers[11, ]))
dat <- rbind(rep(5, 7), rep(-1.5, 7), dat)
radarchart(dat)

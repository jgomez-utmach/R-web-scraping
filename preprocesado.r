
aspiradoras <- read.csv("datos-1.csv")


aspiradoras$Peso <- gsub(" kg", "", aspiradoras$Peso)
aspiradoras$Peso <- gsub(",", ".", aspiradoras$Peso)
es_gramo <- grepl(" g", aspiradoras$Peso)
aspiradoras$Peso <- gsub(" g", "", aspiradoras$Peso)
aspiradoras$Peso <- gsub("-1", NA, aspiradoras$Peso)
aspiradoras$Peso <- as.numeric(aspiradoras$Peso)
aspiradoras$Peso[es_gramo] <- aspiradoras$Peso[es_gramo] / 1000
pesomedio <- mean(aspiradoras$Peso, na.rm = TRUE)
aspiradoras$Peso[is.na(aspiradoras$Peso)] <- pesomedio

aspiradoras_sin_X <- aspiradoras[, !(names(aspiradoras) %in% "X")]
filas_invalidas <- apply(aspiradoras_sin_X == -1 | is.na(aspiradoras_sin_X), 1, all)
aspiradoras <- aspiradoras[!filas_invalidas, ]

aspiradoras <- aspiradoras[!is.na(aspiradoras$Nombre), ]
n_filas <- nrow(aspiradoras)
aspiradoras$X <- c(1:n_filas)
rownames(aspiradoras) <- aspiradoras$X


# PREPROCESADO DE DIMENSIONES

# Limpiar datos de dimensiones
aspiradoras$Dimensiones <- gsub("-1", "-1 x -1 x -1", aspiradoras$Dimensiones)
aspiradoras$Dimensiones <- gsub(" pulgadas", "", aspiradoras$Dimensiones)
aspiradoras$Dimensiones <- gsub("\"l.", "", aspiradoras$Dimensiones)
aspiradoras$Dimensiones <- gsub("\"an.", "", aspiradoras$Dimensiones)
aspiradoras$Dimensiones <- gsub("\"al.", "", aspiradoras$Dimensiones)
aspiradoras$Dimensiones <- gsub(",", ".", aspiradoras$Dimensiones)

# Importar libreria para manipular strings
library(stringr)

# Separar las dimensiones en 3 columnas a partir del caracter x
dimen <-  str_split_fixed(aspiradoras$Dimensiones, "x", 3)

# Convertir dimen en un data.frame
dimen <- as.data.frame(dimen)

# Cambiar el nombre de las columnas
colnames(dimen) <- c("Largo", "Ancho", "Alto")

# Reemplazar los -1 por NA
dimen$Largo <- gsub("-1", NA, dimen$Largo)
dimen$Ancho <- gsub("-1", NA, dimen$Ancho)
dimen$Alto <- gsub("-1", NA, dimen$Alto)

# Convertir datos de dimen a numéricos
dimen$Largo <- as.numeric(dimen$Largo)
dimen$Ancho <- as.numeric(dimen$Ancho)
dimen$Alto <- as.numeric(dimen$Alto)

# Convertir todos los datos de dimen de pulgadas a centimetros
dimen$Largo <- as.numeric(dimen$Largo) * 2.54
dimen$Ancho <- as.numeric(dimen$Ancho) * 2.54
dimen$Alto <- as.numeric(dimen$Alto) * 2.54

# Reemplazar los NA por la media de cada columna
dimen$Largo[is.na(dimen$Largo)] <- mean(dimen$Largo, na.rm = TRUE)
dimen$Ancho[is.na(dimen$Ancho)] <- mean(dimen$Ancho, na.rm = TRUE)
dimen$Alto[is.na(dimen$Alto)] <- mean(dimen$Alto, na.rm = TRUE)

# cbind para unir columnas de dos data.frames
res_limpio <- cbind(aspiradoras, dimen)

# Quitamos la columna Dimensiones
res_limpio <- res_limpio[, -7]

View(res_limpio)


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


aspiradoras$Dimensiones <- gsub("-1", "-1 x -1 x -1", aspiradoras$Dimensiones)
aspiradoras$Dimensiones <- gsub(" pulgadas", "", aspiradoras$Dimensiones)
aspiradoras$Dimensiones <- gsub("\"l.", "", aspiradoras$Dimensiones)
aspiradoras$Dimensiones <- gsub("\"an.", "", aspiradoras$Dimensiones)
aspiradoras$Dimensiones <- gsub("\"al.", "", aspiradoras$Dimensiones)
aspiradoras$Dimensiones <- gsub(",", ".", aspiradoras$Dimensiones)

library(stringr)
dimen <-  str_split_fixed(aspiradoras$Dimensiones, "x", 3)
dimen <- as.data.frame(dimen)

colnames(dimen) <- c("Largo", "Ancho", "Alto")

dimen$Largo <- gsub("-1", NA, dimen$Largo)
dimen$Ancho <- gsub("-1", NA, dimen$Ancho)
dimen$Alto <- gsub("-1", NA, dimen$Alto)

dimen$Largo <- as.numeric(dimen$Largo)
dimen$Ancho <- as.numeric(dimen$Ancho)
dimen$Alto <- as.numeric(dimen$Alto)

dimen$Largo <- as.numeric(dimen$Largo) * 2.54
dimen$Ancho <- as.numeric(dimen$Ancho) * 2.54
dimen$Alto <- as.numeric(dimen$Alto) * 2.54

dimen$Largo[is.na(dimen$Largo)] <- mean(dimen$Largo, na.rm = TRUE)
dimen$Ancho[is.na(dimen$Ancho)] <- mean(dimen$Ancho, na.rm = TRUE)
dimen$Alto[is.na(dimen$Alto)] <- mean(dimen$Alto, na.rm = TRUE)

res_limpio <- cbind(aspiradoras, dimen)
res_limpio <- res_limpio[, -7]


# PREPROCESADO DE PRECIOS

# Eliminando "US$" de los precios
res_limpio$Precio <- gsub("US\\$", "", res_limpio$Precio)
# Convirtiendo a numérico el campo Precio
res_limpio$Precio <- as.numeric(res_limpio$Precio)

# Como mis datos tiene productos con precios invalidos, los eliminamos
res_limpio <- res_limpio[!is.na(res_limpio$Precio), ]

# Aprobechamos y eliminamos la columna X que no nos sirve
res_limpio <- res_limpio[, -1]

# Volvemos a enumerar correctamente las filas
n_filas <- nrow(res_limpio)
rownames(res_limpio) <- c(1:n_filas)

str(res_limpio)
View(res_limpio)

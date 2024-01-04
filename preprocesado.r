
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


# ELIMINANDO FILAS CON DATOS INVALIDOS

# Crear una copia de aspiradoras sin la columna X
aspiradoras_sin_X <- aspiradoras[, !(names(aspiradoras) %in% "X")]

# Identificar las filas donde todos los campos son NA o -1
# apply(X, MARGIN, FUN): Aplica una función a los márgenes de una matriz o un data frame
# X=matriz o data frame, MARGIN=1 para filas, 2 para columnas, FUN=función a aplicar
# all(): Determina si todos los valores lógicos de cada fila son TRUE
filas_invalidas <- apply(aspiradoras_sin_X == -1 | is.na(aspiradoras_sin_X), 1, all)

# Eliminar las filas invalidas
aspiradoras <- aspiradoras[!filas_invalidas, ]


# EN CASO DE TENER DATOS SIN NOMBRE

# Eliminar las filas con NA en la columna Nombre
aspiradoras <- aspiradoras[!is.na(aspiradoras$Nombre), ]

# Obtener la cantidad de filas
n_filas <- nrow(aspiradoras)

# Crear una columna X con los números de las filas
aspiradoras$X <- c(1:n_filas)

# Asignar los valores de la columna X como nombres de las filas
rownames(aspiradoras) <- aspiradoras$X

# Crear un histograma de los pesos
hist(aspiradoras$Peso, main = "Histograma de pesos", xlab = "Peso (kg)")

# Ver los datos
View(aspiradoras)
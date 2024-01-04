# Modificamos archivos CSV debido a que no se pudo obtener datos sobre el peso
# y añadimos los datos manualmente en datos-1.csv
# Esto es con el fin de ver como se hace un tratamiento de datos

# Leer un archivo CSV
aspiradoras <- read.csv("datos-1.csv")


# PROCESADO PARA EL PESO

# Remplazar "kg" por "" en la columna Peso
aspiradoras$Peso <- gsub(" kg", "", aspiradoras$Peso)
# Remplazar "," por "." en la columna Peso
aspiradoras$Peso <- gsub(",", ".", aspiradoras$Peso)

# Identificar las filas donde Peso está en gramos
es_gramo <- grepl(" g", aspiradoras$Peso)
# Remplazar " g" por "" en la columna Peso
aspiradoras$Peso <- gsub(" g", "", aspiradoras$Peso)

# Remplazar "-1" por NA en la columna Peso
aspiradoras$Peso <- gsub("-1", NA, aspiradoras$Peso)

# Convertir la columna Peso a numérico
aspiradoras$Peso <- as.numeric(aspiradoras$Peso)

# Convertir solo los valores en gramos a kilogramos
aspiradoras$Peso[es_gramo] <- aspiradoras$Peso[es_gramo] / 1000

# Calcular el peso medio de los productos con mean()
# na.rm = TRUE para que no tome en cuenta los NA
pesomedio <- mean(aspiradoras$Peso, na.rm = TRUE)

# Remplazar los NA por el peso medio
aspiradoras$Peso[is.na(aspiradoras$Peso)] <- pesomedio

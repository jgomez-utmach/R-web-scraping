# Generando un API con plumber
library(plumber)

# Archivo al que apunta la API
r <- plumb("miPlumber.R")

# Puerto en el que se ejecutará la API
r$run(port=8000)

# Ahora ejecutamos el API en la terminal
# [Powershell]: curl "http://localhost:8000/echo?msg=Hola Mundo"

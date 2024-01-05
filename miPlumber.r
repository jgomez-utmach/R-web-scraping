#* @param msg mensa
#* @get /echo
function(msg=""){
  # "#*" en plumber te permiten definir
  # cómo se accede a tus funciones R a través de HTTP.
  # En este caso, la función se accede a través de una solicitud
  # GET en la ruta /echo. que recibe un parámetro msg
  list(msg = paste0("The message is: '", msg, "'"))
}

# Es impotante pesionar Enter al final del codigo
# para no tener problemas con el servidor o plumber

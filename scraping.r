library(rvest)
library(stringr)

pag <- "https://www.amazon.com/-/es/s?k=aspiradora&page=2&crid=HU5HMDQLN0QT&qid=1704235659&sprefix=aspira%2Caps%2C357&ref=sr_pg_2"

lista_paginas <- c(1:10)

pag <- str_replace(pag, "page=2", paste0("page=", lista_paginas))
pag <- str_replace(pag, "sr_pg_2", paste0("sr_pg_", lista_paginas))


dameLinksPagina <- function(url){
  # Modifiqué selector para evitar las páginas con: /es/sspa/click?
  selector <- "div.s-desktop-width-max.s-desktop-content.s-wide-grid-style-t1.s-opposite-dir.s-wide-grid-style.sg-row > div.sg-col-20-of-24.s-matching-dir.sg-col-16-of-20.sg-col.sg-col-8-of-12.sg-col-12-of-16 > div > span.rush-component.s-latency-cf-section > div.s-main-slot.s-result-list.s-search-results.sg-row > div > div > div > span > div > div > div > div.puisg-col.puisg-col-4-of-12.puisg-col-8-of-16.puisg-col-12-of-20.puisg-col-12-of-24.puis-list-col-right > div > div > div.a-section.a-spacing-none.puis-padding-right-small.s-title-instructions-style > h2 > a"
  pagina <- read_html(url)
  nodo <- html_nodes(pagina, selector)
  nodo_links <- html_attr(nodo, "href")
  urlcompleta <- paste0("https://www.amazon.com", nodo_links)
}

linksAsp <- sapply(pag, dameLinksPagina)

vlink <- as.vector(linksAsp)


# No todos productos tendran los mismos atributos, por lo que se debe de hacer un tratamiento especial para cada uno de ellos

# funcion para el tratamiento de los datos
getArticulo <- function(url){
  pagina_web <- read_html(url)

  nombre <- "#productTitle"
  nombre_nodo <- html_node(pagina_web, nombre)
  nombre_texto <- html_text(nombre_nodo)

  calificacion <- "#acrPopover > span.a-declarative > a > span"
  calificacion_nodo <- html_node(pagina_web, calificacion)
  calificacion_texto <- html_text(calificacion_nodo)

  precio <- "#corePriceDisplay_desktop_feature_div > div.a-section.a-spacing-none.aok-align-center > span.a-price.aok-align-center.reinventPricePriceToPayMargin.priceToPay > span.a-offscreen"
  precio_nodo <- html_node(pagina_web, precio)
  precio_texto <- html_text(precio_nodo)

  tabla <- "#productDetails_detailBullets_sections1"
  tabla_nodo <- html_node(pagina_web, tabla)
  tabla_tab <- html_table(tabla_nodo)

  tabla_name <- tabla_tab$X1
  val <- tabla_tab$X2

  res_tabla <- data.frame(t(val))
  colnames(res_tabla) <- tabla_name
  
  col <- c("Peso del producto", "Potencia", "Dimensiones del producto", "País de origen")

  # Si la res_tabla está vacia todos los datos serán igual a -1
  if(length(res_tabla) == 0){
    # Creo dataframe con los valores -1
    val <- c("-1", "-1", "-1", "-1")
    mitab <- data.frame(t(val))
    colnames(mitab) <- col

  }else { # caso contrario se evalua cada uno de los atributos
    # Creo dataframe con los valores -1
    zero <- matrix("-1", nrow = 1, ncol = 4)
    dfzero <- data.frame(zero)
    colnames(dfzero) <- col

    # Se evalua cada uno de los atributos de res_tabla
    # Si no existe el atributo se asigna -1
    peso <- res_tabla$`Peso del producto`
    if(length(peso) == 0) peso <- "-1"
    potencia <- res_tabla$Potencia
    if(length(potencia) == 0) potencia <- "-1"
    dimensiones <- res_tabla$`Dimensiones del producto`
    if(length(dimensiones) == 0) dimensiones <- "-1"
    pais <- res_tabla$`País de origen`
    if(length(pais) == 0) pais <- "-1"

    # Se asigna los valores al dataframe
    dfzero$`Peso del producto` <- peso
    dfzero$Potencia <- potencia
    dfzero$`Dimensiones del producto` <- dimensiones
    dfzero$`País de origen` <- pais

    mitab <- dfzero
    colnames(mitab) <- col
  }
  # Se retorna un vector con los datos del articulo
  articulo <- c(nombre_texto, calificacion_texto, precio_texto, dfzero$`Peso del producto`, dfzero$Potencia, dfzero$`Dimensiones del producto`, dfzero$`País de origen`)
}

# Comprobamos la funcion
res <- getArticulo(vlink[87])
res

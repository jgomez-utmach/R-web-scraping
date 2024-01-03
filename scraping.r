library(rvest)

url <- "https://www.amazon.com/s?k=aspiradora&crid=HU5HMDQLN0QT&sprefix=aspira%2Caps%2C357&ref=nb_sb_ss_ts-doa-p_3_6"

selector <- "#search > div.s-desktop-width-max.s-desktop-content.s-wide-grid-style-t1.s-opposite-dir.s-wide-grid-style.sg-row > div.sg-col-20-of-24.s-matching-dir.sg-col-16-of-20.sg-col.sg-col-8-of-12.sg-col-12-of-16 > div > span.rush-component.s-latency-cf-section > div.s-main-slot.s-result-list.s-search-results.sg-row > div:nth-child(9) > div > div > span > div > div > div > div.puisg-col.puisg-col-4-of-12.puisg-col-8-of-16.puisg-col-12-of-20.puisg-col-12-of-24.puis-list-col-right > div > div > div.a-section.a-spacing-none.puis-padding-right-small.s-title-instructions-style > h2 > a"

pagina <- read_html(url)
nodo <- html_nodes(pagina, selector)
nodo_links <- html_attr(nodo, "href")
urlcompleta <- paste0("https://www.amazon.com", nodo_links)


library(stringr)

pag <- "https://www.amazon.com/-/es/s?k=aspiradora&page=2&crid=HU5HMDQLN0QT&qid=1704235659&sprefix=aspira%2Caps%2C357&ref=sr_pg_2"

lista_paginas <- c(1:10)

pag <- str_replace(pag, "page=2", paste0("page=", lista_paginas))
pag <- str_replace(pag, "sr_pg_2", paste0("sr_pg_", lista_paginas))


# Creamos una funcion que extrae los links de una pagina
dameLinksPagina <- function(url){
  selector <- "div > div > span > div > div > div > div.puisg-col.puisg-col-4-of-12.puisg-col-8-of-16.puisg-col-12-of-20.puisg-col-12-of-24.puis-list-col-right > div > div > div.a-section.a-spacing-none.puis-padding-right-small.s-title-instructions-style > h2 > a"
  pagina <- read_html(url)
  nodo <- html_nodes(pagina, selector)
  nodo_links <- html_attr(nodo, "href")
  urlcompleta <- paste0("https://www.amazon.com", nodo_links)
  urlcompleta
}

# Testeamos la funcion
test <- dameLinksPagina(pag[1])

# sapply aplica una funcion (dameLinksPagina) a cada elemento de un vector (pag)
linksAsp <- sapply(pag, dameLinksPagina)

# NOTA: sapply devuelve una matriz, en mi caso de 22 filas y 10 columnas
dim(linksAsp)

# Por comodidad lo convertimos en un vector
vlink <- as.vector(linksAsp)

# Vemos cuantos elementos tiene el vector
length(vlink)

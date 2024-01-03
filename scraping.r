library(rvest)
# URL de la página con la lista de productos
url <- "https://www.amazon.com/s?k=aspiradora&crid=HU5HMDQLN0QT&sprefix=aspira%2Caps%2C357&ref=nb_sb_ss_ts-doa-p_3_6"
# Selector de un producto en la lista
selector <- "#search > div.s-desktop-width-max.s-desktop-content.s-wide-grid-style-t1.s-opposite-dir.s-wide-grid-style.sg-row > div.sg-col-20-of-24.s-matching-dir.sg-col-16-of-20.sg-col.sg-col-8-of-12.sg-col-12-of-16 > div > span.rush-component.s-latency-cf-section > div.s-main-slot.s-result-list.s-search-results.sg-row > div:nth-child(9) > div > div > span > div > div > div > div.puisg-col.puisg-col-4-of-12.puisg-col-8-of-16.puisg-col-12-of-20.puisg-col-12-of-24.puis-list-col-right > div > div > div.a-section.a-spacing-none.puis-padding-right-small.s-title-instructions-style > h2 > a"

# Leemos la página
pagina <- read_html(url)
# Extraemos el nodo que coincide con el selector
nodo <- html_nodes(pagina, selector)
# Extraemos el link del nodo
nodo_links <- html_attr(nodo, "href")
# Unimos el dominio con el link
# paste0: Une Strings sin espacios
urlcompleta <- paste0("https://www.amazon.com", nodo_links)
urlcompleta

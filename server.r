function(input, output, session) {
  # Creamos variable data que lee el archivo de datos
  data <- read.csv("C:\\Users\\Utente\\proyectos\\R-web-scraping\\data-limpia.csv")
  # Eliminamos la primera columna X por que solo es un indice
  # solo en caso de existir
  # data <- data[, -1]

  selectedData <- reactive({
    # Cambio los datos de iris por los datos de aspiradoras (data)
    data[, c(input$xcol, input$ycol)]
  })

  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })

  output$plot1 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
      "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })

}

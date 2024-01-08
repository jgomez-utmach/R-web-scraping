# k-means only works with numerical variables,
# so don't give the user the option to select
# a categorical variable

# Cambio iris por mis datos (data) e indico columna a eliminar
# en mi caso dejo "" por que no tengo columna a eliminar
vars <- setdiff(names(data), "")

pageWithSidebar(
  headerPanel('Aspiradoras Amazon clustering'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', vars),
    selectInput('ycol', 'Y Variable', vars, selected = vars[[2]]),
    numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
  ),
  mainPanel(
    plotOutput('plot1')
  )
)

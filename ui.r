library(shinydashboard)
library(leaflet)


header <- dashboardHeader(
  title = "Omnicare Inc."
)

body <- dashboardBody(
  fluidRow(
    column(width = 9,
      box(width = NULL, solidHeader = TRUE,
        leafletOutput('myMap', height = 500)
      ),
  
      # Create a new row for the table.
      fluidRow(
        dataTableOutput(outputId="table")
      )    
    )  
  )
)
  



dashboardPage(
  header,
  dashboardSidebar(disable = TRUE),
  body
)

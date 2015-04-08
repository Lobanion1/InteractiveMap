library(shinydashboard)
library(leaflet)


header <- dashboardHeader(
  title = "Omnicare Inc."
)
shinyUI(navbarPage("Omnicare Inc. Supply Chain",
tabPanel("Interactive Map",
body <- dashboardBody(
  fluidRow(
    column(width = 9,
      box(width = NULL, solidHeader = TRUE,
        leafletOutput('myMap', height = 400)
      ),
  
      # Create a new row for the table.
      fluidRow(
        dataTableOutput(outputId="table")
        )    
          )  
            )
              )
                 ),
tabPanel("Data Management",
         titlePanel("Uploading Files"),
         sidebarLayout(
           sidebarPanel(
             fileInput('file1', 'Choose CSV File',
                       accept=c('text/csv', 
                                'text/comma-separated-values,text/plain', 
                                '.csv')),
             tags$hr(),
             checkboxInput('header', 'Header', TRUE),
             radioButtons('sep', 'Separator',
                          c(Comma=',',
                            Semicolon=';',
                            Tab='\t'),
                          ','),
             radioButtons('quote', 'Quote',
                          c(None='',
                            'Double Quote'='"',
                            'Single Quote'="'"),
                          '"')
           ),
           mainPanel(
             tableOutput('contents')
           )
         )
)
)
)
dashboardPage(
  header,
  dashboardSidebar(disable = TRUE),
  body
)

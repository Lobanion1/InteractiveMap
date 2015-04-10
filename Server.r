library(shinydashboard)
library(leaflet)
library(dplyr)
library(xlsx)
library(shiny)

#East Coast:  Colorpallet <- c("CHVALUE.CT"="#595490","CHESTNU.NY"="#548b90","LONDOND.NH"="#905954","POMPTON.NJ"="#8b9054","EASTGRE.RI"="#6d9054","MARLBOR.MA"="#549059","ROCHEST.NY"="#905954","MIDDLET.NY"="#90548b")
#Cincinnati:  Colorpallet <- c("3"="#595490","6"="#548b90","1"="#905954","8"="#8b9054","7"="#6d9054")
Colorpallet <- c("3"="#595490","6"="#548b90","1"="#905954","8"="#8b9054","7"="#6d9054")

FACILITY_CHAIN <- read.csv("./Files/FACILITY_CHAINCINGEO.csv",header = TRUE)
##Subset the import to only show wanted columns
FACILITY_CHAIN_TABLE <- FACILITY_CHAIN[ ,c("FACILITY_ID","FACILITY_NAME","ADDR1","CITY","STATE","TOTAL_BEDS","FACILITY_TYPE_GROUP")]

##Layered map with Map tile and circle based on route
function(input, output) {
  
  #Function to create color option
  #East Coast: dirPal<- colorFactor(Colorpallet,FACILITY_CHAIN$PHARMACY_ID)
  #Cincinnati: dirPal<- colorFactor(Colorpallet,FACILITY_CHAIN$COMPANY_ID_PRIMARY)
  dirPal<- colorFactor(Colorpallet,FACILITY_CHAIN$COMPANY_ID_PRIMARY)
  
  output$contents <- renderTable({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)
#    FACILITY_CHAIN <- inFile
    })
  
  map = leaflet() %>% 
    addTiles('http://{s}.tile.stamen.com/toner-lite/{z}/{x}/{y}.png')%>% 
    addCircleMarkers(
      FACILITY_CHAIN$lon,
      FACILITY_CHAIN$lat,
      #East Coast:  color = dirPal(FACILITY_CHAIN$PHARMACY_ID),
      #Cincinnati:  color = dirPal(FACILITY_CHAIN$COMPANY_ID_PRIMARY),
      color = dirPal(FACILITY_CHAIN$COMPANY_ID_PRIMARY),
      radius = 4,
   
##Popup information must be in a string format.     
      popup= FACILITY_CHAIN$FACILITY_NAME)
      output$myMap = renderLeaflet(map)



output$table <- renderDataTable({
 FACILITY_CHAIN_TABLE
})

}


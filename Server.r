library(shinydashboard)
library(leaflet)
library(dplyr)
library(xlsx)
library(shiny)

Colorpallet <- c("1"="#595490","3"="#527525","6"="#A93F35","7"="#BA48AA","8"="Blue")

FACILITY_CHAIN <- read.csv("L:/Cincinnati Routing Study/FACILITY_CHAINCINGEO.csv",header = TRUE)
##Subset the import to only show wanted columns
FACILITY_CHAIN_TABLE <- FACILITY_CHAIN[ ,c("FACILITY_ID","FACILITY_NAME","ADDR1","CITY","STATE","TOTAL_BEDS","FACILITY_TYPE_GROUP")]

##Layered map with Map tile and circle based on route
function(input, output) {
  dirPal<- colorFactor(Colorpallet,FACILITY_CHAIN$COMPANY_ID_PRIMARY)
  
  
  map = leaflet() %>% 
    addTiles('http://{s}.tile.stamen.com/toner-lite/{z}/{x}/{y}.png')%>% 
    addCircleMarkers(
      FACILITY_CHAIN$lon,
      FACILITY_CHAIN$lat,
      color = dirPal(FACILITY_CHAIN$COMPANY_ID_PRIMARY),
      radius = 4,
   
##Popup information must be in a string format!!      
      popup= FACILITY_CHAIN$FACILITY_NAME)
      output$myMap = renderLeaflet(map)



output$table <- renderDataTable({
 FACILITY_CHAIN_TABLE
})

}


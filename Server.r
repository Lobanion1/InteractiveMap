library(shinydashboard)
library(leaflet)
library(dplyr)
library(xlsx)
library(shiny)


FACILITY_CHAIN <- read.xlsx("C:/Users/lobanion/Desktop/Minnesota Study/FACILITY_CHAINmnopt.xlsx",1)
##Subset the import to only show wanted columns
FACILITY_CHAIN_TABLE <- FACILITY_CHAIN[ ,c("FACILITY_ID","FACILITY_NAME","ADDR1","CITY","STATE","TOTAL_BEDS","FACILITY_TYPE_GROUP")]

##Layered map with Map tile and circle based on route
function(input, output) {
  map = leaflet() %>% 
    addTiles('http://{s}.tile.thunderforest.com/transport/{z}/{x}/{y}.png')%>% 
    addCircleMarkers(
      FACILITY_CHAIN$lon,
      FACILITY_CHAIN$lat,
      color = "red",
      radius = 4,
   
##Popup information must be in a string format!!      
      popup= FACILITY_CHAIN$FACILITY_NAME)
      output$myMap = renderLeaflet(map)



output$table <- renderDataTable({
 FACILITY_CHAIN_TABLE
})

}


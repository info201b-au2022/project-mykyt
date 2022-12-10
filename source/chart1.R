library("tidyverse")
library("leaflet")
library("sf")

## Chart 1  ---- 
#----------------------------------------------------------------------------#
# Number of Homeless People by State (Updated using leaflet)
#----------------------------------------------------------------------------#
plot_map <- function(df) {
states <- read_sf("./cb_2018_us_state_500k/cb_2018_us_state_500k.shp")
states <- subset(states, is.element(states$NAME, df$State))
df<- df[order(match(df$State, states$NAME)), ]

labels <- paste("<p>", "<strong>", df$State,"</strong>", "</p>",
                "<p>", "Total homeless count: ", "<strong>", df$Overall.Homeless..2020,"</strong>", "</p>",
                "<p>", "Total homeless as %: ", "<strong>", df$`Total Homeless as %`,"%", "</strong>", "</p>",
                "<p>", "Increase / decrease in 14 years: ", "<strong>", df$`Increase / Decrease from 2007`,"</strong>", "</p>") %>% 
  lapply(htmltools::HTML)

m <- leaflet(states) %>%
  setView(-96, 37.8, 4) %>%
  addProviderTiles(providers$Stamen.Toner)
  

bins <- c(500,2000, 3000,4000,5000, 9000, 15000, 20000, 30000, 95000, 165000)
pal <- colorBin("YlGnBu", domain = df$Overall.Homeless..2020, bins = bins)

m %>% addPolygons(
  fillColor = ~pal(df$Overall.Homeless..2020),
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7,
  highlightOptions = highlightOptions(
    weight = 3,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE),
    label = labels,
    labelOptions = labelOptions(
    style = list(padding = "4px"),
    textsize = "12px",
    direction = "auto"),
  ) %>%
  addLegend(pal = pal, values = df$Overall.Homeless..2020, opacity = 0.7, title = NULL,
            position = "bottomright")
}

plot_map(homeless_map)

library("tidyverse")
library("plotly")


## Chart 3  ---- 
#----------------------------------------------------------------------------#
# Number of Homeless People by State
#----------------------------------------------------------------------------#


plot_homelessness_data <- function(df, input_type, year) {
  dummy <- "Sheltered and unsheltered homeless"
  
  total_data <- df %>%
    filter(type == input_type | input_type == dummy) %>%
    filter(Year >= min(year) &  Year <= max(year))
  
  homelessness_data_chart <- ggplot(total_data) +
    geom_area(mapping = aes(x = Year, y= total, fill = type)) +
    scale_y_continuous(labels = scales::comma) +
    scale_fill_brewer(palette = "Blues") + 
    labs (
      title = "Total Number Of Homeless People, United States, from 2007 to 2016",
      x = "Year", 
      y = "Total",
      caption = "This graph shows people experiencing homelessness in the USA, by shelter status.
                 Also it indicates the total amount of homeless people from 2007-2016",
      fill = ""
    ) + 
    theme_dark()
  
  ggplotly(homelessness_data_chart)
}




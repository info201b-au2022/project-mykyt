library("tidyverse")

source("../source/data_access.R")

#----------------------------------------------------------------------------#
# Loaded data
#----------------------------------------------------------------------------#
homelessness_data <-  get_data_homelessness_2007_2016()

## Chart 3  ---- 
#----------------------------------------------------------------------------#
# Number of Homeless People by State
#----------------------------------------------------------------------------#

homelessness_data_filtered  <- homelessness_data %>%
  select(Year, Sheltered.Homeless..HUD..2016.., Unsheltered.Homeless..HUD..2016..) %>%
  rename("Sheltered homeless" = Sheltered.Homeless..HUD..2016.., "Unsheltered homeless" = Unsheltered.Homeless..HUD..2016..) %>%
  rowwise() %>% 
  ungroup() %>%
  pivot_longer(!Year)

plot_homelessness_data <- function() {
  homelessness_data_chart <- ggplot(homelessness_data_filtered) +
    geom_area(mapping = aes(x = Year, y=value, fill = name)) +
    scale_y_continuous(labels = scales::comma) +
    scale_fill_brewer() + 
    labs (
      title = "Total Number Of Homeless People,
United States, from 2007 to 2016",
      x = "Year", 
      y = "Total",
      caption = "This graph shows people experiencing homelessness in the USA, by shelter status.
                 Also it indicates the total amount of homeless people from 2007-2016",
      fill = ""
    ) + 
    theme_dark()
  
  return(homelessness_data_chart) 
}




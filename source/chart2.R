library("tidyverse")
library("plotly")


## Chart 2 ---- 
#----------------------------------------------------------------------------#
# Racial Inequalities in Homelessness, by the Numbers
#----------------------------------------------------------------------------#

plot_homelessness_2020_total <- function(df, state) {
  total_data <- df %>%
    select(State, Overall.Homeless...Hispanic.Latino..2020, Overall.Homeless...White..2020, Overall.Homeless...Black.or.African.American..2020, Overall.Homeless...Asian..2020, Overall.Homeless...American.Indian.or.Alaska.Native..2020, Overall.Homeless...Native.Hawaiian.or.Other.Pacific.Islander..2020) %>%
    filter(State == state) %>%
    rename(Latino = Overall.Homeless...Hispanic.Latino..2020, White = Overall.Homeless...White..2020, Black = Overall.Homeless...Black.or.African.American..2020, Asian = Overall.Homeless...Asian..2020, "Native American" = Overall.Homeless...American.Indian.or.Alaska.Native..2020, "Pacific Islander" = Overall.Homeless...Native.Hawaiian.or.Other.Pacific.Islander..2020) %>%
    gather(key = race, value = total, -State) %>%
    select(race, total) %>%
    mutate(total = as.integer(gsub(",", "", total))) %>%
    arrange(-total)
  
  homelessness_2020_total_chart <- ggplot(total_data) +
    
    geom_bar(mapping = aes(y = reorder(race, total), x=total), stat="identity", fill="#7393B3") +
    scale_x_continuous(labels = scales::comma) +
    labs (
      title = paste0("Race Disparity Among Homeless In ", state, " (2020)"),
      x = "Number of homeless by race", 
      y = "",
    ) 
  
  ggplotly(homelessness_2020_total_chart,tooltip="x")
}




library("tidyverse")

source("../source/data_access.R")

#----------------------------------------------------------------------------#
# Loaded data
#----------------------------------------------------------------------------#
homelessness_2020 <-  get_data_homelessness_2020()

## Chart 2 ---- 
#----------------------------------------------------------------------------#
# Racial Inequalities in Homelessness, by the Numbers
#----------------------------------------------------------------------------#
homelessness_2020_total <- homelessness_2020 %>%
  select(State, Overall.Homeless...Hispanic.Latino..2020, Overall.Homeless...White..2020, Overall.Homeless...Black.or.African.American..2020, Overall.Homeless...Asian..2020, Overall.Homeless...American.Indian.or.Alaska.Native..2020, Overall.Homeless...Native.Hawaiian.or.Other.Pacific.Islander..2020) %>%
  filter(State == "Total") %>%
  rename(Latino = Overall.Homeless...Hispanic.Latino..2020, White = Overall.Homeless...White..2020, Black = Overall.Homeless...Black.or.African.American..2020, Asian = Overall.Homeless...Asian..2020, "Native American" = Overall.Homeless...American.Indian.or.Alaska.Native..2020, "Pacific Islander" = Overall.Homeless...Native.Hawaiian.or.Other.Pacific.Islander..2020) %>%
  gather(key = race, value = total, -State) %>%
  select(race, total) %>%
  mutate(total = as.integer(gsub(",", "", total))) %>%
  arrange(-total)

plot_homelessness_2020_total <- function() {
  homelessness_2020_total_chart <- ggplot(homelessness_2020_total) +
    geom_bar(mapping = aes(y = reorder(race, total), x=total), stat="identity", fill="#7393B3") +
    scale_x_continuous(labels = scales::comma) +
    labs (
      title = "Race Disparity Among Homeless In U.S.(2020)",
      x = "total number of homeless", 
      y = "Race",
    )
  
  return(homelessness_2020_total_chart) 
}




library("tidyverse")

source("../source/data_access.R")

#----------------------------------------------------------------------------#
# Loaded data
#----------------------------------------------------------------------------#
homelessness_2020 <-  get_data_homelessness_2020()

## Chart 1  ---- 
#----------------------------------------------------------------------------#
# Number of Homeless People by State
#----------------------------------------------------------------------------#

homelessness_2020_filtered <- homelessness_2020 %>%
  select(State, Overall.Homeless..2020) %>%
  filter(State %in% state.abb) %>%
  rename("state" = "State") %>%
  mutate(Overall.Homeless..2020 = as.integer(gsub(",", "", Overall.Homeless..2020))) %>%
  rowwise() %>%
  mutate(state = as.character(list(tolower(state.name[grep(state, state.abb)])))) 

state_shape <- map_data("state") %>% 
  rename(state = region) %>% 
  select(-subregion) %>%
  left_join(homelessness_2020_filtered, by="state") 

plot_homelessness_2020 <- function() {
  homelessness_2020_map_chart <- ggplot(state_shape) +
    geom_polygon(
      mapping = aes(x = long, y = lat, group = group, fill = Overall.Homeless..2020),
    ) +
    coord_map() +
    borders("state", colour = "#FFFFFF", size = 0.1) +
    scale_fill_continuous(low = "#B9D9EB", high = "#0047AB") +
    labs(
      title = "Homeless Population by State(2020)",
      fill = "Total homeless count"
    ) + 
    theme_dark()
  return (homelessness_2020_map_chart)
}


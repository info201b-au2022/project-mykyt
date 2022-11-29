library("tidyverse")

source("../source/data_access.R")

#----------------------------------------------------------------------------#
# Loaded data
#----------------------------------------------------------------------------#
homelessness_2020 <-  get_data_homelessness_2020()
homelessness_2007 <- get_data_homelessness_2007()

## Table ---- 
#----------------------------------------------------------------------------#
overall_homeless <- homelessness_2020 %>%
  select(State, Overall.Homeless..2020) %>%
  filter(State == "Total") %>%
  mutate(Overall.Homeless..2020 = as.integer(gsub(",", "", Overall.Homeless..2020))) %>%
  pull(Overall.Homeless..2020)

homelessness_2007 <- homelessness_2007 %>%
  select(State, Overall.Homeless..2007) %>%
  filter(State != "Total") %>%
  mutate(Overall.Homeless..2007 = as.integer(gsub(",", "", Overall.Homeless..2007))) %>%
  drop_na()

get_table <- function() {
  table <- homelessness_2020 %>%
  select(State, Overall.Homeless..2020) %>%
  mutate(Overall.Homeless..2020 = as.integer(gsub(",", "", Overall.Homeless..2020))) %>%
  drop_na() %>%
  mutate("Total Homeless as %" = round(Overall.Homeless..2020 / overall_homeless * 100, 2)) %>%
  filter(State != "Total") %>%
  arrange(-Overall.Homeless..2020) %>%
  left_join(homelessness_2007, by="State") %>%
  mutate(Overall.Homeless..2007 = Overall.Homeless..2020 - Overall.Homeless..2007) %>%
  rename("Total Homeless" = Overall.Homeless..2020, "Increase / Decrease from 2007" = Overall.Homeless..2007) 
  return(table)
}

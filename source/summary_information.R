library("tidyverse")

source("../source/data_access.R")

#----------------------------------------------------------------------------#
# Loaded data
#----------------------------------------------------------------------------#
homelessness_2020 <-  get_data_homelessness_2020()

#----------------------------------------------------------------------------#
# Summary function
#----------------------------------------------------------------------------#
get_summary_info <- function(data_2007, data_2020) {
  info_list <- list()
  info_list$total_homeless_2020 <- data_2020 %>%
    select(State, Overall.Homeless..2020) %>%
    filter(State == "Total") %>%
    mutate(Overall.Homeless..2020 = as.integer(gsub(",", "", Overall.Homeless..2020))) %>%
    pull(Overall.Homeless..2020)
  info_list$total_homeless_2007 <- data_2007 %>%
    filter(Year == 2007) %>%
    mutate(total = Sheltered.Homeless..HUD..2016.. + Unsheltered.Homeless..HUD..2016..) %>%
    pull(total)
  info_list$most_state_overall <- data_2020 %>%
    select(State, Overall.Homeless..2020) %>%
    mutate(Overall.Homeless..2020 = as.integer(gsub(",", "", Overall.Homeless..2020))) %>%
    drop_na() %>%
    filter(State != "Total") %>%
    filter(Overall.Homeless..2020 == max(Overall.Homeless..2020)) %>%
    pull(State)
  info_list$most_state_overall_percentage <- data_2020 %>%
    select(State, Overall.Homeless..2020) %>%
    filter(State == info_list$most_state_overall | State == "Total") %>%
    mutate(Overall.Homeless..2020 = as.integer(gsub(",", "", Overall.Homeless..2020))) %>%
    mutate(percantage = min(Overall.Homeless..2020)/max(Overall.Homeless..2020)*100) %>%
    slice(1) %>%
    pull(percantage)
  return (info_list)
}
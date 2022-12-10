library("tidyverse")

# Example: Project Data Access Functions  ----
#----------------------------------------------------------------------------#
# These functions are used to access data sources ... 
#----------------------------------------------------------------------------#
get_data_homelessness_2020 <- function(num_records=-1) {
  fname <- "./data/2020-PIT-Counts-by-State.csv"
  df <- read.csv(fname, nrows=num_records)
  return(df)
}

get_data_homelessness_2007_2016 <- function(num_records=-1) {
  fname <- "./data/number-of-homeless-people-by-shelter-status.csv"
  df <- read.csv(fname, nrows=num_records)
  return(df)
}


get_data_homelessness_2007 <- function(num_records=-1) {
  fname <- "./data/2007-PIT-Counts-by-State.csv"
  df <- read.csv(fname, nrows=num_records)
  return(df)
}

states <- get_data_homelessness_2020() %>%
  select(State)

homelessness_data_2007_2016_filtered  <- get_data_homelessness_2007_2016() %>%
  select(Year, Sheltered.Homeless..HUD..2016.., Unsheltered.Homeless..HUD..2016..) %>%
  rename("Sheltered homeless" = Sheltered.Homeless..HUD..2016.., "Unsheltered homeless" = Unsheltered.Homeless..HUD..2016..) %>%
  rowwise() %>% 
  ungroup() %>%
  pivot_longer(!Year) %>%
  rename(total = value, type = name) 

overall_homeless <- get_data_homelessness_2020() %>%
  select(State, Overall.Homeless..2020) %>%
  filter(State == "Total") %>%
  mutate(Overall.Homeless..2020 = as.integer(gsub(",", "", Overall.Homeless..2020))) %>%
  pull(Overall.Homeless..2020)

homelessness_2007 <- get_data_homelessness_2007() %>%
  select(State, Overall.Homeless..2007) %>%
  filter(State != "Total") %>%
  mutate(Overall.Homeless..2007 = as.integer(gsub(",", "", Overall.Homeless..2007))) %>%
  drop_na()


homelessness_2020 <- get_data_homelessness_2020()

homeless_map <- homelessness_2020 %>%
    select(State, Overall.Homeless..2020) %>%
    left_join(homelessness_2007, by="State") %>%
    filter(State %in% state.abb) %>%
    mutate(Overall.Homeless..2020 = as.integer(gsub(",", "", Overall.Homeless..2020))) %>%
    drop_na() %>%
    rowwise() %>%
    mutate(State = as.character(list(str_to_title(state.name[grep(State, state.abb)]))))  %>%
    ungroup() %>%
    mutate("Total Homeless as %" = round(Overall.Homeless..2020 / overall_homeless * 100, 2)) %>%
    mutate(Overall.Homeless..2007 = Overall.Homeless..2020 - Overall.Homeless..2007) %>%
    rename("Increase / Decrease from 2007" = Overall.Homeless..2007) 


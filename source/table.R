library("tidyverse")

get_table <- function(homelessness_2020, homelessness_2007, overall_homeless) {
  table <- homelessness_2020 %>%
  select(State, Overall.Homeless..2020) %>%
  mutate(Overall.Homeless..2020 = as.integer(gsub(",", "", Overall.Homeless..2020))) %>%
  drop_na() %>%
  mutate("Total Homeless as %" = round(Overall.Homeless..2020 / overall_homeless * 100, 2)) %>%
  filter(State != "Total") %>%
  arrange(-Overall.Homeless..2020) %>%
  left_join(homelessness_2007, by="State") %>%
  mutate(Overall.Homeless..2007 = Overall.Homeless..2020 - Overall.Homeless..2007) %>%
  rename("total_homeless" = Overall.Homeless..2020, "Increase / Decrease from 2007" = Overall.Homeless..2007) 
  return(table)
}

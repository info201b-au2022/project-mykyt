# Example: Project Data Access Functions  ----
#----------------------------------------------------------------------------#
# These functions are used to access data sources ... 
#----------------------------------------------------------------------------#
get_data_homelessness_2020 <- function(num_records=-1) {
  fname <- "~/Documents/Info201/project/project-mykyt/data/2020-PIT-Counts-by-State.csv"
  df <- read.csv(fname, nrows=num_records)
  return(df)
}

get_data_homelessness_2007_2016 <- function(num_records=-1) {
  fname <- "~/Documents/Info201/project/project-mykyt/data/number-of-homeless-people-by-shelter-status.csv"
  df <- read.csv(fname, nrows=num_records)
  return(df)
}

get_data_homelessness_2007 <- function(num_records=-1) {
  fname <- "~/Documents/Info201/project/project-mykyt/data/2007-PIT-Counts-by-State.csv"
  df <- read.csv(fname, nrows=num_records)
  return(df)
}


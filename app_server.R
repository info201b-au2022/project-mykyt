library("shiny")
library("plotly")
library("tidyverse")
library("knitr")

source("./source/data_access.R")
source("./source/chart2.R")
source("./source/chart3.R")
source("./source/chart1.R")

# Define server logic ----
server <- function(input, output) {
  output$mymap <- renderLeaflet(plot_map(homeless_map))
  output$chart2 <- renderPlotly(plot_homelessness_2020_total(get_data_homelessness_2020(),input$state))
  output$chart3 <- renderPlotly(plot_homelessness_data(homelessness_data_2007_2016_filtered, input$total,  input$total_slider))
  output$summary_table <- renderDataTable(get_table(homelessness_2020, homelessness_2007, overall_homeless))
  output$markdown <- renderUI({
    HTML(markdown::markdownToHTML(knit('./docs/p01-proposal.md', quiet = TRUE)))
  })
}

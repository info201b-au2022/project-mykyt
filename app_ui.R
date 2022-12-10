library("shiny")
library("shinythemes")
library("plotly")
library("tidyverse")
library("leaflet")
library("sf")


source("./source/data_access.R")

ui <- fluidPage(theme = shinytheme("cerulean"),
                includeCSS("./css/style.css"),
                h1("The Homelessness Crisis In U.S.", class = "main_title"),
                navbarPage("",
                           tabPanel("Intro",
                                    div(class="intro_main_panel",
                                        h2("Introduction", class="h2_title intro_title"),
                                        img(src = " https://static.boredpanda.com/blog/wp-content/uploads/2015/12/homeless-people-stories-mikael-theimer-montreal-fb.png",
                                            class = "intro_img intro_img1", align="right"),
                                        p("The issue of homelessness in America has been around since the 1930s, leaving millions of people without homes and jobs during The Great Depression. Nowadays, across the country, men, women and children spend their nights on the streets, not knowing when or if they will ever find a permanent home. States, federal officials and city councils have tried to alleviate or at least reduce the number of homeless over the last several decades. However, it continues to be an ongoing problem exacerbated by the recent pandemic and the housing crisis."),
                                        br(),
                                        p("Homelessness is a complex social problem that affects individuals, communities, and societies in more ways than one, whether we experience it or not. People going through homelessness live on the shadowy edges of society. This condition puts people at higher risks for victimization, poor health, loneliness, and depression, leading to chemical dependency, crime, and other issues which directly impact our communities. This safety uncertainty also directly affects the economy, costing the government millions of taxpayer dollars to deal with the issue that does not seem to be the solution."),
                                        img(src = " https://miro.medium.com/max/1200/0*tPzvxKgFXzy9VX_J",
                                            class = "intro_img intro_img2", align="left"),
                                        br(),
                                        p("The US Department of Housing and Urban Development provides several datasets that contain homeless rate data from 2007 to 2021. It will be analyzed in order to address the homelessness problem by bringing attention to it. The goal is to raise awareness and educate the public about it, which could potentially help with future actions to reduce the number and the impact of homelessness across the U.S."),
                                        h3("Research Questions", class = "intro_question_title") ,
                                        tags$ul(
                                          tags$li(" What states are most and least affected by homelessness? What is the total amount of homeless people across the U.S. ?"),
                                          tags$li(" What is the race disparity among the homeless ?"),
                                          tags$li(" How the problem got worse overtime, or did it get better in the timespan of 14 years ?"),
                                        )
                                      ),
                           ),
                           tabPanel("Map", 
                                    h2("Homeless Population by State 2020", class="h2_title"),
                                    sidebarLayout(
                                      sidebarPanel(
                                        p("Homelessness is a complex issue, and no single piece of data can effectively tell the entire story of homelessness and the greater need for housing in the United States. By using correct data, people and communities can engage in a collaborative decision-making process while addressing more comprehensive needs, gaps in funding, and existing resources."),
                                        p("The graph addresses the issue by visualizing the total count of homeless people by the state in the United States.")
                                      ),
                                      mainPanel(
                                        leafletOutput("mymap"),
                                      )
                                    ),
                           ),
                           tabPanel("Race Disparity", 
                                    h2("Race Disparity Among Homeless By State", class="h2_title"),
                                    sidebarLayout(
                                      sidebarPanel(
                                        p("Race is a significant predictor of homelessness. As with so many other areas of American life, historically marginalized groups are more likely to be disadvantaged in housing and homelessness. Higher unemployment rates, lower incomes, less access to healthcare, and higher incarceration rates are likely contributing to higher rates of homelessness among people of color."),
                                        selectizeInput(inputId = "state", label = "States",
                                                                  choices = states, multiple = FALSE, 
                                                                  options = list(placeholder = "Select State or Type to Search", onInitialize = I('function() { this.setValue("Total"); }'))),
                                      ),
                                      mainPanel(
                                        plotlyOutput("chart2", height = "90%", width = "100%"),
                                        br(),
                                        p("The chart above indicates that numerically white people are the largest racial group within homelessness, accounting for more than a quarter-million people. However, exploring the chart shows how different the race disparity is in each state. For instance, in Arkansas, the dominant homeless race is Native Americans, but in New York, most homeless are Black people, followed by Latinos. Historically marginalized racial and ethnic groups are often far more likely to experience homelessness. The reasons for the disparities are many and varied but tend to fall under the umbrella of racism and caste.")
                                    )
                           ),
                ),
                tabPanel("Total Number of Homeless", 
                         h2("Total Number Of Homeless People", class="h2_title"),
                         sidebarLayout(
                           sidebarPanel(
                             selectizeInput(inputId = "total", label = "Homeless Type",
                                            choices = list("Sheltered and unsheltered homeless", "Sheltered homeless", "Unsheltered homeless"), multiple = FALSE, 
                                            options = list(placeholder = "Select Type or Type to Search")),
                             sliderInput("total_slider", label = "Year", min = 2007, 
                                         max = 2016, value = c(2007, 2016), sep = "", step = 1, dragRange = FALSE),
                             
                           ),
                           
                           mainPanel(
                             plotlyOutput("chart3", height = "90%", width = "100%"),
                             br(),
                             p("One of the most common ways to measure homelessness is by counting people sleeping in shelters or on the streets. The graph represents figures intended to reflect the number of people who are homeless ’on any given night."),
                             p("In these figures, ‘Sheltered Homelessness’ refers to people who are staying in emergency shelters, transitional housing programs, or safe havens. ‘Unsheltered Homelessness,’ on the other hand, refers to people whose primary nighttime residence is a public or private place not designated for, or ordinarily used as, regular sleeping accommodation for people – for example, the streets, vehicles, or parks.")
                           )
                         ),
                ),
                tabPanel("Summary", 
                         div(class="intro_main_panel",
                             h2("Summary Takeaways", class="h2_title"),
                             dataTableOutput("summary_table")
                         ),
                ),
                tabPanel("Report",
                         mainPanel(
                           h2("Report page", class="h2_title"),
                           uiOutput('markdown'),
                         )
                ), 
        )
)


library(shiny)

#selectInput("race", label=h3("Choose a variable to display"),
#           c("Percent White", "Percent Black", "Percent Hispanic", "Percent Asian")),
#sliderInput("years", label="Select year range", min=0, max=100, value = c(0, 100))),
shinyUI(fluidPage(

  titlePanel(
    h1("Visual Analysis of Movies")),

  navlistPanel(
    "Click on the following Visualizations",
    "\n",
    tabPanel("First",
             htmlOutput("yearSelection"),
             uiOutput("yearControl"),
             plotOutput("moviesByYear")),
    tabPanel("Second",
             textOutput("selection2"),
             uiOutput("genreControl"),
             plotOutput("carPlot")),
    tabPanel("Third"),
    id="tab"
    )
))

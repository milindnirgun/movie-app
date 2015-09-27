library(shiny)

#selectInput("race", label=h3("Choose a variable to display"),
#           c("Percent White", "Percent Black", "Percent Hispanic", "Percent Asian")),
#sliderInput("years", label="Select year range", min=0, max=100, value = c(0, 100))),
shinyUI(fluidPage(

  titlePanel(
    h1("Exploratory Analysis (Visual) of Movies")),

  navlistPanel(
    "Select an option below",
    "\n",
    tabPanel("Overview",
             h2("Overview"),
             p("This is a visual exploratory analysis of the ", em('movies'),
               " dataset available in the ggplot2 library. This dataset is an extract from the original movie database made available by IMDB."),
             p("Click any of the options available in the navigation list on the left to see different graphical representations of the dataset. Some of the panels allow you to select input parameters to narrow the results. For eg. the first option, ", em("Movies By Year"), " allows you to choose the beginning year and ending year to see the results for the period in between."),
             p("This application was built using R, RStudio and Shiny and is hosted on the ", strong("shinyapps.io"), " free hosting service for such applications."),
             p("Some important links:"),
             a('Shiny', href='http://shiny.rstudio.com'), br(),
             a('IMDB movie database', href='http://www.imdb.com/interfaces')),
    tabPanel("Movies By Year",
             htmlOutput("yearSelection"),
             uiOutput("yearControl"),
             plotOutput("moviesByYearPlot"),
             htmlOutput("yearlyAverage")),
    tabPanel("Density plot of Viewer Ratings",
             htmlOutput("ratingSelection"),
             plotOutput("ratingPlot"),
             h4("The average viewer rating for movies by each MPAA category is: "),
             br(),
             htmlOutput("averageRating")),
    tabPanel("Histogram of Lengths by Genre",
             htmlOutput("genreSelection"),
             selectInput("genre", "Select Genre",
                         list("Action" = "Action",
                              "Animation" = "Animation",
                              "Comedy" = "Comedy",
                              "Drama" = "Drama",
                              "Documentary" = "Documentary",
                              "Romance" = "Romance",
                              "Short" = "Short"
                         )),
             #uiOutput("genreControl"),
             plotOutput("genrePlot")),
    id = "tab"
    )
))

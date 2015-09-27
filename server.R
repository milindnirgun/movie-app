library(shiny)
library(ggplot2)
library(dplyr)
library(reshape2)

source("helpers.R")
movies <- readRDS("data/movies.rds")
moviesWithRatings <- getMoviesByRatings(movies)
avgRatings <- moviesWithRatings %>% group_by(mpaa) %>% summarize(mean(rating))
minYear = min(movies$year)
maxYear = max(movies$year)

shinyServer(function(input, output) {


  ## List Item 1 - "Movies By Year"
  #Use a reactive conductor to get a subset of movies dataframe for the years
  #selected. This reactive function is used by two outputs, hence it is efficient to
  #use such a reactive conductor instead of doing the subsetting twice for each user
  m <- reactive({ getMoviesByYear(movies, input$years[1], input$years[2]) })

  output$yearSelection <- renderUI({

    h4(paste("Number of Movies released from ", input$years[1], " to ", input$years[2]))
  })

  output$yearControl <- renderUI({

    sliderInput("years", label="Select year range", min=minYear, max=maxYear, value = c(minYear,maxYear), sep="")
  })

  output$moviesByYearPlot <- renderPlot({
    plotMoviesByYear(m())
  })

  output$yearlyAverage <- renderUI({
    h4(paste("The average number of movies made between ", input$years[1], " and ", input$years[2], " is "), strong(round(mean(m()$count), digits=2)))
  })
  ##############################

  ## List Item 2 - "Density Plot of Ratings"

  output$ratingSelection <- renderUI({
    h4("Kernel Density curve of viewer ratings for movies categorized by their MPAA rating")
  })
  output$ratingPlot <- renderPlot({
    plotMoviesByRatings(moviesWithRatings)

  })
  output$averageRating <- renderTable({

       print.data.frame(avgRatings)

  })
  ##############################

  ## List Item 3 - "Histogram of lengths by Genre"

  output$genreSelection <- renderUI({
    #Display message about the selection
    h4(paste("The frequency distribution of movie length for your selected genre of: ",input$genre))
  })

  output$genreControl <- renderUI({
    #Show a selectInput
    selectInput("genre", label="Select a genre of movies", choices=genreChoices)
  })

  output$genrePlot <- renderPlot({
    #Render a histogram of lengths for the selected genre
    gVar <- eval(input$genre)
    m <- getMoviesByGenre(movies, gVar)
    #m <- subset(movies, gVar == 1)
    plotGenreHistogram(m)
  })

})

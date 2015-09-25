library(shiny)
library(ggplot2)
library(dplyr)
library(reshape2)

source("helpers.R")
movies <- readRDS("data/movies.rds")

shinyServer(function(input, output) {

  output$selection2 <-  renderText({
    paste("you have selected", input$tab)
  })

  output$yearSelection <- renderUI({

    h2(paste("Number of Movies released from ", input$years[1], " to ", input$years[2]))
  })

  output$yearControl <- renderUI({
    minYear = min(movies$year)
    maxYear = max(movies$year)

    sliderInput("years", label="Select year range", min=minYear, max=maxYear, value = c(minYear,maxYear))
    #selectInput("input1", label=h3("Choose a year"), c("2001", "2002", "2003"))
    #checkboxGroupInput("genres", "Choose Genre", genres[,1])
  })

  output$moviesByYear <- renderPlot({
    m <- getMoviesByYear(movies, input$years[1], input$years[2])
    plotMoviesByYear(m)
  })
# output$map <- renderPlot({

    ## A more elegant version than the one commented below
#    args <- switch(input$race,
#              "Percent White" = list(counties$white, "darkgreen", "% White"),
#              "Percent Black" = list(counties$black, "black", "% Black"),
#              "Percent Hispanic" = list(counties$hispanic, "darkorange", "% Hispanic"),
#              "Percent Asian" = list(counties$asian, "darkviolet", "% Asian"))
#    args$min <- input$slider1[1]
#    args$max <- input$slider1[2]

#    do.call(percent_map, args)
#    data <- switch(input$race,
#        "Percent White" = counties$white,
#        "Percent Black" = counties$black,
#        "Percent Hispanic" = counties$hispanic,
#        "Percent Asian" = counties$asian)
#    color <- switch(input$race,
#                    "Percent White" = "darkgreen",
#                    "Percent Black" = "black",
#                    "Percent Hispanic" = "blue",
#                    "Percent Asian" = "yellow")
#    title <- switch(input$race,
#                    "Percent White" = "% White",
#                    "Percent Black" = "% Black",
#                    "Percent Hispanic" = "% Hispanic",
#                    "Percent Asian" = "% Asian")

#    percent_map(var = data, color = color, legend.title = title, max = input$slider1[2], min = input$slider1[1])
#  })

})

## Utility functions
## external libraries these depend on are: dplyr, reshape2, ggplot2

# Function to get the count of movies by each year. This returns a dataframe of year and the count of movies per year.
getMoviesByYear <- function(x, from, to) {
  by_year <- x %>% group_by(year) %>% summarize(n_distinct(year))
  by_year <- by_year %>% filter(year >= from & year <= to)
  by_year <- as.POSIXct(x = apply(by_year[,1], 1, paste, "01", "01", sep="-"), origin="1960-01-01", tz="")
  by_title <- x %>% group_by(year) %>% summarize(n_distinct(title))
  by_title <- by_title %>% filter(year >= from & year <= to)
  names(by_title) <- c("year", "count")
  count_df <- data.frame(year = by_year, count = by_title[, 2])
  count_df$year <- as.POSIXct(x = paste(count_df$year, "01", "01", sep="-"), origin="1960-01-01", tz="")

  return(count_df)
}

# This returns a subset of the passed dataframe x with the condition of the variable y equal to 1
getMoviesByGenre <- function(x, y) {

  var <- eval((substitute(x[a], list(a = y))))

  m <- subset(x, var[1] == 1)
  #Clean up some data where the movie length is presumably recorded incorrectly
  return(subset(m, length > 5 & length < 1000))
}


#Return a dataframe with null ratings removed
getMoviesByRatings <- function(x) {
  m <- droplevels(subset(x, mpaa != ""))
  return(m)
}


# Plotting functions start here
plotMoviesByYear <- function(df) {
  g1 <- ggplot(data=df, aes(x=year, y=count)) + geom_bar(stat="identity", colour="black", fill="skyblue") +
        xlab("Years") +
        ylab("No. of Movies Released")
  return(g1)
}
#scale_colour_brewer(palette="Pastel1") +

# Plot a density plot of ratings
plotMoviesByRatings <- function(df) {
  g2 <- ggplot(data=df, aes(x=rating)) + geom_density(aes(fill=factor(mpaa)), alpha=.5) +
        labs(fill="MPAA Rating") +
        scale_x_discrete(limits = levels(df$rating)) +
        xlab("Viewer Ratings") +
        ylab("Density")
  return(g2)
}

#Plot a histogram of movie lengths
plotGenreHistogram <- function(df) {
  g3 <- ggplot(data=df, aes(x=length)) + geom_histogram(fill="skyblue", colour="black") +
        xlab("Movie length in minutes") +
        ggtitle("Histogram of movie lengths by genre")

  return(g3)
}
## Utility functions
## external libraries these depend on are: dplyr, reshape2, ggplot2

# Function to get the count of movies by each year. This returns a dataframe of year and the count of movies per year.
getMoviesByYear <- function(x, from, to) {
  by_year <- x %>% group_by(year) %>% summarize(n_distinct(year))
  by_year <- by_year %>% filter(year >= from & year <= to)
  by_year <- as.POSIXct(x = apply(by_year[,1], 1, paste, "01", "01", sep="-"), origin="1960-01-01", tz="")
  #by_year <- as.POSIXct(x = paste(by_year, "01", "01", sep="-"), origin="1960-01-01", tz="PST")
  by_title <- x %>% group_by(year) %>% summarize(n_distinct(title))
  by_title <- by_title %>% filter(year >= from & year <= to)
  names(by_title) <- c("year", "count")
  count_df <- data.frame(year = by_year, count = by_title[, 2])
  count_df$year <- as.POSIXct(x = paste(count_df$year, "01", "01", sep="-"), origin="1960-01-01", tz="")

  return(count_df)
}

# Function to get the count of movies by genre. This returns a dataframe with variables Genre and count of movies.
getMoviesByGenre <- function(x) {
  m <- melt(x, id.vars=c("title", "year"), measure.vars = c("Action", "Animation","Comedy","Drama","Documentary","Romance","Short"), variable.name="Genre", value.name="count")

  by_genre <- m %>% group_by(Genre) %>% summarize(sum(count))

  return(by_genre)
}

# Plotting functions start here
plotMoviesByYear <- function(df) {
  g1 <- ggplot(data=df, aes(x=year, y=count)) + geom_bar(stat="identity", colour="black") +
        scale_fill_brewer(palette="Pastel1") +
        xlab("Years") +
        ylab("No. of Movies Released")
  return(g1)
}

# load the library dplyr https://dplyr.tidyverse.org/ 
library(dplyr)
# load ggplot2 library
library(ggplot2)
# load the data
beer <- read.csv("./data/Beers.csv", header = TRUE, sep = ",")
breweries <- read.csv("./data/Breweries.csv", header = TRUE, sep = ",")
# Rename "Name" column in brewaries to Brewery
breweries <- rename(breweries, Brewery = Name)
# Count breweries per state
BreweriesPerState <- count(breweries, State)
# Washington DC is not a state, so remove it.
BreweriesPerState <- BreweriesPerState[- grep("DC", BreweriesPerState$State), ]
# Change the column name "n" to "Breweries"
names(BreweriesPerState)[names(BreweriesPerState)=="n"] <- "Breweries"
# Sort the breweries in descending order
BreweriesPerState <- arrange(BreweriesPerState, desc(Breweries))
# Display the first 5 
head(BreweriesPerState,5)
# Plot the Breweris Per State
ggplot(BreweriesPerState, aes(x=reorder(State, Breweries), y=(Breweries))) + geom_bar(stat='identity') + coord_flip() + labs(title ="Breweries Per State", x = "State", y = "Number of Breweries")

# merge the two df's
# Change the Brewary_ID in the beer df to Brew_ID so we can merge the two df's by Brew_ID
beer <- rename(beer, Brew_ID = Brewery_id)
merged_data <- inner_join(beer, breweries, by = "Brew_ID")
# Display the first 6 observations 
head(merged_data,6)
# Display the last 6 observations
tail(merged_data,6)
# Number of NA's in each column
sapply(merged_data, function(x) sum(is.na(x)))

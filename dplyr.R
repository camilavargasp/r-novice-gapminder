## R for reproducible scientific analysis
## Sofware Carpenty
##Camila Vargas


### Data Manipulation with dplyr

##calculate mean per continent using base R
mean(gapminder[gapminder$continent == "Africa", "gdpPercap"])

mean(gapminder[gapminder$continent == "Europe", "gdpPercap"])


##Install package
install.packages("dplyr")

library(dplyr)

## select() subsets data column-wise. Picks varable by their name

year_coutry_gdp <-  select(gapminder, year, country, gdpPercap)


## filter() - subsets data row-wise. Picks varables by their names

europe <- filter(gapminder, continent == "Europe")

## Introducing pipe %>% 

## Using select() and filter() together

year_country_gdp_euro <- gapminder %>% 
  filter(continent == "Europe") %>% 
  select(year, country, gdpPercap)

 gapminder %>% 
  select(year, country, gdpPercap) %>% 
  filter(country == "Chile")

 ## Write a single command (which can span multiple lines and includes pipes) that will produce a dataframe that has the African values for lifeExp, country and year, but not for other Continents. How many rows does your dataframe have and why?
 
 year_country_liefeExp_africa <- gapminder %>% 
   filter(continent == "Africa") %>% 
   select(year, country, lifeExp)
 
 ## group by() and summerize()
 
 gdp_bycontinent <- gapminder %>% 
   group_by(continent) %>% 
   summarise(mean_gdpPercap = mean(gdpPercap))
 
 gdp_pop_continent_year <- gapminder %>% 
   group_by(continent, year) %>% 
   summarise(mean_gdpPercap = mean(gdpPercap),
             sd_gdpPercap = sd(gdpPercap),
             mean_pop = mean(pop),
             sd_pop = sd(pop))

 ## count() and n()
 gapminder %>% 
   filter(year == 2002) %>% 
   count(continent, sort = TRUE)
 
 ##n() 
 
 gapminder %>% 
   group_by(continent) %>% 
   summarise(se_le = sd(lifeExp)/sqrt(n()))
 
 gapminder %>% 
   group_by(continent) %>% 
   summarise(mean_le = mean(lifeExp),
             min_le = min(lifeExp),
             max_le = max(lifeExp),
             se_le = sd(lifeExp)/ sqrt(n()))

 ##mutate() creates new variables with functions of existing variables
 
 gdp_pop_continent_year <- gapminder %>% 
   mutate(gdp_billion = gdpPercap*pop/ 10^9) %>% 
   group_by(continent, year) %>% 
   summarise(mean_gdpPercap = mean(gdpPercap),
             sd_gdpPercap = sd(gdpPercap),
             mean_pop = mean(pop),
             sd_pop = sd(pop),
             mean_gdp_billion = mean(gdp_billion),
             sd_gdp_billion = sd(gdp_billion))
 
 ##combining dplyr with ggplot
 
 ##get the start letters of each country
 start_letters <- substr(gapminder$country, start =  1, stop = 1)

 ##filtering countries the start with A or Z
 
 az.countries <- gapminder[start_letters %in% c("A", "Z"),] 
 
 ##make a plot
 library(ggplot2)
 
 ggplot(data = az.countries,
        mapping = aes(x = year,
                      y = lifeExp,
                      color = continent))+
   geom_line()+
   facet_wrap(~country)
 
 
 ##Using tidyverse sintax
 
 gapminder %>% 
   mutate(start_letters = substr(country, start = 1, stop = 1)) %>%
   filter(start_letters %in% c("A", "Z")) %>% 
   ggplot(aes(x = year,
              y = lifeExp,
          color = continent))+
   geom_line()+
   facet_wrap(~country)
   
 
 ##Tidyr package
 ##Is gapminder a purely long, purely wide, or some intermediate format?
   
gap_wide <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_wide.csv")

## from wide to long using the pivot_longer()

library(tidyr)

gap_long <- gap_wide %>% 
  pivot_longer(
    cols = c(starts_with("gdpPercap"), starts_with("lifeExp"), starts_with("pop")),
    names_to = "obstype_year",
    values_to = "obs_values"
  )

str(gap_long)

##split information into multiple variables using the function separate()

gap_long_yr <- gap_long %>% 
  separate(obstype_year,
           into = c("obs_type", "year"), sep = "_") %>% 
  mutate(year = as.integer(year))

## Using gap_long_yr, calculate the mean life expectancy, population, and gdpPercap for each continent. Hint: use the group_by() and summarize() functions we learned in the dplyr lesson

gap_long_yr %>% 
  group_by(continent, obs_type) %>% 
  summarise(means = mean(obs_values))

##from long to intermediate format with pivot_wider()

gap_normal <- gap_long_yr %>% 
  pivot_wider(names_from = obs_type,
              values_from = obs_values)


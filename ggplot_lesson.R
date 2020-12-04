##Creating Publication-Quality Graphs with ggplot2
##Camila Vargas

library(ggplot2)


###CHECK STRINA S FACTOR = FALSE??
gapminder <- read.csv("data/gapminder_data.csv")

gapminder <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_data.csv")


ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))+
  geom_point()

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))

##How life expentancy changes througgh time

ggplot(data = gapminder, mapping = aes(x = year, y = lifeExp))+
  geom_point()

##Adding colors per continent
ggplot(data = gapminder, mapping = aes(x = year, y = lifeExp, color = continent))+
  geom_point()

##geom_line

ggplot(data = gapminder, 
       mapping = aes(x = year, y = lifeExp, by = country, color = continent))+
  geom_line()+
  geom_point()


ggplot(data = gapminder, 
       mapping = aes(x = year, 
                     y = lifeExp, by = country))+
  geom_line(mapping = aes(color = continent))+
  geom_point()
  

ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country))+
  geom_line(color = "blue")+
  geom_point()


##lines ovwr points
ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country))+
  geom_point()+
  geom_line(mapping = aes(color = continent))


##Trasformations and statistics

ggplot(data = gapminder,
       mapping = aes(x = gdpPercap,
                     y = lifeExp))+
  geom_point()

ggplot(data = gapminder,
       mapping = aes(x = gdpPercap,
                     y = lifeExp))+
  geom_point(alpha = 0.5)+
  scale_x_log10()

##apply transperency within the mapping
ggplot(data = gapminder,
       mapping = aes(x = gdpPercap,
                     y = lifeExp))+
  geom_point(mapping = aes(alpha = continent))+
  scale_x_log10()

##adding a trend line
ggplot(data = gapminder,
       mapping = aes(x = gdpPercap,
                     y = lifeExp))+
  geom_point()+
  scale_x_log10()+
  geom_smooth(method = "lm", 
              size = 1.5)

##adding color and changing the size of the points in the graph

ggplot(data = gapminder,
       mapping = aes(x = gdpPercap,
                     y = lifeExp))+
  geom_point(color = "orange",
             size = 3)+
  scale_x_log10()+
  geom_smooth(method = "lm",
              size = 1.5)

##Adding shape and color by continent

ggplot(data = gapminder,
       mapping = aes(x = gdpPercap,
                     y = lifeExp,
                     color = continent))+
  geom_point(size = 3,
             shape = 17)+
  scale_x_log10()+
  geom_smooth(method = "lm",
              size = 1.5)

##Multi-panle figures
americas <- gapminder[gapminder$continent == "Americas", ]

ggplot(data = americas, 
       mapping = aes(x = year,
                     y = lifeExp))+
  geom_line()+
  facet_wrap(~country)+
  theme(axis.text.x = element_text(angle = 45))


##Modifying text
ggplot(data = americas,
       mapping = aes(x = year,
                     y = lifeExp,
                     color = continent))+
  geom_line()+
  facet_wrap(~country)+
  labs(x = "Year", ##x axis title
       y = "Life Expectancy", ##y axis title
       title = "Figure 1", ## main title of figure
       color = "Continent")+ ## title of legend
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


##exporting the plot
lifeExp_plot <- ggplot(data = americas,
       mapping = aes(x = year,
                     y = lifeExp,
                     color = continent))+
  geom_line()+
  facet_wrap(~country)+
  labs(x = "Year", ##x axis title
       y = "Life Expectancy", ##y axis title
       title = "Figure 1", ## main title of figure
       color = "Continent")+ ## title of legend
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


ggsave(filename = "results/lifeExp.png", plot = lifeExp_plot, width = 12, height = 10, dpi = 300, units = "cm")

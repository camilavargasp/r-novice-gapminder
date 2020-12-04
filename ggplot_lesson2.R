
library(ggplot2)

##read data
gapminder <- read.csv("data/gapminder_data.csv", header = TRUE, stringsAsFactors = TRUE)

##Plotting with ggplot - three basic components, data + aesthetics + geom
ggplot(data = gapminder, 
       mapping = aes(x = gdpPercap, 
                     y = lifeExp))+
  geom_point() 

ggplot(data = gapminder,
       mapping = aes(x = gdpPercap,
                     y = lifeExp))


ggplot(data = gapminder,
       mapping = aes(x = year, y =lifeExp)) +
  geom_point()


ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = lifeExp,
                     color = continent))+
  geom_point()

## Layers
ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country,
                     color = continent))+
  geom_line()+
  geom_point()


ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country))+
  geom_line(mapping = aes(color = continent))+
  geom_point()



ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country))+
  geom_point()+
  geom_line(mapping = aes(color = continent))


ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = lifeExp,
                     by = country))+
  geom_line(color = "blue")+
  geom_point()

## Transformations and statistics

##log10 trasformation
ggplot(data = gapminder,
       mapping = aes(x = gdpPercap,
                     y = lifeExp))+
  geom_point(alpha = 0.5)+
  scale_x_log10()


ggplot(data = gapminder,
       mapping = aes(x = gdpPercap,
                     y = lifeExp))+
  geom_point(mapping = aes(alpha = continent))+
  scale_x_log10()

## adding trend line

ggplot(data = gapminder,
       mapping = aes(x = gdpPercap,
                     y = lifeExp))+
  geom_point()+
  scale_x_log10()+
  geom_smooth(method = "lm", 
              size = 1.5)

##changing the size and color of points

ggplot(data = gapminder,
       mapping=aes(x=gdpPercap,
                   y=lifeExp))+
  geom_point(color="blue", 
             size= 1.5)+
  scale_x_log10()+
  geom_smooth(method="lm")


ggplot(data = gapminder, 
       mapping = aes(x= gdpPercap, 
                     y=lifeExp,
       ))+
  geom_point()+
  scale_x_log10()+
  geom_smooth(method = "lm",
              size=2, 
              color="red")


##Modify your solution to Challenge 4a so that the points are now a different shape and are colored by continent with new trendlines. Hint: The color argument can be used inside the aesthetic.

ggplot(data = gapminder,
       mapping = aes(x = gdpPercap,
                     y = lifeExp,
                     color = continent))+
  geom_point(size = 3,
             shape = 17)+
  scale_x_log10()+
  geom_smooth(method = "lm",
              size = 1.5)


## Multi-panel plot

americas <- gapminder[gapminder$continent == "Americas", ]

ggplot(data = americas,
       mapping = aes(x = year,
                     y = lifeExp))+
  geom_line()+
  facet_wrap(~country)+
  theme(axis.text.x = element_text(angle = 45))


## Modifying text

lifeExp_plot <-  ggplot(data = americas,
       mapping = aes(x = year,
                     y = lifeExp,
                     color = continent))+
  geom_line()+
  facet_wrap(~country)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  labs(x = "Year",
       y = "Life Expectancy",
       title = "Figure 1",
       color = "Continent")

##save a grpah into a the result folder of my project
ggsave(filename = "results/lifeExp.png", plot = lifeExp_plot, width = 12, height = 10, dpi = 300, units = "cm")

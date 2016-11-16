# ggplot2 formatting 

## Default colors

To generate a list of the colors:

```
library(ggplot2)
library(scales)

gg_color_hue <- function(n) {
  hues = seq(15, 375, length = n + 1)
  hcl(h = hues, l = 65, c = 100)[1:n]
}

n = 4
cols = gg_color_hue(n)

dev.new(width = 4, height = 4)
plot(1:n, pch = 16, cex = 2, col = cols)

```

The default colors:
- red: `#F8766D`
- blue: `#00BFC4`

# Specialized operations

## Drawing a summary statistic line

Example with median, could also use mean or whatever.

This uses geom_errorbar:
```

library(ggplot2)

test_data = data.frame(
  y = c(rnorm(10), rnorm(10, 5)),
  response = rep(c(0, 1), each = 10)
)
test_data$response = factor(test_data$response, levels = c(1,0))

ggplot(data = test_data, aes(x = "Group", y = y, colour = response)) +
  #geom_boxplot(data = subset(test_data, response == 1), fill = NA) +
  geom_jitter() +
  geom_errorbar(data = subset(test_data, response == 1),
                stat="summary", fun.y="median", width=0.8, 
                aes(ymax=..y.., ymin=..y..))

```
Alternative using stat_summary:
```
ggplot(data = test_data, aes(x = "Group", y = y, colour = response)) +
  #geom_boxplot(data = subset(test_data, response == 1), fill = NA) +
  geom_jitter() +
  stat_summary(data = subset(test_data, response == 1),fun.y=median,geom='crossbar',
   fun.ymax = median, fun.ymin = median,col='black') 

```
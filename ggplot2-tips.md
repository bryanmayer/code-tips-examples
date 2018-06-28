# Legend manipulations

## adding a common legend.

Example with cowplot using plot_grid.

```
library(ggplot2)
library(cowplot)


test_data = data.frame(
  outcome = c(rnorm(10), rnorm(10, 5)),
  response = rep(c(0, 1), each = 10)
)

test_plot = ggplot(data = test_data, aes(x = outcome, fill = factor(response))) +
 geom_density()

#Adjusting legend position here, could do earlier, need to be careful because version upgrades may eventually prevent multiple calls to the same theme() options.

mylegend = gtable::gtable_filter(ggplot_gtable(ggplot_build(test_plot + theme(legend.position = "top"))), "guide-box")

# turn the legend off
test_plot_noleg = test_plot + theme(legend.position = "none")

plot_grid(mylegend, plot_grid(test_plot_noleg, test_plot_noleg, nrow = 1),
  nrow = 2, rel_heights = c(1, 11))


```

## using guide to overwrite

http://docs.ggplot2.org/0.9.3.1/guide_legend.html

### data setup

```
library(ggplot2)
library(cowplot)


test_data = data.frame(
  outcome = c(rnorm(10), rnorm(10, 5)),
  response = rep(c(0:4), each = 4)
)
```

### Mulitple rows

```
ggplot(data = test_data, aes(y = outcome, x = factor(response), colour = factor(response))) +
 geom_point() +
 guides(col = guide_legend(nrow = 2))

```

### Changing aes shape and sizes for legend

```
ggplot(data = test_data, aes(y = outcome, x = factor(response), colour = factor(response))) +
 geom_point() +
 guides(col = guide_legend(override.aes = list(shape = 5, size = 4)))

```

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

| **Total colors**| 1 | 2 | 3 | 4 | 5 | 6 | 
|----------|-------------|---------|---------------|-------------|---------|---------------|
| *2*| red: `#F8766D` | blue: `#00BFC4` |  |  |  |  | 
| *3*| red: `#F8766D` | green: `#00BA38` | d. blue: `#619CFF` |  |  |  | 
| *4*| red: `#F8766D` | l. green: `#7CAE00` | blue: `#00BFC4` | purple `#C77CFF` |  |  | 
| *5*| red: `#F8766D` | yellow: `#A3A500` | green2: `#00BF7D` | d. blue2: `#00B0F6` | purple `#C77CFF` | | 
| *6*| red: `#F8766D` | yellow2: `#B79F00` | green: `#00BA38` | blue: `#00BFC4` | d. blue `#619CFF` | magenta: `#F564E3` | 



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

# Multiple plots

Make a list of 24 plots:
```
library(ggplot2)

plot_list = plyr::llply(1:24, function(i){
  #this is just random data
  plot_data = data.frame(x = rnorm(100), y = rnorm(100))

  ggplot(data = plot_data, aes(x = x, y = y)) +
    geom_point()
 
 })
 
plot_list[[1]]

```

## multiple panels with labels using cowplot

```
library(cowplot)

plots1 = plot_grid(plotlist = plot_list[1:12], nrow = 3, ncol = 4, labels = LETTERS[1:12])
plots2 = plot_grid(plotlist = plot_list[13:24], nrow = 3, ncol = 4, labels = LETTERS[13:24])

plots1
plots2
```

## save output as multiple pages with marrangeGrob

```
library(gridExtra)

page_plots = marrangeGrob(grobs = plot_list, nrow = 3, ncol = 4)
#makes multiple windows
page_plots

ggsave("page_plots.pdf", page_plots)


##using the cowplot labels from above
page_plots2 = marrangeGrob(grobs = list(plots1, plots2), nrow = 1, ncol = 1)
page_plots2

ggsave("page_plots2.pdf", page_plots2)

```

## multiple labels across chunks

```

```{r}
plot_list = map(1:4, function(i){
  dat = data.frame(x = rnorm(100, i *5), y = rnorm(100, i * 10))
  ggplot(data = dat, aes(x = x, y = y)) +
    geom_point()
  
})

!```!

```{r test_plots, fig.cap=paste0("test plot: ", as.character(1:4))}
for(i in 1:4){
 print(plot_list[[i]] + ggtitle(i))
  cat('\r\n\r\n')
}

!```!

```


```

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
  
  
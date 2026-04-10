library(tidyverse)
library(easystats)

library(tinytable)


mariokart <- read_csv("mariokart.csv")


mariokart_no_outliers <-
  mariokart |> 
  filter(total_pr < 100)

desk1 <-
  mariokart |>
  select(total_pr) |>
  describe_distribution()


lm_hyp1 <- 
  lm(total_pr ~ cond + total_pr + start_pr, data = mariokart)


lm1_modelsumm <- modelsummary(lm_hyp1)


#### Preamble ####
# Purpose: Pre-analysis using non-matched data
# author: "Yang Wu"
# Data: 14 April 2021
# Contact: yangg.wu@mail.urotonto.ca
# License: MIT
# Pre-requisites: 
# - None

#### Workspace setup ####
library(tinytex)
library(tidyverse)
library(broom)
####load dataset

clean_data<- read.csv(here::here("inputs/DATA/clean_data.csv"))

clean_data$treat<-ifelse(clean_data$Mobile_device== 'iPhone',1,0)

table(clean_data$treat)

####Write into new csv
write_csv(clean_data, 'inputs/DATA/processed_dataset.csv')

#### 1.1 Difference-in-means: dependent variable
clean_data%>%
  group_by(treat) %>%
  summarise(n_users=n(),
            mean_perceived_security= mean(PSave),
            std_error  = sd(PSave)/ sqrt(n_users))%>%
  kableExtra::kbl(caption = "Difference-in-means: dependent variable") %>%
  kableExtra::kable_styling(latex_options = c("hold_position"))
## The standard error is considered part of inferential statistics. It represents the standard deviation of the mean within a dataset. This serves as a measure of variation for random variables, providing a measurement for the spread. The smaller the spread, the more accurate the dataset.
ttest<-with(clean_data, t.test(PSave ~ treat))

tidy(ttest)%>%
  select(-c(estimate,statistic,parameter))%>%
  rename(
    mean_of_Control=estimate1,
    mean_of_Treated=estimate2
  )%>%
  kableExtra::kbl(caption = "T-test on dependent variable") %>%  
  kableExtra::kable_styling(latex_options = "scale_down")%>% # use scale_down option to make the font
  kableExtra::kable_styling(latex_options = c("hold_position"))

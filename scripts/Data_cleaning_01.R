#### Preamble ####
# Purpose: This script is used to do the data cleaning.
# author: "Yang Wu"
# Data: 14 April 2021
# Contact: yangg.wu@mail.urotonto.ca
# License: MIT
# Pre-requisites: 
# - None

#### Workspace setup ####
library(tinytex)
library(tidyverse)

####read the data 
library(here) # locate the file path
data<- read.csv("inputs/DATA/questionnaire data.csv")
####rename column names
data<-
data %>% 
  rename(
    Work_experience = X.1Howlonghaveyouworkedinthisorganization,
    Gender = X.2Whatisyourgender,
    Age = X.3Whatsyourageinyears,
    Education_level = X.4whatisyoureducationallevel,
    Functions_used = X.5WhichfunctionsdoyouuseinERPsystem,
    Usage_frequency = X.6HowoftendoyouusemobileERPsystem,
    ES_Name = X.7WhatisthenameofthemobileERPsystemtypicallyusediny,
    Mobile_device = X.8Whichmobiledevicedoyouuse,
    Device_ownership = X.9Whohastheownershipofthedevice
  )

####Remove useless columns
questonnaire_data<-
  data %>%
  select(-1)


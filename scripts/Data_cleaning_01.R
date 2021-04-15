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


####rename demographics column names
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
  select(-c(1,52,53,54,55,56,57,58))

####rename variables column names
questonnaire_data<-
  questonnaire_data %>% 
  rename(
    Install_firewall=MD1,
    BYOD=MD2,
    Ignore_warnning=MD3,
    Strong_pin=MD4,
    Store_passwords=MD5,
    update_OS=MD6,
    public_WiFi=WN1,
    unsecured_network=WN2,
    network_control=WN3,
    network_attack=WN4,
    encrypted_transimittion=WN5,
    unreliable_int=WN6,
    cloud_resource=Cl1,
    cloud_compute=Cl2,
    remote_datastore=Cl3,
    Data_regulation=Cl4,
    multiple_login=Cl5,
    weak_authentication=Cl6,
    unknown_app=APP1,
    update_ES=APP2,
    Auto_update=APP3,
    VPN=APP4,
    third_party_app=APP5,
    update=APP6,
    single_authenticate=Da1,
    audit_log=Da2,
    access_right=Da3,
    change_data=Da4,
    malicious_attack=Da5,
    Data_threats=Da6,
    system_integrity=PS1,
    system_availability=PS2,
    system_confidentiality=PS3,
    system_accountability=PS4,
    system_nonrepudiation=PS5
  )


####Write into new csv
write_csv(questonnaire_data, 'inputs/DATA/clean_data.csv')


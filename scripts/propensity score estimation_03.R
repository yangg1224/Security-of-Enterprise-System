#### Preamble ####
# Purpose: 2 Propensity score estimation
# author: "Yang Wu"
# Data: 14 April 2021
# Contact: yangg.wu@mail.urotonto.ca
# License: MIT
# Pre-requisites: 
# - None

#### Workspace setup ####
library(tinytex)
library(tidyverse)

clean_data<- read.csv(here::here("inputs/DATA/processed_dataset.csv"))
summary(clean_data)


################# 1. propensity score estimation ################# 

##logit model 
m_ps<-glm(treat~ Install_firewall+BYOD+ Ignore_warnning+Strong_pin+
          Store_passwords+update_OS+public_WiFi+unsecured_network+
          network_control+network_attack+encrypted_transimittion+unreliable_int+
          cloud_resource +cloud_compute+remote_datastore+Data_regulation+multiple_login+
          weak_authentication+unknown_app+  update_ES+ Auto_update+
          VPN + third_party_app+update+single_authenticate+audit_log+access_right+ change_data+ malicious_attack+Data_threat, 
          family = binomial(), data = clean_data)
summary(m_ps)

##propensity score 
prs_df <- data.frame(pr_score = predict(m_ps, type = "response"),
                     treat = m_ps$model$treat)
head(prs_df)

################# 2.  Examining the region of common support ################# 

##After estimating the propensity score, it is useful to plot histograms of the estimated propensity scores by treatment status:

labs <- paste("Actual phone type used:", c("IOS", "Andriod"))
prs_df %>%
  mutate(treat = ifelse(treat == 1, labs[1], labs[2])) %>%
  ggplot(aes(x = pr_score)) +
  geom_histogram(color = "white") +
  facet_wrap(~treat) +
  xlab("Probability of using iPhone to operate ES") +
  theme_bw()

################# 3 Executing a matching algorithm #################

## A simple method for estimating the treatment effect of using iPhone as device is to restrict the sample to observations within the region of common support, and then to divide the sample within the region of common support into 5 quintiles, based on the estimated propensity score. Within each of these 5 quintiles, we can then estimate the mean difference in student achievement by treatment status. Rubin and others have argued that this is sufficient to eliminate 95% of the bias due to confounding of treatment status with a covariate.

## However, most matching algorithms adopt slightly more complex methods. The method i use below is to find pairs of observations that have very similar propensity scores, but that differ in their treatment status. We use the package MatchIt for this. This package estimates the propensity score in the background and then matches observations based on the method of choice (“nearest” in this case).

sum(is.na(clean_data)) # MatchIt does not allow missing values

##install.packages("MatchIt")
library(MatchIt)
mod_match <- matchit(treat~ Install_firewall+BYOD+ Ignore_warnning+Strong_pin+
                       Store_passwords+update_OS+public_WiFi+unsecured_network+
                       network_control+network_attack+encrypted_transimittion+unreliable_int+
                       cloud_resource +cloud_compute+remote_datastore+Data_regulation+multiple_login+
                       weak_authentication+unknown_app+  update_ES+ Auto_update+
                       VPN + third_party_app+update+single_authenticate+audit_log+access_right+ change_data+ malicious_attack +Data_threats, method = "nearest", data = clean_data)

## check the match
dta_m <- match.data(mod_match)
dim(dta_m)
#Note that the final dataset is smaller than the original: it contains 326 observations, 
#meaning that 163 pairs of treated and control observations were matched. 
#Also note that the final dataset contains a variable called distance, which is the propensity score.

################# Estimating treatment effects #################

## T test
ttest_after<-with(dta_m, t.test(PSave ~ treat))
ttest_after
tidy(ttest_after)%>%
  select(-c(estimate,statistic,parameter))%>%
  rename(
    mean_of_Control=estimate1,
    mean_of_Treated=estimate2
  )%>%
  kableExtra::kbl(caption = "T-test on dependent variable") %>%  
  kableExtra::kable_styling(latex_options = "scale_down")%>% # use scale_down option to make the font
  kableExtra::kable_styling(latex_options = c("hold_position"))

## regression 
propensity_score_regression <- lm(PSave~ Install_firewall+BYOD+ Ignore_warnning+Strong_pin+
                                    Store_passwords+update_OS+public_WiFi+unsecured_network+
                                    network_control+network_attack+encrypted_transimittion+unreliable_int+
                                    cloud_resource +cloud_compute+remote_datastore+Data_regulation+multiple_login+
                                    weak_authentication+unknown_app+  update_ES+ Auto_update+
                                    VPN + third_party_app+update+single_authenticate+audit_log+access_right+ change_data+ malicious_attack +Data_threats+treat,
                                  data = dta_m)
##install.packages("huxtable")
library(huxtable)
huxtable::huxreg(propensity_score_regression)

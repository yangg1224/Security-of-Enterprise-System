# Security of Enterprise System 

# Abstract
Organizations are adopting mobile technologies for various business applications including Enterprise system (ES) to increase the flexibility and to gain sustainable competitive advantage. At the same time, end-users are exposed to security issues when using mobile technologies. Users’ usage habits and users’ attitudes towards those potential security issues would have a significant impact to the perceived security of ES. Here comes the question: will iPhone users have higher perceived security than Android users? Through the propensity score matching and regression model, we have the answer.

# Overview of the Data
The purpose of this project is to examine whether iPhone users (IOS) are securer than Android users when using mobile ES. The intervention is using iPhone as mobile device. The questionnaire survey is the chosen method for collecting data from mobile ES users, which has been done last year. 

The description of the variables are as followed:
* `Work_experience` : measures how long does the user work in the current company 
* `Gender` : describes the user's gender 
* `Age` : describes the user's age
* `Education_level` : describes user's educational level (High school, college, undergrad, postgrade) 
* `Functions_used` : asks users which functionalities they use everyday
* `Usage_frequency` : describes the frequency of the usage of mobile ES
* `ES_Name` : describes the name of ES
* `Mobile_device` : asks for user's mobile phone brand 
* `Device_ownership` : clarify if the mobile phone is owned by company or owned by the user 
* `system_integrity` : measures user's attitude towards "I believe the data/ information in the mobile enterprise systems cannot be modified by unauthorized users"
* `system_availability` : measures user's attitude towards "I believe the data/ information in the mobile enterprise systems is available only to authorized users when required "
* `system_confidentiality` : measures user's attitude towards "I believe that the mobile enterprise systems are secured as the system detects and prevents the improper disclosure/ leakage of information"
* `system_accountability` : measures user's attitude towards "I believe that the mobile enterprise systems are secured as the system accounts the data changes"
* `system_nonrepudiation` : measures user's attitude towards "I believe that the mobile enterprise system is secured as the system does not deny any transaction that was carried out"
* `PSave` : (Dependent variable) used in the model. It takes a mean of the previous five features and presents for the user's perceived ES security. 

more on paper

# File Structure
* Scripts: the folder contains R codes to import data, clean data and basic data analysis.
* Input: The raw dataset and cleaned dataset are in the "data" subfolder.
* Output: the "paper" subfolder contains pdf, R code and reference list of the paper. 


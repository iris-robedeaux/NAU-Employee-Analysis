library(readxl)
library(dplyr)

#read the original file
data <- read_excel("FILE NAME")

#remove $ and , from the salary (and make it a number)
data$`Annual Wages` <- as.numeric(gsub('[$,]', '', data$`Annual Wages`))

#name it to academic year (for accuracy)
data <- data %>% rename_at('Annual Wages', ~'AY Salary')

#rename our id column properly
data <- data %>% rename_at('First Name Last Name', ~'Employee ID')

#drop the original employee id, birthday (age is separate), 
#            employer (all nau), IPEDS Ethnicity (same as 
#            the enthnicity column), & source
colsToRemove <- c('Emplid', 'Birth Date', 'Employer', 'IPEDS Ethnicity', 'Source')
data <- subset(data, select = !(names(data) %in% colsToRemove)) 

#export cleaned data
write.csv(data, "FILE PATH",  row.names=FALSE)

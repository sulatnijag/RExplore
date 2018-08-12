library(tidyverse)
library(readxl)


rm(list=ls())

uni <- read_excel("Data/Population_Education.xlsx", sheet="University", col_names=T)
uni$school <- "University"

pol <- read_excel("Data/Population_Education.xlsx", sheet="Polytechnic", col_names=T)
pol$school <- "Polytechnic"

pop_edu <- rbind_all(list(uni, pol)) %>% arrange(Course)
pop_edu <- pop_edu %>% extract(Course, c("Gender", "Course"), "(.*):[[:space:]](.*)")

cols <- colnames(pop_edu)
cols <- cols[! cols %in% c("Gender","school", "Course") ]

pop_edu <- pop_edu %>% mutate_at(vars(cols), funs(as.numeric(.)) )

filter(pop_edu , grepl("information technology", pop_edu$Course, ignore.case=T)) %>% 
  select(-Gender,-school) %>%
  group_by(Course) %>% summarise_all(sum) %>% View()




          
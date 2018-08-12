library(tidyverse)
library(readxl)


rm(list=ls())

uni <- read_excel("Data/Population_Education.xlsx", sheet="University", col_names=T)
uni$school <- "University"

pol <- read_excel("Data/Population_Education.xlsx", sheet="Polytechnic", col_names=T)
pol$school <- "Polytechnic"

pop_edu <- rbind_all(list(uni, pol)) %>% arrange(Course)

pop_edu <- pop_edu %>% extract(Course, c("Gender", "Course"), "(.*):[[:space:]](.*)")


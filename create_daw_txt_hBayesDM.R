#!/usr/bin/env Rscript
#This script combines Daw trial level data, does some cleaning, and saves a txt file to be used as input for hBayesDM. The intent is to make this applicable for any data for input to hBayesDM.
library(rstan)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(hBayesDM)
#Read in data.
luna_7t <- read.csv("luna_7tbrainmech.csv", header = TRUE)
luna_pet <- read.csv("luna_pet.csv", header = TRUE)
luna_7t_pet <- rbind(luna_7t, luna_pet)
#Cleaning chunk
luna_7t_pet <- luna_7t_pet %>% 
group_by(id) %>% 
mutate(trial = row_number()) %>% 
filter(choice1 != 0 & choice2 != 0) %>% 
rename(subjID = id, level1_choice = choice1, reward = money) %>% 
mutate(level2_choice = case_when(
level1_choice == 1 & choice2 == 1 & state == 2 ~ 1, 
level1_choice == 1 & choice2 == 2 & state == 2 ~ 2, 
level1_choice == 2 & choice2 == 1 & state == 3 ~ 3, 
level1_choice == 2 & choice2 == 2 & state == 3 ~ 4, 
level1_choice == 1 & choice2 == 1 & state == 3 ~ 3, 
level1_choice == 1 & choice2 == 2 & state == 3 ~ 4, 
level1_choice == 2 & choice2 == 1 & state == 2 ~ 1, 
level1_choice == 2 & choice2 == 2 & state == 2 ~ 2)) %>% 
filter(!(subjID %in% c("11455_20181218", "11565_20190709")))
#Create .txt file for use in hBayesDM
write.table(luna_7t_pet, file = "luna_7t_pet.txt", sep = "\t", row.names = FALSE)

#!/usr/bin/env Rscript
library(rstan)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(hBayesDM)

#There are three built in scripts for hBayesDM. Each one varies by the number of estimated parameters. I will run them all and save the output as separate rds file.

#Running the 4 parameter hBayesDM model
ts_par4_7t_pet_results <- ts_par4(data = "luna_7t_pet.txt", inc_postpred = TRUE)

#Saving output
saveRDS(ts_par4_7t_pet_results, file = "ts_par4_7t_pet_results.rds")

#Running the 6 parameter hBayesDM model
ts_par6_7t_pet_results <- ts_par6(data = "luna_7t_pet.txt", inc_postpred = TRUE)

#Saving output
saveRDS(ts_par6_7t_pet_results, file = "ts_par6_7t_pet_results.rds")

#Running the 7 parameter hBayesDM model
ts_par7_7t_pet_results <- ts_par7(data = "luna_7t_pet.txt", inc_postpred = TRUE)

#Saving output
saveRDS(ts_par7_7t_pet_results, file = "ts_par7_7t_pet_results.rds")

library(R.matlab)
library(tidyr)
source("./VEM.R")

N <- 4      # total no. of dataset
Tn <- 1000   # the length of time series for each subject

y <- readMat("Binarized_sample_data.mat")  # 0/1, Prepare a dataframe with N*Tn rows and d columns
x=y$binarizedData     # matrix should be stored in the variable name 'binarizedData'
subj <- rep(1:N, each = Tn)

# VEM 
result_vem <- VEM.Boltzmann(x, N, subj)

parameter=result_vem$mu
writeMat('h_J_value.mat', parameter=parameter)
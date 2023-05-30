library(R.matlab)
library(tidyr)
source("./VEM.R")

N <- 80      # total no. of dataset
Tn <- 818   # the length of time series for each subject

y <- readMat("Sample_data.mat")  # 0/1, Prepare a dataframe with N*Tn rows and d columns
x=y$binarizedData     # matrix should be stored in the variable name 'binarizedData'
subj <- rep(1:N, each = Tn)

# VEM 
result_vem <- VEM.Boltzmann(x, N, subj)

d=result_vem$mu
writeMat('h_J_value.mat', d=d)
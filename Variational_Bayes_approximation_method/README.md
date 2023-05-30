# Variational Bayes approximation method

Please cite
"S.-O. Jeong, J. Kang, C. Pae, J. Eo, S. M. Park, J. Son, H.-J. Park, Empirical bayes estimation of pairwise maximum entropy model for nonlinear brain state dynamics, NeuroImage 244 (2021) 118618"
when using the code provided here.

--This code gives you the parameter value for the energy landscape analysis of fMRI data using variational Bayes approximation method.

`Bayesian_main.R`: main function to calculate the parameter value for the energy landscape analysis, which uses the following function
`VEM.Boltzmann`: function to calculate the parameter value using variational Bayes approximation method which comes from the source code `VEM.R`

Rstudio needs to be installed to run the code with the following dependencies:

*R.matlab package
*tidyr package


Contains example usage of `Bayesian_main.R` with dummy data named 'Sample_data.mat' which contains 80 subject and 818 time points in each subject.
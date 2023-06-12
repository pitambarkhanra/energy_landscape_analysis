# Variational Bayes approximation method to estimate the pairwise maximum entropy model (i.e., Boltzmann machine, inverse Ising model)

When you use the code provided here, please cite the following two papers:

[S.-O. Jeong, J. Kang, C. Pae, J. Eo, S. M. Park, J. Son, H.-J. Park, Empirical bayes estimation of pairwise maximum entropy model for nonlinear brain state dynamics, NeuroImage 244, 118618 (2021)](https://doi.org/10.1016/j.neuroimage.2021.118618)

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573](https://arxiv.org/pdf/2305.19573.pdf)

# What is this repository?
This code gives you the parameter value for the energy landscape analysis of fMRI data using variational Bayes approximation method.

[NM: Show usage example in command line format. Also, format it very well, by mimicking other examples on github.]

# Required software and packages:

- RStudio or any compatible software
- *R.matlab package and *tidyr package

# How to use the code?

Open RStudio and run the file `Bayesian_main.R`.

`Bayesian_main.R`: main function to calculate the parameter values for the energy landscape analysis, which uses the function VEM.Boltzmann.

VEM.Boltzmann is the function to calculate the parameter values using the variational Bayes approximation method. This function is contained in `VEM.R`.

# Sample dataset:
Contains [NM: What is the argument of this sentence? What file contains the example usage?] an example usage of `Bayesian_main.R` with a dummy data set named `Sample_data.mat`. The file `Sample_data.mat` contains a synthetic concatenated data from 4 participants and 1000 time points for each participant [NM: sounds like 4 data sets, but there is only one file, i.e., Sample_data.mat. Confusing].

# Input:
- Number of data sets, which users need to specify on line 5 in `Bayesian_main.R`.
- Length of the time series of each data set, which needs to be specified in line 9.
- Read the concatenated data file in ".mat" format, which needds to be specified in line 8. [NM: How can users concatenate their data? Want to clarify for users.]

# Output:
- `h_J_value.mat`, which contains the estimated parameter values. Each row of this file corresponds to a participant in the format [h_1,h_2,...,h_N,J_12,J_13,J_(N-1),N]. [NM: Can you typeset this properly. Underscore is a latex notion. I want it to look h and J in italic and 1, 12, 13 etc. in subscripts. In a related vein, does markdown have a functionality to use latex (math) commands? You can sort it out yourself.]


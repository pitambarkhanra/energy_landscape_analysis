# Variational Bayes approximation method to estimate the pairwise maximum entropy model (i.e., Boltzmann machine, inverse Ising model)

This code calculates the parameter values for the Ising model from multivariate time series data using the variational Bayes approximation method.

When you use the code provided here, please cite the following two papers:

[S.-O. Jeong, J. Kang, C. Pae, J. Eo, S. M. Park, J. Son, H.-J. Park, Empirical bayes estimation of pairwise maximum entropy model for nonlinear brain state dynamics, NeuroImage 244, 118618 (2021)](https://doi.org/10.1016/j.neuroimage.2021.118618)

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573](https://arxiv.org/pdf/2305.19573.pdf)

# Required software and packages

- RStudio or any compatible software
- *R.matlab package and *tidyr package

# How to use the code?

Open RStudio and run the file `Bayesian_main.R`.

`Bayesian_main.R`: main function to calculate the parameter values for the energy landscape analysis, which uses the function VEM.Boltzmann.

VEM.Boltzmann is the function to calculate the parameter values using the variational Bayes approximation method. This function is contained in `VEM.R`.

# Sample data set
The file `Sample_data.mat` contains the concatenation of the 7-dimensional time series over 4 dummy data files. Each dummy data file consists of 1000 time points. In fact, the 4 dummy data files are those in [the Conventional folder](https://github.com/pitambarkhanra/energy_landscape_analysis/tree/main/Conventional).

# Concatenation procedure
Let $[a_i]_ {{t_{\max}\times N}}$ be a binarized (i.e., 0 or 1) time series data file for session $i\in$\{ $1,\dots,D$ \}; where $t_{\max}$ denotes the number of time points, and $N$ is the number of ROIs. Then, the concatenated data will be stored in variable **binarizedData** $=[a_1;a_2; \ldots ;a_D]$ and save it in a .mat file to read it in `Bayesian_main.R`. [NM: Now I am finally understanding (probably) the working. Please do either of the following: (i) Provide a separate code that does this concatenaion job for the users. The input should be the input file names (and the number of data sets?). The output should be the concatenated file as described in this section. Don't impose manual work to do this concatenation on users. (ii) Rewrite the Bayesian_main.R so that it accepts many files before the concatenation and Bayesian_main.R does concatenation within it.]

# Input
- Number of data sets, which a user needs to specify in line 5 in `Bayesian_main.R`.
- Length of the time series of each data set, which needs to be specified in line 9.
- How to read the concatenated data file prepared in the .mat format, which needs to be specified in line 8.

# Output
- `h_J_value.mat` contains the estimated parameter values. Each row of this file corresponds to a data in the format $[h_1, \ldots, h_N,J_{12},J_{13},\ldots,J_{(N-1),N}]$.


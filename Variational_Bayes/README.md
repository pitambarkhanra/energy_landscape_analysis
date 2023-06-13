# Variational Bayes approximation method to estimate the pairwise maximum entropy model (i.e., Boltzmann machine, inverse Ising model)

When you use the code provided here, please cite the following two papers:

[S.-O. Jeong, J. Kang, C. Pae, J. Eo, S. M. Park, J. Son, H.-J. Park, Empirical bayes estimation of pairwise maximum entropy model for nonlinear brain state dynamics, NeuroImage 244, 118618 (2021)](https://doi.org/10.1016/j.neuroimage.2021.118618)

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573](https://arxiv.org/pdf/2305.19573.pdf)

# What is this repository?
This code gives you the parameter value for the energy landscape analysis of fMRI data using variational Bayes approximation method.

[NM: Show usage example in command line format. Also, format it very well, by mimicking other examples on github.][PK: I have changed it in sample dataset.]

# Required software and packages:

- RStudio or any compatible software
- *R.matlab package and *tidyr package

# How to use the code?

Open RStudio and run the file `Bayesian_main.R`.

`Bayesian_main.R`: main function to calculate the parameter values for the energy landscape analysis, which uses the function VEM.Boltzmann.

VEM.Boltzmann is the function to calculate the parameter values using the variational Bayes approximation method. This function is contained in `VEM.R`.

# Sample dataset:
[NM: What is the argument of this sentence? What file contains the example usage?] Example usage of `Bayesian_main.R` with a dummy data set named `Sample_data.mat`. The file `Sample_data.mat` contains a synthetic concatenated data from 4 participants and 1000 time points for each participant [NM: sounds like 4 data sets, but there is only one file, i.e., Sample_data.mat. Confusing][PK: It's the concatenated dataset for four participants, I have mentioned.].

# Concatenation procedure:
Let $(a_i)_{m \times n}$ [NM: This is an invalid notation. Is each $a_i$ a $m \times n$ matrix? Also, better use the same notation as in the paper, that is, $N$ for the number of ROIs and $t_{\max}$ (was it?) for the number of time points, including the code. Those small details will annoy and confuse users/readers.] be a binarized (i.e., 0 or 1) time series data for participant $i$, where $m$ is the number of time points, and $n$ is the number of ROIs. Then, the concatenated data will be in the form binarizedData [NM: What does this binarizedData mean? Is this the name of the variable you use in the file? If so, it is fine but please say that.] $=[a_1;a_2; \ldots ;a_i]$. [NM: This should be wrong, as $i$ is not the number of participants but it is an index for the participant.]

# Input:
- Number of data sets, which a user needs to specify in line 5 in `Bayesian_main.R`.
- Length of the time series of each data set, which needs to be specified in line 9.
- How to read the concatenated data file prepared in the .mat format, which needs to be specified in line 8.

# Output:
- `h_J_value.mat` contains the estimated parameter values. Each row of this file corresponds to a participant in the format $[h_1, \ldots, h_N,J_{12},J_{13},\ldots,J_{(N-1),N}]$.


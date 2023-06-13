# Variational Bayes approximation method to estimate the pairwise maximum entropy model (i.e., Boltzmann machine, inverse Ising model)

When you use the code provided here, please cite the following two papers:

[S.-O. Jeong, J. Kang, C. Pae, J. Eo, S. M. Park, J. Son, H.-J. Park, Empirical bayes estimation of pairwise maximum entropy model for nonlinear brain state dynamics, NeuroImage 244, 118618 (2021)](https://doi.org/10.1016/j.neuroimage.2021.118618)

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573](https://arxiv.org/pdf/2305.19573.pdf)

# What is this repository?
This code gives you the parameter value for the energy landscape analysis of fMRI data using variational Bayes approximation method.

# Required software and packages

- RStudio or any compatible software
- *R.matlab package and *tidyr package

# How to use the code?

Open RStudio and run the file `Bayesian_main.R`.

`Bayesian_main.R`: main function to calculate the parameter values for the energy landscape analysis, which uses the function VEM.Boltzmann.

VEM.Boltzmann is the function to calculate the parameter values using the variational Bayes approximation method. This function is contained in `VEM.R`.

# Sample data set
The file `Sample_data.mat` contains a synthetic concatenated data from 4 participants and 1000 time points for each participant [NM: The Conventional folder contains 4 data files. Are they the 4 original data sets from which this concatenated data set is computed? Confusing.][PK: This is the concatenated data file for the four participants from the conventional folder].

# Concatenation procedure
Let $[a_i]_ {{t_{max}\times N}}$ [NM: This is an invalid notation. Is each $a_i$ a $m \times n$ matrix? Also, better use the same notation as in the paper, that is, $N$ for the number of ROIs and $t_{\max}$ (was it?) for the number of time points, including the code. Those small details will annoy and confuse users/readers.] be a binarized (i.e., 0 or 1) time series data for participant $i\in$\{ $1,\dots,D$ \}; where $t_{max}$ denotes the number of time points, and $N$ is the number of ROIs. Then, the concatenated data will be in the form binarizedData [NM: What does this binarizedData mean? Is this the name of the variable you use in the file? If so, it is fine but please say that.][PK: yes, this is the variable name. I have corrected the writing] $=[a_1;a_2; \ldots ;a_D]$ (binarizedData is the variable name in the code used for the concatenated data). [NM: This should be wrong, as $i$ is not the number of participants but it is an index for the participant.][PK: Corrected]

# Input
- Number of data sets, which a user needs to specify in line 5 in `Bayesian_main.R`.
- Length of the time series of each data set, which needs to be specified in line 9.
- How to read the concatenated data file prepared in the .mat format, which needs to be specified in line 8.

# Output
- `h_J_value.mat` contains the estimated parameter values. Each row of this file corresponds to a participant in the format $[h_1, \ldots, h_N,J_{12},J_{13},\ldots,J_{(N-1),N}]$.


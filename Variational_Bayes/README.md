# Variational Bayes approximation method to estimate the pairwise maximum entropy model (i.e., Boltzmann machine, inverse Ising model)

This code calculates the parameter values for the Ising model from multivariate time series data using the variational Bayes approximation method.

When you use the code provided here, please cite the following two papers:

[S.-O. Jeong, J. Kang, C. Pae, J. Eo, S. M. Park, J. Son, H.-J. Park, Empirical bayes estimation of pairwise maximum entropy model for nonlinear brain state dynamics, NeuroImage 244, 118618 (2021)](https://doi.org/10.1016/j.neuroimage.2021.118618)

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573](https://arxiv.org/pdf/2305.19573.pdf)

# Required software and packages

- MATLAB2020 or later
- RStudio or any compatible software
- *R.matlab package and *tidyr package

# How to use the code?

Open RStudio and run the file `Bayesian_main.R`.

`Bayesian_main.R`: main function to calculate the parameter values for the energy landscape analysis, which uses the function VEM.Boltzmann.

VEM.Boltzmann is the function to calculate the parameter values using the variational Bayes approximation method. This function is contained in `VEM.R`.

# Sample data set
We provide a binarized (i.e., 0 or 1) data file named `Binarized_sample_data.mat` which contains the concatenation of the 7-dimensional time series over 4 dummy data files. Each dummy data file consists of 1000 time points. In fact, the 4 dummy data files are same as those in [the Conventional folder](https://github.com/pitambarkhanra/energy_landscape_analysis/tree/main/Conventional).
If you want to run the analysis with different data sets, you need to open MATLAB and run the file `Concatenate_data.m` by changing the names of the input data files in line 9 and changing the corresponding parameter value mentioned in the code. This code will give you the concatenated data file named `Binarized_sample_data.mat`.

# How to concatenate?
Let $[a_i]_ {{N \times t_{\max}}}$ be a binarized (i.e., -1 or 1) time series data file for session $i\in$\{ $1,\dots,D$ \}; where $N$ is the number of ROIs, and $t_{\max}$ denotes the number of time points. Then, if you run `Concatenate_data.m` [NM: Is this what you mean?][PK: No. Here we only want to describe the procedure of concatenation which we have used in the code `Concatenate_data.m`. The original sample data files (the four data file which is in the conventional folder and also in this folder) dimension is $N \times t_{max}$ and the binarization format is -1/1. If we run the code `Concatenate_data.m` with these data files it will do everything like changing the binarization format to 0/1, changing the dimension and also concatenation. How to use the code is already described in the previous section.] [NM: I think my frustration comes from the fact that this section is named "How to concatenate" but this section does not describe it. I suggest the last section only describes the sample data, and the concatenation procedure -related text is moved from the last section to this section and nicely merged with the text here.], the binarization format of the data file will be replaced from $(-1/1)$ to $(0/1)$ and the concatenated data will be stored in the variable **binarizedData** $=[a_1';a_2'; \ldots ;a_D']$ and will be saved in a .mat file, whose name one can specify in line 14 [NM: Fill the line number and remove this comment.]. This concatenated data should be fed to `Bayesian_main.R`.

# Input
- Number of data sets, which a user needs to specify in line 5 in `Bayesian_main.R`.
- Length of the time series of each data set, which needs to be specified in line 9.
- Name of the concatenated data file prepared in the .mat format, which needs to be specified in line 8.

# Output
- `h_J_value.mat` contains the estimated parameter values. Each row of this file corresponds to a data in the format $[h_1, \ldots, h_N,J_{12},J_{13},\ldots,J_{(N-1),N}]$.


# Permutation test for the energy landscape analysis by the conventional likelihood maximization method

When you use the code provided here, please cite the following paper:

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573](https://arxiv.org/abs/2305.19573)

# What is this repository?

The code in this folder provides the MATLAB code of key functions [NM: Please eradicate the term "key" from this readme. The point is that we are not sketching the usage of this code, but we need to tell precisely how to use the code.] to perform the permutation test for the energy landscape analysis on multi-variate time series data such as fMRI data using the conventional gradient-ascent algorithm to maximize the likelihood estimation and to estimate the parameter values. The code in this folder estimates the ND value for the four discrepancy measures proposed in Khanra *et al.* (2023).

# Required software and packages

- MATLAB2020 or later
- MATLAB Statistics and Machine Learning Toolbox

# How to use the code?

We provide the MATLAB codes and key functions for example analysis and to calculate the ND values for the four discrepancy measures proposed in the above mentioned article.

To start with, run `Energy_Landscape_permutation.m` to calculate the ND values for the four discrepancy measures. The key functions used in this code and the sample datasets are same as used in [the Conventional folder](https://github.com/pitambarkhanra/energy_landscape_analysis/tree/main/Conventional)

# Input
- Number of ROIs, set in line 2 in `Energy_landscape_permutation.m`.
- List of participants, set in line 3 in the same file.
- List of sessions, set in line 5 in the same file.
- Threshold (i.e., $\mu' + 2\sigma'$ in subsection $2.7.2$ in Khanra *et al.* (2023)) to choose significant local minima, set in line 7 in the same file.
- Name of the binarized multi-variate time series [NM: Is this what you mean? I added "multi-variate time series] data file, set in lines 16.

# Output
- ``ND_values.mat`` contains the four ND values as follows:
    - **ND_Interaction_strength** contains the ND value for the discrepancy measure $d_J$.
    - **ND_Hamming_dist** contains the ND value for the discrepancy measure $d_H$.
    - **ND_Cosine_dist** contains the ND value for the discrepancy measure $d_\rm{basin}$.
    - **ND_nbld** contains the ND value for the discrepancy measure $d_L$.
 
[NM: ND values are not enough right? We need output of the permutation test. Because some people definitely want to see the ND values for each permutation run, if there are 10000 randomized runs (the number of randomized runs should also be specified as input above), the output should be 10000 ND values, plus the p value as well as the ND value for the original data. And the code to do this should be included in this folder.]

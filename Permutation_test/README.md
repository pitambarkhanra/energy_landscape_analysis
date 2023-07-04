# Permutation test for the energy landscape analysis by the conventional likelihood maximization method

When you use the code provided here, please cite the following paper:

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573](https://arxiv.org/abs/2305.19573)

# What is this repository?

The codes in this folder provides the MATLAB codes [NM: Please eradicate the term "key" from this readme. The point is that we are not sketching the usage of this code, but we need to tell precisely how to use the code.][PK: I have changed the line] to perform the permutation test for the energy landscape analysis on multi-variate time series data such as fMRI data using the conventional gradient-ascent algorithm to maximize the likelihood estimation and to estimate the parameter values. The code in this folder estimates the ND value for the four discrepancy measures proposed in Khanra *et al.* (2023) for all the permutations.

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
- Number of permutations, set in line 9 in the same file.
- Name of the binarized multi-variate time series [NM: Is this what you mean? I added "multi-variate time series][PK: Yes, it is. But is it necessary? Because in the conventional folder we have not mentioned this term.] data file, set in lines 16.

# Output
- ``permutation_results.mat`` contains the four ND values for all the permutation run and the corresponding p-values as follows:
    - **ND_Interaction_strength** contains the vector of ND values for the discrepancy measure $d_J$.
    - **ND_Hamming_dist** contains the vector of ND values for the discrepancy measure $d_H$.
    - **ND_Cosine_dist** contains the vector of ND values for the discrepancy measure $d_\rm{basin}$.
    - **ND_nbld** contains the vector of ND values for the discrepancy measure $d_L$.
    - **p_values** contains the four p-values corresponding to the four discrepancy measures $d_J$, $d_H$, $d_\rm{basin}$, and $d_L$ respectively
 
[NM: ND values are not enough right? We need output of the permutation test. Because some people definitely want to see the ND values for each permutation run, if there are 10000 randomized runs (the number of randomized runs should also be specified as input above), the output should be 10000 ND values, plus the p value as well as the ND value for the original data. And the code to do this should be included in this folder.]

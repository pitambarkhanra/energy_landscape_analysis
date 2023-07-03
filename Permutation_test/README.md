# Permutation test for the energy landscape analysis by the conventional likelihood maximization method

When you use the code provided here, please cite the following paper:

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573](https://arxiv.org/abs/2305.19573)

# What is this repository?

The code in this folder provides the MATLAB code of key functions to perform the permutation test for the energy landscape analysis on multi-variate time series data like fMRI data using the conventional gradient-ascent algorithm to maximize the likelihood estimation and to estimate the parameter values. The code in this folder estimates the ND value for the four discrepancy measures proposed in Khanra *et al.* (2023).

# Required software and packages:

- MATLAB2020 or later
- MATLAB Statistics and Machine Learning Toolbox

# How to use the code?

We provide the MATLAB codes and key functions for example analysis and to calculate the ND values for the four discrepancy measures proposed in the above mentioned article.

To start with, run `Energy_Landscape_permutation.m` to calculate the ND values for the four discrepancy measures. The key functions used in this code and the sample datasets are same as used in [the Conventional folder](https://github.com/pitambarkhanra/energy_landscape_analysis/tree/main/Conventional)

# Input:
- Number of ROIs, set in line 2 in `Energy_landscape_permutation.m`.
- List of participants, set in line 3 of the same file.
- List of sessions, set in line 5 of the same file.
- Threshold (i.e., $\mu' + 2\sigma'$ in subsection $2.7.2$ in Khanra *et al.* (2023)) to choose significant local minima, set in line 7 of the same file.
- Name of the binarized data file, set in lines 16.

# Output:
- "ND_values.mat" contains the four ND value as follows:
    - "ND_Interaction_strength": contains the ND value for the discrepancy measure $d_J$.
    - "ND_Hamming_dist"; contains the ND value for the discrepancy measure $d_H$.
    - "ND_Cosine_dist": contains the ND value for the discrepancy measure $d_\rm{basin}$.
    - "ND_nbld": contains the ND value for the discrepancy measure $d_L$.

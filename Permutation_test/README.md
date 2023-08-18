# Permutation test for the energy landscape analysis by the conventional likelihood maximization method

When you use the code provided here, please cite the following paper:

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573](https://arxiv.org/abs/2305.19573)

# What is this repository?

This folder provides MATLAB codes to perform the permutation test for the energy landscape analysis on multi-variate time series data such as fMRI data. The estimation of the parameter values for the Ising model is done using the conventional gradient-ascent algorithm to maximize the likelihood. The code in this folder estimates the ND value for the four discrepancy measures proposed in Khanra *et al.* (2023) for all the permutations.

# Required software and packages

- MATLAB2020 or later
- MATLAB Statistics and Machine Learning Toolbox
- You also need to download the Conventional folder in this respository and place it in the same level as the present folder.

# How to use the code?

We provide the MATLAB codes and key functions for example analysis and to calculate the ND values for the four discrepancy measures proposed in the above mentioned article.

To start with, run `Energy_Landscape_permutation.m` to calculate the ND values for the four discrepancy measures. The key functions used in this code and the sample datasets are same as used in [the Conventional folder](https://github.com/pitambarkhanra/energy_landscape_analysis/tree/main/Conventional)

# Input
In sum, the main input is the binarized multi-variate time series for some participants and for some sessions per participant.
- Name of the binarized multi-variate time series data files, set in lines 17 in `Energy_landscape_permutation.m`.
- Number of ROIs, set in line 2 in the same file.
- List of participants, set in line 3 in the same file.
- List of sessions, set in line 5 in the same file.
- Threshold (i.e., $\mu' + 2\sigma'$ in subsection $2.7.2$ in Khanra *et al.* (2023)) to choose significant local minima, set in line 7 in the same file.
- Number of permutations, set in line 8 in the same file.
- In line 9 load the `ND_values.mat` file generated from the [the Conventional folder](https://github.com/pitambarkhanra/energy_landscape_analysis/tree/main/Conventional)

# Output
- The output is saved in ``permutation_results.mat``. ``permutation_results.mat`` contains the four ND values for all the permutation runs and the corresponding p-values as follows:
    - **NDper_Interaction_strength** contains the ND values for the discrepancy measure $d_\text{J}$ for all the permutation runs.
    - **NDper_Hamming_dist** contains the ND values for the discrepancy measure $d_H$ for all the permutation runs.
    - **NDper_Cosine_dist** contains the ND values for the discrepancy measure $d_\rm{basin}$ for all the permutation runs.
    - **NDper_nbld** contains the ND values for the discrepancy measure $d_L$ for all the permutation runs.
    - **p_values** contains the four p-values, each corresponding to $d_J$, $d_H$, $d_\rm{basin}$, and $d_L$ respectively

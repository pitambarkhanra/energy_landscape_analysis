When you use the code provided here, please cite the following paper:

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573](https://arxiv.org/abs/2305.19573)

# What is this repository?

This repository provides the MATLAB code of key functions to perform the energy landscape analysis on multi-variate time series data like fMRI data using the conventional gradient-ascent algorithm to maximize the likelihood. [NM: vague given below regarding what "energy landscape analysis" means. For example calculation of dJ is in a sense not energy landscape analysis. Does this repository include the code to estimate the parameters hi and Jij? ND? permutation test? If not, specify what it does calculate. We are getting too late; reviewers looking at the repository incomplete is a VERY bad sign and gives them a reason to have a bad impression about the paper.]

# Required software:

- MATLAB2020 [NM: They always have versions 2020a and 2020b, for example. There is no version 'MATLAB2020'? Be precise please, as the version is a unique name.] or a later version
- MATLAB Statistics and Machine Learning Toolbox.

# How to use the code?

Since it is difficult to creat a general code which can performs energy landscape analysis for any arbitrary data, we provide the MATLAB codes and key functions for example analysis and to calculate the four discrepancy measures proposed in the above mentioned article.

To start with: Run **Energy_landscape_analysis.m** to calculate the four discrepancy measures. The key functions used in this code are as follows:

- **main.m**: This function estimates the maximum entropy distribution using the maximum likelihood method. This is a modified version of the code developed by T. Ezaki. For more details about his code and related functions, please refer to [his Github repository](https://github.com/tkEzaki/energy-landscape-analysis).

- **branch_index.m**: This function calculates the index for the significant local minima calculated for an energy landscape with a given threshold (see subsection $2.7.2$ in Khanra *et al.* (2023)). Also it can calculate the sum of the branch length for all the significant local minima.

- **Hamming_Distance.m**: This function calculates the hamming distance between the activity pattern of two energy landscapes. "index1" denotes the index of significant local minima calculated for the first energy landscape and "index2" denotes the index of significant local minima calculated for the second energy landscape. (see subsection $2.7.2$ and Eq. $(23)$ for the theoretical procedure)

- **Cosine_distance.m**: This function calculates the cosine distance between the averaged activity pattern over the attractive basin corresponding to two energy landscapes. "BasinGraph1" indicates the basin graph for the first energy landscape and "BasinGraph2" indicates the basin graph for the second energy landscape. (see subsection $2.7.3$ in the above article)

# Sample dataset:

Example usage of **Energy_landscape_analysis.m** with dummy data sets named "SampleData_Binarized_Subject_i_Session_j.mat" which contains 7 ROIs and 1000 time points. 
i=1,2 denotes the participants and j=1,2 denotes the sessions.

# Input:
- Number of ROIs in line 2 [NM: of which file?]
- Participants list in line 3
- Session list in line 4
- Threshold to choose significant local minima in line 5

# Output:
[NM: Should output the inferred parameter values as well, right?]
- "d1_\*" indicates the discrepancy measures calculated for within-participant comparison, and "d2_\*" indicates the same for between-participant comparison. [NM: pairwise MEM Estimation algorithm and test-retest algorithm should be separeted completely. For example, it is entirely possible to estimate the pairwise MEM by the Bayesian method (not by likelihood maximization) and then turn to part of (?) this code to conduct test-retest reliability analysis.]
- "\*_Interaction_strength": indicates the discrepancy measure xxx [NM: use the math symbols assigned to this variable here (please italicize as appropriate. Is there a way to use the math mode of latex with markdown?) rather than mentioning the section number] defined in Khanra et al. (2023) [NM: Similarly modify the next three ones as well.].
- "\*_Hamming_dist":  indicates the discrepancy measure described in subsection $2.7.2$ of the article Khanra *et al.* 2023.
- "\*_Cosine_dist": indicates the discrepancy measure described in subsection $2.7.3$ of the article Khanra *et al.* 2023.
- "\*_nbld": indicates the discrepancy measure described in subsection $2.7.4$ of the article Khanra *et al.* 2023.    
Here "\*" denotes "d1/d2".

# When you use the code provided here, please cite the following paper:

"P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573", https://arxiv.org/pdf/2305.19573.pdf

# What is this repository?
This repository gives you the MATLAB code of key functions to perform the energy landscape analysis on multi-variate time series data like fMRI data using the pairwise maximum entropy model (i.e., Ising model) inferred by the conventional gradient-ascent algorithm.

# Software:
- MATLAB2020 or later versions $+$ MATLAB Statistics and Machine Learning Toolbox.

# How to use?
Since it is difficult to creat a general code which can performs energy landscape analysis for any arbitrary data, we provide the MATLAB codes and key functions for example analysis and to calculate the four discrepancy measures proposed in the above mentioned article.

To start with: Run **Energy_landscape_analysis.m** to calculate the four discrepancy measures. The key functions used in this code are as follows:

- **main.m**: This function estimates the maximum entropy distribution using the maximum likelihood method. This is a modified version of the code developed by T. Ezaki. For more details about this program and the related functions used in this program please refer to the github repository "https://github.com/tkEzaki/energy-landscape-analysis".

- **branch_index.m**: This function calculates the index for the significant local minima calculated for an energy landscape with a given threshold (see subsection $2.7.2$ in Khanra *et al.* (2023)). Also it can calculate the sum of the branch length for all the significant local minima.

- **Hamming_Distance.m**: This function calculates the hamming distance between the activity pattern of two energy landscapes. "index1" denotes the index of significant local minima calculated for the first energy landscape and "index2" denotes the index of significant local minima calculated for the second energy landscape. (see subsection $2.7.2$ and Eq. $(23)$ for the theoretical procedure)

- **Cosine_distance.m**: This function calculates the cosine distance between the averaged activity pattern over the attractive basin corresponding to two energy landscapes. "BasinGraph1" indicates the basin graph for the first energy landscape and "BasinGraph2" indicates the basin graph for the second energy landscape. (see subsection $2.7.3$ in the above article)

# Sample dataset:
Example usage of **Energy_landscape_analysis.m** with dummy data sets named "SampleData_Binarized_Subject_i_Session_j.mat" which contains 7 ROIs and 1000 time points. 
i=1,2 denotes the participants and j=1,2 denotes the sessions.

# Input:
- No of ROIs in line 2
- Participants list in line 3
- Session list in line 4
- Threshold to choose significant local minima in line 5

# Output:
- "d1_*" indicates the discrepancy measures calculated for within participants and "d2_*" indicates the same for between participants.
- "*_Interaction_strength": indicates the discrepancy measure described in subsection $2.7.1$ of the article Khanra *et al.* 2023.
- "*_Hamming_dist":  indicates the discrepancy measure described in subsection $2.7.2$ of the article Khanra *et al.* 2023.
- "*_Cosine_dist": indicates the discrepancy measure described in subsection $2.7.3$ of the article Khanra *et al.* 2023.
- "*_nbld": indicates the discrepancy measure described in subsection $2.7.4$ of the article Khanra *et al.* 2023. \n
Here "\*" denotes "d1/d2".

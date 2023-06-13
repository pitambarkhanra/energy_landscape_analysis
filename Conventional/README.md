When you use the code provided here, please cite the following paper:

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573](https://arxiv.org/abs/2305.19573)

# What is this repository?

This repository provides the MATLAB code of key functions to perform the energy landscape analysis on multi-variate time series data like fMRI data using the conventional gradient-ascent algorithm to maximize the likelihood estimation and to estimate the parameter values. Also this repository will estimate the four discrepancy measures proposed in Khanra *et al.* (2023). [NM: vague given below regarding what "energy landscape analysis" means. For example calculation of dJ is in a sense not energy landscape analysis. Does this repository include the code to estimate the parameters hi and Jij? ND? permutation test? If not, specify what it does calculate. We are getting too late; reviewers looking at the repository incomplete is a VERY bad sign and gives them a reason to have a bad impression about the paper.][PK: It will not calculate the ND and permutation test results. These are the basic codes to calculate energy landscape analysis, estimate the parameter values and estimate the discrepancy measures. In this code we are calculating d1 and d2. Users need to take the ratio only to calculate ND.]

# Required software and packages:

- MATLAB2020 [NM: They always have versions 2020a and 2020b, for example. There is no version 'MATLAB2020'? Be precise please, as the version is a unique name.][PK: What I have written here is a standard way to refer a MATLAB version. We can't refer specifically "a" or "b". Because MATLAB declairs "a" is a more stable version than "b". In other way you can say "b" is the pre-release version of "a". I have learned this things from Takahiro's repository and also other's page.] or later versions
- MATLAB Statistics and Machine Learning Toolbox

# How to use the code?

Since it is difficult to creat a general code which can performs energy landscape analysis for any arbitrary data, we provide the MATLAB codes and key functions for example analysis and to calculate the parameter values with the four discrepancy measures proposed in the above mentioned article.

To start with: Run **Energy_landscape_analysis.m** to calculate the parameter values and the four discrepancy measures. The key functions used in this code are as follows:

- `main.m`: This function estimates the maximum entropy distribution using the maximum likelihood method. This is a modified version of the code developed by Takahiro Ezaki. For more details about his code and related functions, please refer to [Takahiro's Github repository](https://github.com/tkEzaki/energy-landscape-analysis).

- `branch_index.m`: This function calculates the index for the significant local minima calculated for an energy landscape with a given threshold [NM: As I wrote below, I do not understand what threshold you are meaning.] (to discard the insignificant local minima. See subsection $2.7.2$ in Khanra *et al.* (2023) for details about the threshold $\mu'+2\sigma'$). This function [NM: "can" means what? It "does" calculate it always? Or it "can" calculate by setting an option or something like that?][PK: It will always calculate. I have changed the term.] also calculates the sum of the branch length ("tbl") for all the significant local minima.

- `Hamming_Distance.m`: This function calculates the Hamming distance between the activity patterns of two energy landscapes. "index1" denotes the index of significant local minima calculated for the first energy landscape and "index2" denotes the index of significant local minima calculated for the second energy landscape [NM: Do index1 and index2 have to come from two different energy landscapes?][PK: Yes, it is.]. (see subsection $2.7.2$ and Eq. $(23)$).

- `Cosine_distance.m`: This function calculates the cosine distance between the averaged activity pattern over the attractive basin corresponding to two energy landscapes. "BasinGraph1" indicates the basin graph [NM: We do not have a notion of "basin graph" anywhere in the paper and I do not understand this notion either.] [PK: I have changed the writing to make it clear.] for the first energy landscape and "BasinGraph2" indicates the basin graph for the second energy landscape. (see subsection $2.7.3$ in the above article for explanation about cosine distance and see "Takahiro's Github repository" for the structure of basin graph).

# Sample dataset:

Example usage of `Energy_landscape_analysis.m` with [NM: Vague. How to run this .m file? Without argument? What does "with dummy data sets" mean?][PK: For the dummy dataset which we have provided, all the input is already in the .m file. just need to run the file to calculate the parameter value and the discrepany measures] the binarized dummy data sets named `SampleData_Binarized_Subject_i_Session_j.mat` which contains 7 ROIs and 1000 time points. 
i=1,2 denotes the participants, and j=1,2 denotes the sessions.

# Input:
- Number of ROIs in line 2 in `Energy_landscape_analysis.m`. [NM: of which file?]
- List of participants in line 3 of the same file.
- List of sessions in line 4 of the same file.
- Threshold ($\mu' + 2\sigma'$, see subsection $2.7.2$ in Khanra *et al.* (2023)) to choose significant local minima in line 5 of the same file[NM: We do not have such a parameter in the paper. What does this "threshold" mean? I am totally confused.][PK:  have changed the writing].
- Change the binarized data file name in line 19 and 56.

# Output:
[NM: Should output the inferred parameter values as well, right?][PK: Yes, you are right. I have included.]
- "h_L_i_j.mat" and "J_L_i_j.mat" gives the fitting parameter and pairwise interaction parameters values respectively for the "i-th" participant and "j-th" session.
- "d1_\*" indicates the discrepancy measures calculated for within-participant comparison, and "d2_\*" indicates the same for between-participant comparison. [NM: pairwise MEM Estimation algorithm and test-retest algorithm should be separeted completely. For example, it is entirely possible to estimate the pairwise MEM by the Bayesian method (not by likelihood maximization) and then turn to part of (?) this code to conduct test-retest reliability analysis.][PK: This code will only calculate the parameter value and all the four discrepancy measures for the original data only. For the permutation test just to do the permutation with the data and run the same analysis with these codes. Should we provide a separate code for this also?]. Here "\*" denotes the four discrepancy measures given below:
- "Interaction_strength": indicates the discrepancy measure $d_J$ [NM: use the math symbols assigned to this variable here (please italicize as appropriate. Is there a way to use the math mode of latex with markdown?) rather than mentioning the section number][PK: Done. For the mathmode I will check it later] defined in Khanra et al. (2023) [NM: Similarly modify the next three ones as well.].
- "Hamming_dist":  indicates the discrepancy measure $d_H$ defined in Khanra *et al.* 2023.
- "Cosine_dist": indicates the discrepancy measure $d_\rm{basin}$ defined in Khanra *et al.* 2023.
- "nbld": indicates the discrepancy measure $d_L$ defined in Khanra *et al.* 2023.    
Here "\*" denotes "d1/d2". [NM: This should be wrong because the first line then would be d1_d1 or d1_d2. What is going on?][PK: This line was not correct. it should be deleted.]

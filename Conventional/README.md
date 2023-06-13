# Energy landscape analysis by the conventional likelihood maximization method

When you use the code provided here, please cite the following paper:

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573](https://arxiv.org/abs/2305.19573)

# What is this repository?

The code in this folder provides the MATLAB code of key functions to perform the energy landscape analysis on multi-variate time series data like fMRI data using the conventional gradient-ascent algorithm to maximize the likelihood estimation and to estimate the parameter values. Also this repository will estimate the four discrepancy measures proposed in Khanra *et al.* (2023).[PK: It will not calculate the ND and permutation test results. These are the basic codes to calculate energy landscape analysis, estimate the parameter values and estimate the discrepancy measures. In this code we are calculating d1 and d2. Users need to take the ratio only to calculate ND.] [NM: But users do not want to take the ratio themselves. Don't make them work. We need to work.][PK: I have updated the code and also the output section here]

# Required software and packages:

- MATLAB2020 or later
- MATLAB Statistics and Machine Learning Toolbox

# How to use the code?

Because it is difficult to creat a general code which can performs energy landscape analysis for any arbitrary data, we provide the MATLAB codes and key functions for example analysis and to calculate the parameter values with the four discrepancy measures proposed in the above mentioned article.

To start with, run `Energy_landscape_analysis.m` to calculate the parameter values and the four discrepancy measures. The key functions used in this code are as follows:

- `main.m`: This function estimates the maximum entropy distribution using the maximum likelihood method. This is a modified version of the code developed by Takahiro Ezaki. For more details about his code and related functions, please refer to [Takahiro's Github repository](https://github.com/tkEzaki/energy-landscape-analysis).

- `branch_index.m`: This function calculates the index [NM: What does "index" mean?] for the significant local minima calculated for an energy landscape with a given threshold (i.e., $\mu'+2\sigma'$ to discard the insignificant local minima; see subsection $2.7.2$ in the aforementioned paper for details about the threshold). This function also calculates the sum of the branch length ("tbl") for all the significant local minima.

- `Hamming_Distance.m`: This function calculates the Hamming distance between the activity patterns of two energy landscapes. "index1" denotes the index of significant local minima calculated for the first energy landscape and "index2" denotes the index of significant local minima calculated for the second energy landscape. The local minima corresponding to "index1" and those corresponding to "index2" have to come from two different energy landscapes. (see subsection $2.7.2$ and Eq. (23)).

- `Cosine_distance.m`: This function calculates the cosine distance between the averaged activity pattern over the attractive basin corresponding to two energy landscapes. "BasinGraph1" indicates the BasinGraph [NM: We do not have a notion of "basin graph" anywhere in the paper and I do not understand this notion either.] [PK: I have changed the writing to make it clear.] [NM: I do not see "basin graph" explained.] for the first energy landscape and "BasinGraph2" indicates the BasinGraph for the second energy landscape. See subsection $2.7.3$ in the above article for explanation about cosine distance and see [Takahiro's Github repository](https://github.com/tkEzaki/energy-landscape-analysis) for the structure of the BasinGraph ( This is a $2^N \times 3$ matrix. Where the first column is the state number, and the third column is the local minimum state that the state belongs to. The second column shows the neighboring state that has the minimum energy value). [NM: Very minimum of basin graph should be explained self-consteitntly on this page. Or avoid this term.][PK: explained]

# Sample dataset:

We provide four binarized dummy data files named `SampleData_Binarized_Subject_i_Session_j.mat`, [NM: Subject is an unacceptable language nowadays. So, including the code, please replace Subject(s)/subject(s) by Participant(s)/participant(s).] each of which contains 7 ROIs and 1000 time points.  $i=1,2$ [NM: Fix the dollar mark throughout please.] [NM: As always, i and j must be italicized.] denotes the participants, and $j=1,2$ denotes the sessions.
If you run `Energy_landscape_analysis.m`, it reads these .mat files and run the analysis. If you want to run the analysis with different data sets, you only need to replace the data file name in line 19 and 56 in `Energy_landscape_analysis.m`.

# Input:
- Number of ROIs, set in line 2 in `Energy_landscape_analysis.m`.
- List of participants, set in line 3 of the same file.
- List of sessions, set in line 4 of the same file.
- Threshold (i.e., $\mu' + 2\sigma'$ in subsection $2.7.2$ in Khanra *et al.* (2023)) to choose significant local minima, set in line 5 of the same file.
- Name of the binarized data file, set in lines 19 and 56.

# Output:
- "h_L_i_j.mat" contains the estimated $[h_1, \ldots, h_N]$ values for the $j$ th [NM: Can you fix this dollar mark? I don't know when it is automatically converted to latex math and when it is not. Also in other places.][PK: I have changed the other places, but here it should not be in dollar sign, otherwise it will not match with the file name.] [NM: Dollar sign means math mode. dollar j dollar means italic j in latex. This is what I need. I am saying i and j must be italic. Yes they must.] session from the $i$ th participant. [NM: Confusing because the conventional method, which this folder is about, only estimates one energy landscape for the set of sessions, right? The Bayesian does estimate hi and Jij for each participant and each session, but Bayesian is the other folder.][PK: No, conventional method in this folder also estimates hi and Jij for all the participants and sessions. Suppose here are 2 participants and 2 sessions in the sample data. So there will be four hi file as "h_L_1_1.mat", "h_L_1_2.mat", "h_L_2_1.mat" and "h_L_2_2,mat" and same for the Jij files. If you run the code `Energy_landscape_analysis.m`, all the things will be done.] [NM: I should say  you need to rewrite code for users. Otherwise, nobody except you can really use the code. If the code takes multiple .mat files as input, then it should output just one energy landscape for the concatenated data. If it is given just one .mat file as input, then it should return just one energy landscape. This is the most natural and intutiive, right?] 
- "J_L_i_j.mat" contains the estimated $[J_{12}, J_{13}, \ldots, J_{(N-1),N}]$ values for the $j$ th session from the $i$ th participant.
- "d1_\*" [NM: Is this the output file name? If so, please replace "indicates" by "contains" and same for other instances below.] contains the discrepancy measures calculated for within-participant comparison, and "d2_\*" contains the same for between-participant comparison. [NM: pairwise MEM Estimation algorithm and test-retest algorithm should be separeted completely. For example, it is entirely possible to estimate the pairwise MEM by the Bayesian method (not by likelihood maximization) and then turn to part of (?) this code to conduct test-retest reliability analysis.][PK: This code will only calculate the parameter value and all the four discrepancy measures for the original data only. For the permutation test just to do the permutation with the data and run the same analysis with these codes. Should we provide a separate code for this also?] [NM: Eventually yes, but let's prioritize all other parts for now.]. Here "\*" denotes the four discrepancy measures defined in Khanra * et al.* 2023 as follows:
    - "Interaction_strength": indicates the discrepancy measure $d_J$ [PK: Done. For the mathmode I will check it later].
    - "Hamming_dist":  indicates the discrepancy measure $d_H$.
    - "Cosine_dist": indicates the discrepancy measure $d_\rm{basin}$.
    - "nbld": indicates the discrepancy measure $d_L$.
- "Discrepancy.mat" contains the four ND value as follows:
    - "ND_Interaction_strength": contains the ND value for the discrepancy measure $d_J$.
    - "ND_Hamming_dist"; contains the ND value for the discrepancy measure $d_H$.
    - "ND_Cosine_dist": contains the ND value for the discrepancy measure $d_\rm{basin}$.
    - "ND_nbld": contains the ND value for the discrepancy measure $d_L$.

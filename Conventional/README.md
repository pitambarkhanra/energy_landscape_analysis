# Energy landscape analysis by the conventional likelihood maximization method

When you use the code provided here, please cite the following paper:

[P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, European Journal of Neuroscience, 60, 4265-4290 (2024)](https://doi.org/10.1111/ejn.16390)

# What is this repository?

The code in this folder provides the MATLAB code of key functions to perform the energy landscape analysis on multi-variate time series data like fMRI data using the conventional gradient-ascent algorithm to maximize the likelihood estimation and to estimate the parameter values. The code in this folder estimates the four discrepancy measures proposed in Khanra *et al.* (2024).

# Required software and packages:

- MATLAB2020 or later
- MATLAB Statistics and Machine Learning Toolbox

# How to use the code?

We provide the MATLAB codes and key functions for example analysis and to calculate the parameter values with the four discrepancy measures proposed in the above mentioned article.

Run `Energy_landscape_analysis.m` to calculate the parameter values and the four discrepancy measures. The key functions used in this code are as follows:

- `main.m`: This function estimates the parameter of the Ising model using the maximum likelihood method. This is a modification of the code developed by Takahiro Ezaki. For more details about his code and related functions, please refer to [Takahiro's Github repository](https://github.com/tkEzaki/energy-landscape-analysis).

- `branch_index.m`: This function calculates the significant local minimum activity patterns, stored in the variable "index" which is calculated for an energy landscape with a given threshold (i.e., $\mu'+2\sigma'$ to discard the insignificant local minima; see subsection $2.7.2$ in the aforementioned paper for details about the threshold). This function also calculates the sum of the branch length ("tbl") over all the significant local minima.

- `Hamming_Distance.m`: This function calculates the Hamming distance between the activity patterns of two energy landscapes. "index1" denotes the index of significant local minima calculated for the first energy landscape and "index2" denotes the index of significant local minima calculated for the second energy landscape. The local minima corresponding to "index1" and those corresponding to "index2" have to come from two different energy landscapes. (see subsection $2.7.2$ and Eq. (23)).

- `Cosine_distance.m`: This function calculates the cosine distance between the averaged activity pattern over the attractive basin corresponding to two energy landscapes. It takes **BasinGraph1** and **BasinGraph2** as two key inputs. "BasinGraph1" indicates the BasinGraph for the first energy landscape and "BasinGraph2" indicates the BasinGraph for the second energy landscape. BasinGraph is a $2^N \times 3$ matrix, where the first column represents the activity pattern's ID, ranging from 1 to $2^N$, the second column represents the neighboring state that has the minimum energy value, and the third column represents the local minimum state that the state in the first column belongs to. See subsection $2.7.3$ in the above article for the distance, and see [Takahiro's Github repository](https://github.com/tkEzaki/energy-landscape-analysis) for the structure of the BasinGraph.

# Sample dataset:

We provide four binarized dummy data files named `SampleData_Binarized_Participant_i_Session_j.mat`, each of which contains 7 ROIs and 1000 time points.  $i=1,2$ denotes the participants, and $j=1,2$ denotes the sessions.
If you run `Energy_landscape_analysis.m`, it reads these .mat files and run the analysis. If you want to run the analysis with different data sets, you only need to replace the data file name in line 19 and 56 in `Energy_landscape_analysis.m`.

# Input:
- Number of ROIs, set in line 2 in `Energy_landscape_analysis.m`.
- List of participants, set in line 3 of the same file.
- List of sessions, set in line 4 of the same file.
- Threshold (i.e., $\mu' + 2\sigma'$ in subsection $2.7.2$ in Khanra *et al.* (2023)) to choose significant local minima, set in line 5 of the same file.
- Name of the binarized data file, set in lines 19 and 56.

# Output:
- "h_L_i_j.mat" contains the estimated $[h_1, \ldots, h_N]$ values for the $j$th session from the $i$ th participant. For example, if we have 2 participants and 2 sessions and feed four input files to run `Energy_landscape_analysis.m`, then we will obtain "h_L_1_1.mat", "h_L_1_2.mat", "h_L_2_1.mat", and "h_L_2_2,mat". More often than not, we want to estimate energy landscapes for concatenated data (i.e., concatenated across different sessions and/or participants). In this case, if you want to estimate one energy landscape for the data concatenated over multiple participants (one session per participant), you simply need to pretend $i=j=1$ and feed the concatenated data to `Energy_landscape_analysis.m`.
- "J_L_i_j.mat" contains the estimated $[J_{11}, J_{12}, \ldots, J_{1,N};J_{21}, J_{22}, \ldots, J_{2,N}; \ldots ;J_{N,1},J_{N,2}, \ldots , J_{N,N}]$ values for the $j$ th session from the $i$ th participant.
- "d1_\*" contains the discrepancy measures calculated for within-participant comparison, and "d2_\*" contains the same for between-participant comparison. Here "\*" denotes the four discrepancy measures defined in Khanra * et al.* 2023 as follows:
    - "Interaction_strength": indicates the discrepancy measure $d_J$.
    - "Hamming_dist":  indicates the discrepancy measure $d_H$.
    - "Cosine_dist": indicates the discrepancy measure $d_\rm{basin}$.
    - "nbld": indicates the discrepancy measure $d_L$.
- "ND_values.mat" contains the four ND value as follows:
    - "ND_Interaction_strength": contains the ND value for the discrepancy measure $d_J$.
    - "ND_Hamming_dist"; contains the ND value for the discrepancy measure $d_H$.
    - "ND_Cosine_dist": contains the ND value for the discrepancy measure $d_\rm{basin}$.
    - "ND_nbld": contains the ND value for the discrepancy measure $d_L$.

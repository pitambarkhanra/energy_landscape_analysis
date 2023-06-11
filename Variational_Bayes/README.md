[NM: Change the folder's name to be consistent with Readme on the top page.] [PK: Done]

# When you use the code provided here, please cite the following two papers:

"S.-O. Jeong, J. Kang, C. Pae, J. Eo, S. M. Park, J. Son, H.-J. Park, Empirical bayes estimation of pairwise maximum entropy model for nonlinear brain state dynamics, NeuroImage 244 (2021) 118618", https://doi.org/10.1016/j.neuroimage.2021.118618 [NM: Also embed the hyperlink to their paper using https://doi.org/xxx format.][PK: Done]

"P. Khanra, J. Nakuci, S. Muldoon, T. Watanabe, N. Masuda, Reliability of energy landscape analysis of resting-state functional MRI data, arXiv preprint arXiv:2305.19573", https://arxiv.org/pdf/2305.19573.pdf
[NM: Also our arxiv paper here.] [PK: Done]

# What is this repository?
This code gives you the parameter value for the energy landscape analysis of fMRI data using variational Bayes approximation method.

[NM: Show usage example in command line format. Also, format it very well, by mimicking other examples on github.]
# Software and packages:
- RStudio or any compatible software to run R language $+$ *R.matlab package and *tidyr package

# How to use?
open RStudio and run the file "Bayesian_main.R"

Bayesian_main.R: main function to calculate the parameter value for the energy landscape analysis, which uses the  function VEM.Boltzmann: function to calculate the parameter value using variational Bayes approximation method which comes from the source code VEM.R

[NM: Also, make section (?) to state dependency more neatly, by mimicking others. This readme should have sections, like Usage, Depenedency etc. (but the section headings should follow a standard convention, too, if Usage, Dependency etc. are not really good section headings. Observe good examples, please. People should just type the commands you provide here with a sample dummy data set to be able to get the results. Then, they will use that.] [PK: What I have written now is sufficient to run the code. Rest of the things are written in the code itself (I have explained each line separately in the code)]

[NM: Also be explicit in what the input is and what the output is.]
# Sample dataset:
Contains example usage of "Bayesian_main.R" with dummy data named "Sample_data.mat" which contains the concatenated dataset for 4 participants and 1000 time points in each subject. [NM: Change this 818 to something like e.g. 1000. This is dummy data, right? It should be. We cannot upload real data or modified real data because they do not belong to us.] [PK: Done]

# Input:
-- No of dataset in line 5 in the main function "Bayesian_main.R"
-- Length of time series for each dataset in line 9.
-- Read the concatenated data file in ".mat" format in line 8.

#Output:
-- "h_J_value.mat" which contains the parameter values, where each row corresponds to a participant in the format [h_1,h_2,...,h_N,J_12,J_13,J_(N-1),N]


[NM: By the way, in the top folder, you say two folders, but the "Conventional" folder is missing.][PK: Done]
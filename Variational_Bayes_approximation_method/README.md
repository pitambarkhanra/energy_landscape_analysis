# Variational Bayes approximation method

[NM: Change the folder's name to be consistent with Readme on the top page.]

When you use the code provided here, please cite the following two papers:

"S.-O. Jeong, J. Kang, C. Pae, J. Eo, S. M. Park, J. Son, H.-J. Park, Empirical bayes estimation of pairwise maximum entropy model for nonlinear brain state dynamics, NeuroImage 244 (2021) 118618"
[NM: Also embed the hyperlink to their paper using https://doi.org/xxx format.]

[NM: Also our arxiv paper here.]

--This code gives you the parameter value for the energy landscape analysis of fMRI data using variational Bayes approximation method.

[NM: Show usage example in command line format. Also, format it very well, by mimicking other examples on github.]

`Bayesian_main.R`: main function to calculate the parameter value for the energy landscape analysis, which uses the following function
`VEM.Boltzmann`: function to calculate the parameter value using variational Bayes approximation method which comes from the source code `VEM.R`

[NM: Also, make section (?) to state dependency more neatly, by mimicking others. This readme should have sections, like Usage, Depenedency etc. (but the section headings should follow a standard convention, too, if Usage, Dependency etc. are not really good section headings. Observe good examples, please. People should just type the commands you provide here with a sample dummy data set to be able to get the results. Then, they will use that.]

[NM: Also be explicit in what the input is and what the output is.]

Rstudio needs to be installed to run the code with the following dependencies:

*R.matlab package
*tidyr package


Contains example usage of `Bayesian_main.R` with dummy data named 'Sample_data.mat' which contains 80 participants and 818 time points in each subject. [NM: Change this 818 to something like e.g. 1000. This is dummy data, right? It should be. We cannot upload real data or modified real data because they do not belong to us.]

[NM: By the way, in the top folder, you say two folders, but the "Conventional" folder is missing.]

*******************************************
*********LAB 7 – DIFFERENT TESTS***********
********Written by KC HARRIS **************
*******************************************
clear all
set more off
capt log close
local c_date = c(current_date)
local study "SP500"

log using "\\Client\C$\ISF_110\Lab 7\Log\ `study' -`c_date'.log", replace



// A common perception about COVID-19 is that Warm Climate is more resistant to the coronavirus outbreak and we need to verify this using Hypothesis Testing. So, what will our null and alternate hypothesis be?

// Null Hypothesis: Warm climates have no impact on the spread of coronavirus. Any increase is due to chance. 

// Alternate Hypothesis: 


use "\\Client\C$\ISF_110\Lab 7\Data\phdi_covid_temp_vita.dta"
gen temp_cat = 0 if temperature < 24
replace temp_cat = 1 if temperature >= 24

tab temp_cat

ztest total_cases, by(temp_cat)





// This t-test is designed to compare the means of the same variable between two groups. Using the “high school and beyond” dataset, we will test the following hypothesis: 

// “Female high school students do significantly better than male high school students on writing tests.”

// In the dataset, the students were randomly selected from a larger population of high school students. Although the sample size is larger than 30, we assume that variances for the two populations are the same. Perform the t-test using the following command and interpret your results: 




use https://stats.idre.ucla.edu/stat/stata/notes/hsb2, clear
ttest write, by(female)








// The following data (The Journal of Advertising, 1983, p. 34-42) are from a cross-sectional study that involved soliciting opinions on anti-smoking advertisements. Each subject was asked whether they smoked and their reaction (on a five-point ordinal scale) to the ad. The data are summarized as a two-way table of counts, given below:


// Is there any statistically significant correlation between the respondents being a smoker and their opinions about the anti-smoking ads? To answer this question, perform a chi-square test using the following command:

tabi 8 14 35 21  19 \ 31 42 78 61 69, chi2

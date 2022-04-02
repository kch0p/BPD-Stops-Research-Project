*******************************************
*******POVERTY AND INSECURITY IN SSA*******
********Written by Amm Quamruzzaman********
****************ISF110, LAB2***************
***Afrobarometer, Round 6 (2016) Dataset***
*******************************************

clear all
set more off
capt log close
local c_date = c(current_date)
local study "Afro_Lab2"

use "\\Client\C$\ISF_110\Lab 2\Data\lab2dataset.dta"
//, clear  //Copy and paste your data file location.

log using "C:\ISF_110\Lab 2\LOG `study' -`c_date'.log", replace  //We want to keep a log of our activities.

********************
*Generate variables*
********************

*First, have a "feel" of the data. Open the Data Editor and notice that country is alpha-numeric and its labels are in all-lowercase.
*Variable names are incomprehensible (e.g., q1, q2, etc.). We need to recode them - not all, but the ones we need for this lab.

*Activity 1: We will keep original variables and create new variables from them with new labels. 

*The following variables are often used as "control variables". We will recode them and get descriptive statistics in a table.

gen age = .  //This is one way to generate a new variable, first with all values as missing (.), then replacing the missing values with conditions.
replace age = q1 if q1 != -1 & q1 != 998 & q1 != 999  //This sign != means "not equal to".
label var age "Age of respondent"  //Give it a new label.
sum age  //See the range of age of the respondents.

gen sex = 1 if q101 == 2  //Female was 2, now it is 1. Recoded.
replace sex = 0 if q101 == 1  //Male was 1, now it is 0.
lab var sex "Gender of respondent, female = 1"
lab def sex 1 "Female" 0 "Male"
lab value sex sex
tab sex //See if you have created the variable correctly with the value lables. There is a difference between variable label and value label.

gen race = q102 if q102 != -1 //You need to do it. Assign it a label. For all variables that have incomplete codes, you will complete them.
replace race = 1 if q102 ==1
replace race = 2 if q102 ==2
replace race = 3 if q102 ==3
replace race = 4 if q102 ==4
replace race = 5 if q102 ==5
replace race = 6 if q102 ==6
replace race = 7 if q102 ==7
replace race = 7 if q102 ==99
label var race "Respondent's race, 1=Black/African, 2=White/European, 3=Colored/Mixed Race, 4=Arab/Lebanese/North African, 5=South Asian (Indian, Pakistani, etc.), 6=Eat Asian (Chinese, Korean, Indonesian, etc.), Other=95, -1=Missing"
label def race 1 "Black/African" 2 "White/European" 3 "Colored/Mixed" 4 "Arab/Lebanese/North" 5 "South Asian (Indian, Pakistani, etc.)," 6 "East Asian" 7 "Other"
label value race race 
tab race

gen edu q97 if inlist (q97, 0,1,2) & q97 != -1 !inlist(q97,-1,98)
replace edu = 1 if q97 == 1
replace edu = 2 if q97 == 2
replace edu = 3 if q97 == 3
replace edu = 4 if q97 == 4
replace edu = 5 if q97 == 5
replace edu = 6 if q97 == 6
replace edu = 7 if q97 == 7
replace edu = 8 if q97 == 8
replace edu = 9 if q97 == 9
label var edu "Education of respondent."
label def 0 "No formal schooling" 1 "Informal schooling only" 2 "Some primary schooling" 3 "Primary School Completed" 4 "Intermediate school or some secondary school / high school" 5 "Secondary school / high school completed" 6 "Post-secondary qualifications, other than university e.g. a diploma or degree from a polytechnic or college" 7 "Some university" 8 "University completed" 9 "Post-Graduate" 
label val edu edu
tab edu

gen employed = 0 if inlist(q96a,0,1,2)  //This is another way to set conditions. Use inlist if a new variable is created based on multiple conditions.
replace employed = 1 if inlist(q96a,3,4,5,6,7,8,9,10,11,12,95) & q96a != -1 & q96a != 998 & q96a != 9
label var employ "Employment status"
lab def employed 0 "Not currently employed" 1 "Currently employed"
lab val employed employed
tab employed

tab urbrur
gen urban = 1 if urbrur == 1  //Gen a new var with this label "urban"
replace urban = 0 if inlist(urbrur,2,3,4)
label var urban "Urban or rural PSU, urban = 1"
lab def urban 0 "Rural" 1 "Urban"
lab val urban urban

*Get the descriptive statistics of the control variables: age, sex, race, edu, employed, urban

sum age sex race edu employed urban

*Copy the table "as table" and paste it on an Excel/Google sheet. Format it as demonstrated.



*Activity 2: We will create a composite index for poverty based on the following variables: q8a - q8e.

tab1 q8a-q8e  //tab1 is a new command used to tabulate many variables at the same time. If the variables are a "series", we can use "-" sign to denote the range ("from - to"). 

gen wofood = 0 if inlist(q8a,0,9)
replace wofood = 1 if q8a == 1
replace wofood = 2 if q8a == 2
replace wofood = 3 if q8a == 3
replace wofood = 4 if q8a == 4
label var wofood "Gone without food"
label def wofood 0 "Never" 1 "Just once or twice" 2 "Several times" 3 "Many times" 4 "Always"
label val wofood wofood
tab wofood

gen wowater = 0 if inlist(q8b,0,9)
replace wowater = 1 if q8b == 1
replace wowater = 2 if q8b == 2
replace wowater = 3 if q8b == 3
replace wowater = 4 if q8b == 4
label var wowater "Gone without water"
label def wowater 0 "Never" 1 "Just once or twice" 2 "Several times" 3 "Many times" 4 "Always"
tab wowater

*Do the same for the following variables:

gen womedi = 0 if inlist(q8c,0,9)
replace womedi = 1 if q8c == 1
replace womedi = 2 if q8c == 2
replace womedi = 3 if q8c == 3
replace womedi = 4 if q8c == 4
label var womedi "Gone without medicine in last year"
label def womedi 0 "Never" 1 "Just once or twice" 2 "Several times" 3 "Many times" 4 "Always"
tab womedi

gen wofuel = 0 if inlist(q8d,0,9) 
replace wofuel = 1 if q8d == 1
replace wofuel = 2 if q8d == 2
replace wofuel = 3 if q8d == 3
replace wofuel = 4 if q8d == 4
label var wofuel "Gone without fuel for food in last year"
label def wofuel 0 "Never" 1 "Just once or twice" 2 "Several times" 3 "Many times" 4 "Always"
tab wofuel

gen woincome = 0 if inlist(q8e,0,9) 
replace woincome = 1 if q8e == 1
replace woincome = 2 if q8e == 2
replace woincome = 3 if q8e == 3
replace woincome = 4 if q8e == 4
label var woincome "Gone without income in last year"
label def woincome 0 "Never" 1 "Just once or twice" 2 "Several times" 3 "Many times" 4 "Always"
tab woincome

*Now, we will combine these variables using "egen" command. It will generate mean scores for poverty.

egen lpi_m = rowmean(wofood wowater womedi wofuel woincome)
tab lpi_m
recode lpi_m (0=0) (.2/1=1) (1.2/2=2) (2.2/3=3) (3.2/4=4)
label var lpi_m "Lived poverty index based on mean values"
tab lpi_m

*There is another method: exploratory factor analysis (EFA) that produces one principal component factor (pcf) for the five variables.
*The principal component factor is then used to predict all values for an index. 

factor wofood wowater womedi wofuel woincome, pcf
rotate
predict lpi_p
label var lpi_p "LPI factor scores"
alpha wofood wowater womedi wofuel woincome, item
tab lpi_p  //Higher values are indicative of higher levels of poverty. 0 is the average level. Less than 0 means "less than average poverty level".

*You will create a lived insecurity index (LII) based on the mean values of the following variables.

gen fearcrim = 0 if inlist(q10b,0,9)
replace fearcrim = 1 if inlist(q10b,1,2,3)
label var fearcrim "Feared crime, never (0) to at least once (1)"

gen stolen = 0 if inlist(q11a,0,9)
replace stolen = 1 if inlist(q11a,1,2,3,4)
label var stolen "Had something stolen, never (0) to at least once (1)"

gen attacked = 0 if inlist(q11b,0,9)
replace attacked = 1 if inlist(q11a,1,2,3,4)
label var attacked "Been physically attacked, never (0) to at least once (1)"

egen lii_m = rowmean(fearcrim stolen attacked)
recode lii_m (0=0) (1/3=1)
label var lii_m "Insecurity mean index"
tab lii_m

*Create LII based on factor scores. Complet the codes and tab lii_p.

factor fearcrim attacked stolen, pcf


log close
exit, clear

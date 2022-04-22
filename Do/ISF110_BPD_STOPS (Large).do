*********CLASS PROJECT ISF 110*************
*************By KC HARRIS *****************
*******************************************
clear all
set more off
capt log close
local c_date = c(current_date)
local study "BPDSTOPS"

// log using "\\Client\C$\Users\timet\Desktop\GitHub\Berkeley-PD-ISF-110\Log\Log `study' -`c_date'.log", replace
// use "\\Client\C$\Users\timet\Desktop\GitHub\Berkeley-PD-ISF-110\Data\formatted_allstops_large(expanded).dta", clear
// sysdir set PLUS "\\Client\C$\Users\timet\Desktop\GitHub\Berkeley-PD-ISF-110"
// ssc install mcp2





log using "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Log\Log `study' -`c_date'.log", replace
use "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Data\formatted_allstops_large(expanded)(2).dta"
sysdir set PLUS "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110"
// ssc install mcp2





gen race = 2 if perceived_race_or_ethnicity=="White"  
replace race = 3 if perceived_race_or_ethnicity=="Black/African American" |  perceived_race_or_ethnicity=="Black"
replace race = 4 if perceived_race_or_ethnicity=="Hispanic/Latino" |  perceived_race_or_ethnicity=="Hispanic"
replace race = 5 if perceived_race_or_ethnicity=="Asian"   
replace race = 1 if !inlist(race,1,2,3,4,5)
lab def race 1 "Other" 2 "White" 3 "Black/African American" 4 "Hispanic/Latino" 5 "Asian" 
lab value race race

gen gender = 1
replace gender = 1 if perceived_gender=="Male"
replace gender = 2 if perceived_gender=="Female"
replace gender = 0 if perceived_gender=="Other"
lab def gender 1 "Male" 2 "Female" 0 "Other"
lab value gender gender


gen male = 1 if gender==1
replace male = 0 if gender!=1
lab def male 1 "Male" 0 "Non-male"
lab value male male

gen result_of_stoptype = 1 if result_of_stop=="Citation for infraction" | result_of_stop=="Citation"
replace result_of_stoptype = 1 if result_of_stop=="Citation for infraction| Psychiatric hol(W&I Code 5150 or 5585.20)"
replace result_of_stoptype = 1 if result_of_stop=="Citation for infraction|Contacted parent/legal guardian or other person responsible for the minor"
replace result_of_stoptype = 1 if result_of_stop=="Citation for infraction|In-field cite and release"
replace result_of_stoptype = 1 if result_of_stop=="Citation for infraction|Warning (verbal or written)"
replace result_of_stoptype = 2 if result_of_stop=="Contacted parent/legal guardian or other person responsible for the minor"
replace result_of_stoptype = 2 if result_of_stop=="Contacted parent/legal guardian or other person responsible for the minor|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)|Warning (verbal or written)"
replace result_of_stoptype = 2 if result_of_stop=="Contacted parent/legal guardian or other person responsible for the minor|Warning (verbal or written)"
replace result_of_stoptype = 3 if result_of_stop=="Custodial arrest pursuant to outstanding warrant"
replace result_of_stoptype = 3 if result_of_stop=="Custodial arrest pursuant to outstanding warrant| Psychiatric hold (W&I Code 5150 or 5585.20)"
replace result_of_stoptype = 3 if result_of_stop=="Custodial arrest pursuant to outstanding warrant| Psychiatric hold (W&I Code 5150 or 5585.20)|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)"
replace result_of_stoptype = 3 if result_of_stop=="Custodial arrest pursuant to outstanding warrant|Citation for infraction"
replace result_of_stoptype = 3 if result_of_stop=="Custodial arrest pursuant to outstanding warrant|Custodial arrest without warrant"
replace result_of_stoptype = 3 if result_of_stop=="Custodial arrest pursuant to outstanding warrant|Custodial arrest without warrant| Psychiatric hold (W&I Code 5150 or 5585.20)"
replace result_of_stoptype = 3 if result_of_stop=="Custodial arrest pursuant to outstanding warrant|Field interview card completed"
replace result_of_stoptype = 3 if result_of_stop=="Custodial arrest pursuant to outstanding warrant|Warning (verbal or written)"
replace result_of_stoptype = 4 if result_of_stop=="Custodial arrest without warrant"
replace result_of_stoptype = 4 if result_of_stop=="Custodial arrest without warrant| Psychiatric hold (W&I Code 5150 or 5585.20)"
replace result_of_stoptype = 4 if result_of_stop=="Custodial arrest without warrant|Contacted parent/legal guardian or other person responsible for the minor"
replace result_of_stoptype = 4 if result_of_stop=="Custodial arrest without warrant|Custodial arrest pursuant to outstanding warrant"
replace result_of_stoptype = 4 if result_of_stop=="Custodial arrest without warrant|Custodial arrest pursuant to outstanding warrant|Contacted parent/legal guardian or other person responsible for the minor"
replace result_of_stoptype = 4 if result_of_stop=="Custodial arrest without warrant|In-field cite and release"
replace result_of_stoptype = 4 if result_of_stop=="Custodial arrest without warrant|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)"
replace result_of_stoptype = 4 if result_of_stop=="Custodial arrest without warrant|Field interview card completed"
replace result_of_stoptype = 5 if result_of_stop=="Field interview card completed"
replace result_of_stoptype = 5 if result_of_stop=="Field interview card completed| Psychiatric hold (W&I Code 5150 or 5585.20)"
replace result_of_stoptype = 5 if result_of_stop=="Field interview card completed|In-field cite and release"
replace result_of_stoptype = 5 if result_of_stop=="Field interview card completed|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)"
replace result_of_stoptype = 5 if result_of_stop=="Field interview card completed|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)|Contacted parent/legal guardian or other person responsible for the minor| Psychiatric hold (W&I Code 5150 or 5585.20)"
replace result_of_stoptype = 5 if result_of_stop=="Field interview card completed|In-field cite and release"
replace result_of_stoptype = 5 if result_of_stop=="Field interview card completed|Warning (verbal or written)"
replace result_of_stoptype = 6 if result_of_stop== "In-field cite and release" 
replace result_of_stoptype = 6 if result_of_stop==  "In-field cite and release| Psychiatric hold (W&I Code 5150 or 5585.20)" 
replace result_of_stoptype = 6 if result_of_stop==  "In-field cite and release|Citation for infraction" 
replace result_of_stoptype = 6 if result_of_stop==  "In-field cite and release|Custodial arrest pursuant to outstanding warrant" 
replace result_of_stoptype = 6 if result_of_stop==  "In-field cite and release|Custodial arrest without warrant" 
replace result_of_stoptype = 6 if result_of_stop==  "In-field cite and release|Field interview card completed" 
replace result_of_stoptype = 6 if result_of_stop==  "In-field cite and release|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)" 
replace result_of_stoptype = 6 if result_of_stop== "In-field cite and release|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)| Psychiatric hold (W&I Code 5150 or 5585.20)" 
replace result_of_stoptype = 7 if result_of_stop== "No action" 
replace result_of_stoptype = 8 if result_of_stop== "Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)" 
replace result_of_stoptype = 8 if result_of_stop== "Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)| Psychiatric hold (W&I Code 5150 or 5585.20)" 
replace result_of_stoptype = 8 if result_of_stop== "Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)| Psychiatric hold (W&I Code 5150 or 5585.20)|In-field cite and release" 
replace result_of_stoptype = 8 if result_of_stop== "Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)|Citation for infraction" 
replace result_of_stoptype = 8 if result_of_stop== "Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)|Contacted parent/legal guardian or other person responsible for the minor" 
replace result_of_stoptype = 8 if result_of_stop== "Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)|Contacted parent/legal guardian or other person responsible for the minor| Psychiatric hold (W&I Code 5150 or 5585.20)" 
replace result_of_stoptype = 9 if result_of_stop== "Psychiatric hold (W&I Code 5150 or 5585.20)" 
replace result_of_stoptype = 9 if result_of_stop== "Psychiatric hold (W&I Code 5150 or 5585.20)|Citation for infraction" 
replace result_of_stoptype = 9 if result_of_stop== "Psychiatric hold (W&I Code 5150 or 5585.20)|Custodial arrest pursuant to outstanding warrant" 
replace result_of_stoptype = 9 if result_of_stop== "Psychiatric hold (W&I Code 5150 or 5585.20)|Custodial arrest without warrant" 
replace result_of_stoptype = 9 if result_of_stop== "Psychiatric hold (W&I Code 5150 or 5585.20)|Field interview card completed" 
replace result_of_stoptype = 9 if result_of_stop== "Psychiatric hold (W&I Code 5150 or 5585.20)|In-field cite and release" 
replace result_of_stoptype = 9 if result_of_stop== "Psychiatric hold (W&I Code 5150 or 5585.20)|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)" 
replace result_of_stoptype = 9 if result_of_stop== "Psychiatric hold (W&I Code 5150 or 5585.20)|Warning (verbal or written)" 
replace result_of_stoptype = 10 if result_of_stop== "Warning (verbal or written)" | result_of_stop=="Warning"
replace result_of_stoptype = 10 if result_of_stop== "Warning (verbal or written)| Psychiatric hold (W&I Code 5150 or 5585.20)" 
replace result_of_stoptype = 10 if result_of_stop== "Warning (verbal or written)|Citation for infraction" 
replace result_of_stoptype = 10 if result_of_stop== "Warning (verbal or written)|Citation for infraction|Field interview card completed" 
replace result_of_stoptype = 10 if result_of_stop== "Warning (verbal or written)|Custodial arrest pursuant to outstanding warrant" 
replace result_of_stoptype = 10 if result_of_stop== "Warning (verbal or written)|Custodial arrest without warrant" 
replace result_of_stoptype = 10 if result_of_stop== "Warning (verbal or written)|Field interview card completed" 
replace result_of_stoptype = 10 if result_of_stop== "Warning (verbal or written)|In-field cite and release" 
replace result_of_stoptype = 10 if result_of_stop== "Warning (verbal or written)|In-field cite and release|Field interview card completed" 
replace result_of_stoptype = 10 if result_of_stop== "Warning (verbal or written)|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)"
replace result_of_stoptype = 11 if !inlist(result_of_stoptype,1,2,3,4,5,6,7,8,9,10)
lab def result_of_stoptype 1 "Citation for Infraction" 2 "Contacted Guardians" 3 "Custodial Arrest With Warrant" 4 "Custodial Arrest Without Warrant" 5 "Field Interview Card" 6 "In-Field Cite and Release" 7 "No Action" 8 "Noncriminal Transport" 9 "Psychiatric Hold" 10 "Warning" 11 "Other"
lab value result_of_stoptype result_of_stoptype

gen reason = 1 if reason_for_stop=="Traffic Violation" | reason_for_stop=="Traffic"
replace reason = 3 if reason_for_stop=="Knowledge of outstanding arrest warrant/wanted person"
replace reason = 2 if reason_for_stop=="Reasonable suspicion" | reason_for_stop=="Reas. Susp."
replace reason = 4 if reason_for_stop=="Consensual encounter resulting in search"
replace reason = 5 if reason_for_stop=="Investigation"| reason_for_stop=="Investigation to determine whether person was truant"
replace reason = 6 if reason_for_stop=="Prob./Parole"| reason_for_stop=="Parole/probation/PRCS/mandatory supervision"
replace reason = 7 if !inlist(reason,1,2,3,4,5,6)
lab def reason 1 "Traffic Violation" 2 "Reasonable Suspicion" 3 "Warrant" 4 "Consensual Search" 5 "Investigation" 6 "Probation/Parole" 7 "Other" 
lab value reason reason


gen type = 1 if type_of_stop  == "Bicycle"
replace type = 2 if type_of_stop  == "Pedestrian"
replace type = 3 if type_of_stop  == "Vehicle"
lab def type 1 "Vehicle" 2 "Pedestrian" 3 "Vehicle"
lab value type type 

gen arrest = 1 if inlist(result_of_stoptype,3,4)
replace arrest = 1 if result_of_stop == "Warning (verbal or written)|Custodial arrest without warrant" 
replace arrest = 1 if result_of_stop == "Warning (verbal or written)|Custodial arrest pursuant to outstanding warrant" 
replace arrest = 1 if result_of_stop == "Psychiatric hold (W&I Code 5150 or 5585.20)|Custodial arrest without warrant" 
replace arrest = 1 if result_of_stop == "Psychiatric hold (W&I Code 5150 or 5585.20)|Custodial arrest pursuant to outstanding warrant" 
replace arrest = 1 if result_of_stop == "In-field cite and release|Custodial arrest without warrant"
replace arrest = 1 if result_of_stop == "In-field cite and release|Custodial arrest pursuant to outstanding warrant" 
// replace arrest if result_of_stop == 
replace arrest = 0 if !inlist(arrest, 1)
lab def arrest 1 "Arrested" 0 "Not Arrested"
lab value arrest arrest


gen other = 1 if race == 1
replace other = 0 if race !=1
lab def other 1 "Other " 0 "Not Other " 
lab value other other


gen white = 1 if race == 2
replace white = 0 if race !=2
lab def white  1 "White" 0 "Not White"
lab value white white


gen black = 1 if race == 3
replace black = 0 if race !=3
lab def black 1 "Black/African American" 0 "Not Black/African American" 
lab value black black


gen hispanic = 1 if race == 4
replace hispanic = 0 if race !=4
lab def hispanic 1 "Hispanic" 0 "Not Hispanic" 
lab value hispanic hispanic


gen asian = 1 if race == 5
replace asian = 0 if race !=5
lab def asian 1 "Asian " 0 "Not Asian " 
lab value asian asian


gen nonwhite = 1 if inlist(race,1,3,4,5) 
replace nonwhite = 0 if inlist(race,2)
lab def nonwhite 0 "White" 1 "Nonwhite"
lab value nonwhite nonwhite

gen poc = 1 if inlist(race,1,3,4) 
replace poc = 0 if !inlist(poc,1)
lab def poc 0 "Not POC" 1 "POC"
lab value poc poc

gen far = 1 if tract_distancefromcal  >= 2
replace far = 0 if tract_distancefromcal  < 2
lab def far 1 "Far from university" 0 "Not far from university" 
lab value far far

gen close = 1 if tract_distancefromcal  <= 1.5
replace close = 0 if tract_distancefromcal  > 1.5
lab def close 1 "Close to university" 0 "Not close to university" 
lab value close close

gen reasonablesuspicion = 1 if reason_for_stop == "Reasonable suspicion" | reason_for_stop=="Reas. Susp."
replace reasonablesuspicion = 0 if !inlist(reasonablesuspicion, 1)
lab def reasonablesuspicion 1 "Stop based on reasonable suspicion" 0 "Stop based on other reason" 
lab value reasonablesuspicion reasonablesuspicion

gen trafficstop = 1 if reason == 2 | type_of_stop == "Vehicle"
replace trafficstop = 0 if !inlist(trafficstop,1)
lab def trafficstop 1 "Traffic Stop" 0 "Pedestrian or Bicycle stop" 
lab value trafficstop trafficstop

gen noactions = 1 if result_of_stoptype == 7 | result_of_stoptype == 10
replace noactions = 0 if !inlist(noaction,1)
lab def noactions 1 "Released with no citation or arrest" 0 "Other" 
lab value noactions noactions

gen warning = 1 if result_of_stoptype == 10 
replace warning = 0 if !inlist(warning,1)
lab def warning 1 "Let off with Warning" 0 "Other"
lab value warning warning

// replace perceived_gender = 2 if !inlist(perceived_gender,0,1)


sum arrest reason result_of_stoptype arrest perceived_age nonwhite poc race trafficstop noactions warning tract_totalnumstops tract_annualstops tract_medianincome tract_pocpop


*******************************************
*********CLASS PROJECT ISF 110*************
*************By KC HARRIS *****************
*******************************************
// clear alls
set more off
capt log close
local c_date = c(current_date)
local study "BPDSTOPS"

log using "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Log\Log `study' -`c_date'.log", replace

use "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Data\formatted_allstops"

sysdir set PLUS "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110"

cd "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Data
ls


replace stop = 1 if raceperceivedpriortostop=="True"
replace stop = 0 if raceperceivedpriortostop == "False"
lab def stop 1 "Race Percieved Prior" 0 "Race Not Percieved Prior"
lab value stop stop


gen race = 1 if perceivedraceorethnicity=="White"
replace race = 2 if perceivedraceorethnicity=="Black/African American"
replace race = 3 if perceivedraceorethnicity=="Hispanic/Latino"
replace race = 4 if perceivedraceorethnicity=="Asian"
replace race = 5 if !inlist(race,1,2,3,4)
lab def race 1 "White" 2 "Black/African American" 3 "Hispanic/Latino" 4 "Asian" 5 "Other" 
lab value race race


gen resultofstoptype = 1 if resultofstop=="Citation for infraction"
replace resultofstoptype = 1 if resultofstop=="Citation for infraction| Psychiatric hol(W&I Code 5150 or 5585.20)"
replace resultofstoptype = 1 if resultofstop=="Citation for infraction|Contacted parent/legal guardian or other person responsible for the minor"
replace resultofstoptype = 1 if resultofstop=="Citation for infraction|In-field cite and release"
replace resultofstoptype = 1 if resultofstop=="Citation for infraction|Warning (verbal or written)"
replace resultofstoptype = 2 if resultofstop=="Contacted parent/legal guardian or other person responsible for the minor"
replace resultofstoptype = 2 if resultofstop=="Contacted parent/legal guardian or other person responsible for the minor|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)|Warning (verbal or written)"
replace resultofstoptype = 2 if resultofstop=="Contacted parent/legal guardian or other person responsible for the minor|Warning (verbal or written)"
replace resultofstoptype = 3 if resultofstop=="Custodial arrest pursuant to outstanding warrant"
replace resultofstoptype = 3 if resultofstop=="Custodial arrest pursuant to outstanding warrant| Psychiatric hold (W&I Code 5150 or 5585.20)"
replace resultofstoptype = 3 if resultofstop=="Custodial arrest pursuant to outstanding warrant| Psychiatric hold (W&I Code 5150 or 5585.20)|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)"
replace resultofstoptype = 3 if resultofstop=="Custodial arrest pursuant to outstanding warrant|Citation for infraction"
replace resultofstoptype = 3 if resultofstop=="Custodial arrest pursuant to outstanding warrant|Custodial arrest without warrant"
replace resultofstoptype = 3 if resultofstop=="Custodial arrest pursuant to outstanding warrant|Custodial arrest without warrant| Psychiatric hold (W&I Code 5150 or 5585.20)"
replace resultofstoptype = 3 if resultofstop=="Custodial arrest pursuant to outstanding warrant|Field interview card completed"
replace resultofstoptype = 3 if resultofstop=="Custodial arrest pursuant to outstanding warrant|Warning (verbal or written)"
replace resultofstoptype = 4 if resultofstop=="Custodial arrest without warrant"
replace resultofstoptype = 4 if resultofstop=="Custodial arrest without warrant| Psychiatric hold (W&I Code 5150 or 5585.20)"
replace resultofstoptype = 4 if resultofstop=="Custodial arrest without warrant|Contacted parent/legal guardian or other person responsible for the minor"
replace resultofstoptype = 4 if resultofstop=="Custodial arrest without warrant|Custodial arrest pursuant to outstanding warrant"
replace resultofstoptype = 4 if resultofstop=="Custodial arrest without warrant|Custodial arrest pursuant to outstanding warrant|Contacted parent/legal guardian or other person responsible for the minor"
replace resultofstoptype = 4 if resultofstop=="Custodial arrest without warrant|In-field cite and release"
replace resultofstoptype = 4 if resultofstop=="Custodial arrest without warrant|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)"
replace resultofstoptype = 5 if resultofstop=="Custodial arrest without warrant|Field interview card completed"
replace resultofstoptype = 5 if resultofstop=="Field interview card completed"
replace resultofstoptype = 5 if resultofstop=="Field interview card completed| Psychiatric hold (W&I Code 5150 or 5585.20)"
replace resultofstoptype = 5 if resultofstop=="Field interview card completed|In-field cite and release"
replace resultofstoptype = 5 if resultofstop=="Field interview card completed|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)"
replace resultofstoptype = 5 if resultofstop=="Field interview card completed|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)|Contacted parent/legal guardian or other person responsible for the minor| Psychiatric hold (W&I Code 5150 or 5585.20)"
replace resultofstoptype = 5 if resultofstop=="Field interview card completed|In-field cite and release"
replace resultofstoptype = 5 if resultofstop=="Field interview card completed|Warning (verbal or written)"
replace resultofstoptype = 6 if resultofstop== "In-field cite and release" 
replace resultofstoptype = 6 if resultofstop==  "In-field cite and release| Psychiatric hold (W&I Code 5150 or 5585.20)" 
replace resultofstoptype = 6 if resultofstop==  "In-field cite and release|Citation for infraction" 
replace resultofstoptype = 6 if resultofstop==  "In-field cite and release|Custodial arrest pursuant to outstanding warrant" 
replace resultofstoptype = 6 if resultofstop==  "In-field cite and release|Custodial arrest without warrant" 
replace resultofstoptype = 6 if resultofstop==  "In-field cite and release|Field interview card completed" 
replace resultofstoptype = 6 if resultofstop==  "In-field cite and release|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)" 
replace resultofstoptype = 6 if resultofstop== "In-field cite and release|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)| Psychiatric hold (W&I Code 5150 or 5585.20)" 
replace resultofstoptype = 7 if resultofstop== "No action" 
replace resultofstoptype = 8 if resultofstop== "Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)" 
replace resultofstoptype = 8 if resultofstop== "Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)| Psychiatric hold (W&I Code 5150 or 5585.20)" 
replace resultofstoptype = 8 if resultofstop== "Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)| Psychiatric hold (W&I Code 5150 or 5585.20)|In-field cite and release" 
replace resultofstoptype = 8 if resultofstop== "Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)|Citation for infraction" 
replace resultofstoptype = 8 if resultofstop== "Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)|Contacted parent/legal guardian or other person responsible for the minor" 
replace resultofstoptype = 8 if resultofstop== "Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)|Contacted parent/legal guardian or other person responsible for the minor| Psychiatric hold (W&I Code 5150 or 5585.20)" 
replace resultofstoptype = 9 if resultofstop== "Psychiatric hold (W&I Code 5150 or 5585.20)" 
replace resultofstoptype = 9 if resultofstop== "Psychiatric hold (W&I Code 5150 or 5585.20)|Citation for infraction" 
replace resultofstoptype = 9 if resultofstop== "Psychiatric hold (W&I Code 5150 or 5585.20)|Custodial arrest pursuant to outstanding warrant" 
replace resultofstoptype = 9 if resultofstop== "Psychiatric hold (W&I Code 5150 or 5585.20)|Custodial arrest without warrant" 
replace resultofstoptype = 9 if resultofstop== "Psychiatric hold (W&I Code 5150 or 5585.20)|Field interview card completed" 
replace resultofstoptype = 9 if resultofstop== "Psychiatric hold (W&I Code 5150 or 5585.20)|In-field cite and release" 
replace resultofstoptype = 9 if resultofstop== "Psychiatric hold (W&I Code 5150 or 5585.20)|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)" 
replace resultofstoptype = 9 if resultofstop== "Psychiatric hold (W&I Code 5150 or 5585.20)|Warning (verbal or written)" 
replace resultofstoptype = 10 if resultofstop== "Warning (verbal or written)" 
replace resultofstoptype = 10 if resultofstop== "Warning (verbal or written)| Psychiatric hold (W&I Code 5150 or 5585.20)" 
replace resultofstoptype = 10 if resultofstop== "Warning (verbal or written)|Citation for infraction" 
replace resultofstoptype = 10 if resultofstop== "Warning (verbal or written)|Citation for infraction|Field interview card completed" 
replace resultofstoptype = 10 if resultofstop== "Warning (verbal or written)|Custodial arrest pursuant to outstanding warrant" 
replace resultofstoptype = 10 if resultofstop== "Warning (verbal or written)|Custodial arrest without warrant" 
replace resultofstoptype = 10 if resultofstop== "Warning (verbal or written)|Field interview card completed" 
replace resultofstoptype = 10 if resultofstop== "Warning (verbal or written)|In-field cite and release" 
replace resultofstoptype = 10 if resultofstop== "Warning (verbal or written)|In-field cite and release|Field interview card completed" 
replace resultofstoptype = 10 if resultofstop== "Warning (verbal or written)|Noncriminal transport or caretaking transport (including transport by officer / ambulance or other agency)"
lab def resultofstoptype 1 "Citation for Infraction" 2 "Contacted Guardians" 3 "Custodial Arrest With Warrant" 4 "Custodial Arrest Without Warrant" 5 "Field Interview Card" 6 "In-Field Cite and Release" 7 "No Action" 8 "Noncriminal Transport" 9 "Psychiatric Hold" 10 "Warning"
lab value resultofstoptype resultofstoptype








drop if durationofstop >270
















//https://www.stata.com/manuals/spintro4.pdf#spIntro4
ssc install shp2dta, replace
// ssc install spshape2dta, replace

unzipfile Census_Tract_Polygons_2010.zip

spshape2dta geo_export_c67dd96f-bd48-4ef9-88a6-0902237d752f replace

use geo_export_c67dd96f-bd48-4ef9-88a6-0902237d752f, clear
describe
list in 1/5


// generate long fips = real(ID)
// // bysort fips: assert _N==1
// assert fips != .


// gen pop = totalpop  //population for each tract

// ssc install spmap, replace

spmap totalpop using geo_export_c67dd96f-bd48-4ef9-88a6-0902237d752f_shp, id(ID) fcolor(Blues)  
// spmap totalpop using geo_export_c67dd96f-bd48-4ef9-88a6-0902237d752f_shp, id(ID) fcolor(Reds)

set more off
clear all
































//EVERYTHING AFTER THIS IS UNDER DEVELOPMENT. GRAPHS
use usdata, clear
ren subreg_id subreg
encode subreg, gen(subreg_id)

keep subreg_id unhappy housing_price unemployment

merge 1:1 subreg_id using usdb.dta
drop _merge

merge 1:1 subreg_id using uslabelcoord.dta
drop _merge


spmap unhappy using uscoord.dta, id(subreg_id) ///
label(label(subreg_id) xcoord(xcoord) ycoord(ycoord)) ///
fcolor(Reds) legtitle("Fraction of respondents who were unhappy") ///
title("Figure 3: Unhappiness by Census Division, 2012")





gen Y = housing_price
format Y %4.1f 

spmap unhappy using uscoord.dta, id(subreg_id)  ///
point(x(xcoord) y(ycoord) proportional(Y) fcolor(red) ocolor(white) size(*3.5))  ///
label(label(subreg_id) xcoord(xcoord) ycoord(ycoord))  /// 
fcolor(Whites) legtitle("Fraction of respondents who were unhappy")  ///
title("Figure 3: Housing Price and Unhappiness by Census Division, 2012")






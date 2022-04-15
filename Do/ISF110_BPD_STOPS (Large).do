*******************************************
*********CLASS PROJECT ISF 110*************
*************By KC HARRIS *****************
*******************************************
clear all
set more off
capt log close
local c_date = c(current_date)
local study "BPDSTOPS"

// log using "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Log\Log `study' -`c_date'.log", replace

// use "\\Client\C$\Users\timet\Desktop\GitHub\Berkeley-PD-ISF-110\Data\formatted_allstops.dta", clear
//
// sysdir set PLUS "\\Client\C$\Users\timet\Desktop\GitHub\Berkeley-PD-ISF-110"
// ssc install mcp2
// use "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Data\formatted_allstops_large(expanded).dta"

// sysdir set PLUS "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110"
//
// cd "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Data
// ls




gen racepercieved = 1 if raceperceivedpriortostop=="True"
// replace stop = 1 if raceperceivedpriortostop=="True"
replace racepercieved = 0 if raceperceivedpriortostop == "False"
lab def racepercieved 1 "Race Percieved Prior" 0 "Race Not Percieved Prior"
lab value racepercieved racepercieved

gen race = 1
replace race = 2 if perceivedraceorethnicity=="White"
replace race = 3 if perceivedraceorethnicity=="Black/African American"
replace race = 4 if perceivedraceorethnicity=="Hispanic/Latino"
replace race = 5 if perceivedraceorethnicity=="Asian"
replace race = 1 if !inlist(race,1,2,3,4,5)
lab def race 1 "Other" 2 "White" 3 "Black/African American" 4 "Hispanic/Latino" 5 "Asian" 
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

gen reason = 1 if reasonforstop=="Traffic Violation"
replace reason = 3 if reasonforstop=="Knowledge of outstanding arrest warrant/wanted person"
replace reason = 2 if reasonforstop=="Reasonable suspicion"
replace reason = 4 if reasonforstop=="Consensual encounter resulting in search"
replace reason = 5 if !inlist(reason,1,2,3,4)
lab def reason 1 "Traffic Violation" 2 "Reasonable Suspicion" 3 "Warrant" 4 "Consensual Search" 5 "Other" 
lab value reason reason


gen arrest = 1 if inlist(resultofstoptype,3,4)
replace arrest = 0 if inlist(resultofstoptype, 1,2,5,6,7,8,9,10)
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


gen longstop = 1 if durationofstop >= 20
replace longstop = 0 if durationofstop < 20
lab def longstop 1 "Longer than average stop" 0 "Normal/shorter than average stop" 
lab value longstop longstop

gen far = 1 if distancefromcal >= 2
replace far = 0 if distancefromcal < 2
lab def far 1 "Far from university" 0 "Not far from university" 
lab value far far

gen infobased = 1 if informationbasedstop == "yes"
replace infobased = 0 if informationbasedstop != "yes"
lab def infobased 1 "Stop based on previous information" 0 "Stop not based on previous information" 
lab value infobased infobased

gen reasonablesuspicion = 1 if reasonforstop == "Reasonable suspicion"
replace reasonablesuspicion = 0 if reasonforstop != "Reasonable suspicion"
lab def reasonablesuspicion 1 "Stop based on reasonable suspicion" 0 "Stop based on other reason" 
lab value reasonablesuspicion reasonablesuspicion

gen trafficstop = 1 if reasonforstop == "Traffic Violation" | typeofstop == "Vehicle"
replace trafficstop = 0 if reasonforstop != "Traffic Violation" | typeofstop != "Vehicle"
lab def trafficstop 1 "Traffic Stop" 0 "Pedestrian or Bicycle stop" 
lab value trafficstop trafficstop

gen noactions = 1 if resultofstoptype == 7 | resultofstoptype == 10
replace noactions = 0 if !inlist(noaction,1)
lab def noactions 1 "Released with no citation or arrest" 0 "Other" 
lab value noactions noactions

gen warning = 1 if resultofstoptype == 10 
replace warning = 0 if !inlist(warning,1)
lab def warning 1 "Let off with Warning" 0 "Other"
lab value warning warning


// replace arrest = 0 if resultofstop!="Custodial Arrest Without Warrant" & resultofstoptype!="Custodial Arrest With Warrant"
// lab def arrest 1 "Arrest" 2 "Other" 
// lab value arrest arrest






// mcp2 perceivedage black

// logit arrest black distancefromcalsimple c.distancefromcalsimple#c.distancefromcalsimple, or

logit arrest black perceivedage racepercieved distancefromcal c.distancefromcal#c.distancefromcal, or
margins, at(distancefromcal =(1(.25)4))
marginsplot, xdimension(at(distancefromcal))
mcp2 distancefromcal black 


logit longstop racepercieved white black hispanic asian other distancefromcal c.distancefromcal#c.distancefromcal, or
margins, at(distancefromcal =(1(.25)4))
marginsplot, xdimension(at(distancefromcal))
mcp2 distancefromcal


// exit, clear 













//https://www.stata.com/manuals/spintro4.pdf#spIntro4
// ssc install shp2dta, replace
// // ssc install spshape2dta, replace
//
// unzipfile Census_Tract_Polygons_2010.zip
//
// spshape2dta geo_export_c67dd96f-bd48-4ef9-88a6-0902237d752f replace
//
// use geo_export_c67dd96f-bd48-4ef9-88a6-0902237d752f, clear
// describe
// list in 1/5
//
//
// // generate long fips = real(ID)
// // // bysort fips: assert _N==1
// // assert fips != .
//
//
// // gen pop = totalpop  //population for each tract
//
// // ssc install spmap, replace
//
// spmap totalpop using geo_export_c67dd96f-bd48-4ef9-88a6-0902237d752f_shp, id(ID) fcolor(Blues)  
// // spmap totalpop using geo_export_c67dd96f-bd48-4ef9-88a6-0902237d752f_shp, id(ID) fcolor(Reds)
//
// set more off
// clear all
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// //EVERYTHING AFTER THIS IS UNDER DEVELOPMENT. GRAPHS
// use usdata, clear
// ren subreg_id subreg
// encode subreg, gen(subreg_id)
//
// keep subreg_id unhappy housing_price unemployment
//
// merge 1:1 subreg_id using usdb.dta
// drop _merge
//
// merge 1:1 subreg_id using uslabelcoord.dta
// drop _merge
//
//
// spmap unhappy using uscoord.dta, id(subreg_id) ///
// label(label(subreg_id) xcoord(xcoord) ycoord(ycoord)) ///
// fcolor(Reds) legtitle("Fraction of respondents who were unhappy") ///
// title("Figure 3: Unhappiness by Census Division, 2012")
//
//
//
//
//
// gen Y = housing_price
// format Y %4.1f 
//
// spmap unhappy using uscoord.dta, id(subreg_id)  ///
// point(x(xcoord) y(ycoord) proportional(Y) fcolor(red) ocolor(white) size(*3.5))  ///
// label(label(subreg_id) xcoord(xcoord) ycoord(ycoord))  /// 
// fcolor(Whites) legtitle("Fraction of respondents who were unhappy")  ///
// title("Figure 3: Housing Price and Unhappiness by Census Division, 2012")







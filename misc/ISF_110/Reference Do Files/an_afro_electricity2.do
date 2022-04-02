*******************************************
*GOVERNANCE FOR HEALTH IN THE GLOBAL SOUTH*
********Written by Amm Quamruzzaman********
***Afrobarometer Cross-Sectional Analysis**
*******************************************

clear all
set more off
capt log close

local study "Electricity"

local c_date = c(current_date)

log using "\\Client\C$\ISF_110\Lab 8\Log\ `study' -`c_date'.log", replace

use "\\Client\C$\ISF_110\Lab 8\Data\cr_afro_r5_2015_update.dta", clear

********************
*Generate variables*
********************

gen urban = 1 if urbrur == 1
replace urban = 0 if inlist(urbrur,2,3)
label var urban "Urban or rural PSU, urban = 1"

gen egrid = 1 if ea_svc_a == 1 & ea_svc_a != -1 & ea_svc_a != 9
replace egrid = 0 if ea_svc_a == 0
label var egrid "PSU has electricity grid = 1"

gen pwater = 1 if ea_svc_b == 1 & ea_svc_b != -1 & ea_svc_b != 9
replace pwater = 0 if ea_svc_b == 0
label var pwater "PSU has piped water supply = 1"

gen sewage = 1 if ea_svc_c == 1 & ea_svc_c != -1 & ea_svc_c !=9
replace sewage = 0 if ea_svc_c == 0
label var sewage "PSU has sewage system = 1"

gen ps = 1 if ea_fac_c == 1 & ea_fac_c != -1 & ea_fac_c != 9
replace ps = 0 if ea_fac_c == 0
label variable ps "PSU has police station = 1"

gen army = 1 if ea_sec_b == 1 & ea_sec_b != -1 & ea_sec_b != 9
replace army = 0 if ea_sec_b == 0
label var army "PSU has soldiers/army vehecles = 1"

gen road = 1 if ea_road == 1 & ea_road != -1
replace road = 0 if ea_road == 0
label var road "PSU has paved/tarred road = 1"

gen wofood = 0 if inlist(q8a,0,9)
replace wofood = 1 if q8a == 1
replace wofood = 2 if q8a == 2
replace wofood = 3 if q8a == 3
replace wofood = 4 if q8a == 4
label var wofood "Gone without food, never (0), once or twice (1) to always (4)"
tab wofood

gen wowater = 0 if inlist(q8b,0,9)
replace wowater = 1 if q8b == 1
replace wowater = 2 if q8b == 2
replace wowater = 3 if q8b == 3
replace wowater = 4 if q8b == 4
label var wowater "Gone without water, never (0), once or twice (1) to always (4)"
tab wowater

gen womedi = 0 if inlist(q8c,0,9)
replace womedi = 1 if q8c == 1
replace womedi = 2 if q8c == 2
replace womedi = 3 if q8c == 3
replace womedi = 4 if q8c == 4
label var womedi "Gone without medical care, never (0), once or twice (1) to always (4)"
recode womedi (0=0) (1/4=1)
tab womedi

gen wofuel = 0 if inlist(q8d,0,9)
replace wofuel = 1 if q8d == 1
replace wofuel = 2 if q8d == 2
replace wofuel = 3 if q8d == 3
replace wofuel = 4 if q8d == 4
label var wofuel "Gone without cooking fuel, never (0), once or twice (1) to always (4)"
tab wofuel

gen woincome = 0 if inlist(q8e,0,9)
replace woincome = 1 if q8e == 1
replace woincome = 2 if q8e == 2
replace woincome = 3 if q8e == 3
replace woincome = 4 if q8e == 4
label var woincome "Gone without cash income, never (0), once or twice (1) to always (4)"
tab woincome

factor wofood wowater womedi wofuel woincome, pcf
rotate
predict lpi
label var lpi "Poverty factor scores"
alpha wofood wowater womedi wofuel woincome, item

gen fearcrim = 0 if inlist(q9b,0,9)
replace fearcrim = 1 if inlist(q9b,1,2,3,4)
label var fearcrim "Feared crime, never (0) to at least once (1)"

gen stolen = 0 if inlist(q10a,0,9)
replace stolen = 1 if inlist(q10a,1,2,3)
label var stolen "Something stolen from house,  never (0) to at least once (1)"

gen attacked = 0 if inlist(q10b,0,9)
replace attacked = 1 if inlist(q10b,1,2,3)
label var attacked "Physically attacked, never (0) to at least once (1)"

factor fearcrim attacked stolen, pcf
rotate
predict lii
label var lii "Insecurity factor scores"
alpha fearcrim attacked stolen, item

gen demo_sat = 0 if inlist(q43,0,1,2,9)
replace demo_sat = 1 if inlist(q43,3,4)
label var demo_sat "Satisfaction with democracy, not at all/not very (0) fairly/very (1)"

gen law_pr = 1 if inlist(q52c,0,1,9)
replace law_pr = 0 if inlist(q52c,2,3) & q52c != -1
*replace law_pr = 9 if q52c == 9 & q52c != -1
label var law_pr "President ignores law/constitution, never/rarely (1) to often/always (0)"

gen law_peop = 1 if inlist(q56b,0,1,9)
replace law_peop = 0 if inlist(q56b,2,3) & q56b != -1
label var law_peop "People are treated unequally under the law, never/rarely (1) to often/always (0)"

gen law_off = 1 if inlist(q56f,0,1,9)
replace law_off = 0 if inlist(q56f,2,3) & q56f != -1
label var law_off "Officials unpunished, never/rarely (1) to often/always (0)"

gen law_ordi = 1 if inlist(q56g,0,1,9)
replace law_ordi = 0 if inlist(q56g,2,3) & q56g != -1
label var law_ordi "Ordinary people unpunished, never/rarely (1) to often/always (0)"

factor law_peop law_pr law_ordi law_off, pcf
rotate
predict rule_law

gen cor_tx = 1 if inlist(q60f,0,1,9)
replace cor_tx = 0 if inlist(q60b,2,3) & q60b != -1
label var cor_tx "Tax collectors corrupt, none/some (1) to most/all (0)"

gen cor_of = 1 if inlist(q60c,0,1,9)
replace cor_of = 0 if inlist(q60c,2,3) & q60c != -1
label var cor_of "Government officials corrupt, none/some (1) to most/all (0)"

gen cor_pl = 1 if inlist(q60e,0,1,9)
replace cor_pl = 0 if inlist(q60e,2,3) & q60e != -1
label var cor_pl "Police corrupt, none/some (1) to most/all (0)"

gen cor_ju = 1 if inlist(q60g,0,1,9)
replace cor_ju = 0 if inlist(q60g,2,3) & q60g != -1
label var cor_ju "Judges and magistrates corrupt, none/some (1) to most/all (0)"

factor cor_tx cor_of cor_pl cor_ju, pcf
rotate
predict control_cor

gen gov_effe = 0 if inlist(q65a,1,2,9)
replace gov_effe = 1 if inlist(q65a,3,4) & q65a != -1
lab var gov_effe "Government effectiveness in handling the economy, badly/fairly (0) to fairly/very well (1)"

gen gov_effc = 0 if inlist(q65f,1,2,9)
replace gov_effc = 1 if inlist(q65f,3,4) & q65f != -1
lab var gov_effc "Government effectiveness in reducing crime, badly/fairly (0) to fairly/very well (1)"

gen gov_effh = 0 if inlist(q65g,1,2,9)
replace gov_effh = 1 if inlist(q65g,3,4) & q65g != -1
lab var gov_effh "Government effectiveness in improving health services, badly/fairly (0) to fairly/very well (1)"

gen gov_effd = 0 if inlist(q65h,1,2,9)
replace gov_effd = 1 if inlist(q65h,3,4) & q65h != -1
lab var gov_effd "Government effectiveness in addressing educational needs, badly/fairly (0) to fairly/very well (1)"

gen gov_effw = 0 if inlist(q65i,1,2,9)
replace gov_effw = 1 if inlist(q65i,3,4) & q65i != -1
lab var gov_effw "Government effectiveness in delivering household water, badly/fairly (0) to fairly/very well (1)"

gen gov_efff = 0 if inlist(q65j,1,2,9)
replace gov_efff = 1 if inlist(q65j,3,4) & q65j != -1
lab var gov_efff "Government effectiveness in ensuring food for everyone, badly/fairly (0) to fairly/very well (1)"

gen gov_effr = 0 if inlist(q65k,1,2,9)
replace gov_effr = 1 if inlist(q65k,3,4) & q65k != -1
lab var gov_effr "Government effectiveness in fighting corruption, badly/fairly (0) to fairly/very well (1)"

gen gov_effb = 0 if inlist(q65n,1,2,9)
replace gov_effb = 1 if inlist(q65n,3,4) & q65n != -1
lab var gov_effb "Government effectiveness in maintaining roads and bridges, badly/fairly (0) to fairly/very well (1)"

gen gov_effs = 0 if inlist(q65o,1,2,9)
replace gov_effs = 1 if inlist(q65o,3,4) & q65o != -1
lab var gov_effs "Government effectiveness in providing electric supply, badly/fairly (0) to fairly/very well (1)"

factor gov_effe gov_effc gov_effh gov_effd gov_effw gov_efff gov_effb gov_effr gov_effs, pcf
rotate
predict goveff_p

gen ser_wat = 0 if inlist(q67b,1,2) & q67b != -1 & q67e != 5 & q67e != 9
replace ser_wat = 1 if inlist(q67b,3,4)
lab var ser_wat "Difficulty to obtain household services, easy/very easy (1) to very/difficult (0)"

gen ser_med = 0 if inlist(q67e,1,2) & q67e != -1 & q67e != 5 & q67e != 9
replace ser_med = 1 if inlist(q67e,3,4)
lab var ser_med "Difficulty to obtain medical treatment, easy/very easy (1) to very/difficult (0)"

gen ser_id = 0 if inlist(q67a,1,2) & q67a != -1 & q67e != 5 & q67e != 9
replace ser_id = 1 if inlist(q67a,3,4)
lab var ser_id "Difficulty to obtain identity document, easy/very easy (1) to very/difficult (0)"

gen ser_pol = 0 if inlist(q67c,1,2) & q67c != -1 & q67e != 5 & q67e != 9
replace ser_pol = 1 if inlist(q67c,3,4)
lab var ser_pol "Difficulty to obtain help from the police, easy/very easy (1) to very/difficult (0)"

gen ser_sch = 0 if inlist(q67d,1,2) & q67d != -1 & q67e != 5 & q67e != 9
replace ser_sch = 1 if inlist(q67d,3,4)
lab var ser_sch "Difficulty to obtain school placement, easy/very easy (1) to very/difficult (0)"

factor ser_id ser_pol ser_sch ser_wat ser_med, pcf
rotate
predict qual_bur

*SUMMARY TABLE AND CORRELATION

sum lpi lii egrid pwater sewage road ps army rule_law control_cor demo_sat goveff_p qual_bur urban west_africa_only east_africa_only southern_africa_only north_africa_only

corr lpi lii egrid pwater sewage road ps army rule_law control_cor demo_sat goveff_p qual_bur urban west_africa_only east_africa_only southern_africa_only north_africa_only

**********
*ANALYSES*
**********

*MULTIPLE LINEAR REGRESSION

local study "lpi"

reg lpi egrid pwater sewage road   //Model 1
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\Results `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) replace
reg lpi egrid pwater sewage road ps army   //Model 2
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\Results `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
reg lpi egrid pwater sewage road ps army rule_law control_cor demo_sat goveff_p qual_bur   //Model 3
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\Results `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
reg lpi egrid pwater sewage road ps army rule_law control_cor demo_sat goveff_p qual_bur urban east_africa_only southern_africa_only north_africa_only   //Model 4
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\Results `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
/
	
local study "lli"

reg lii egrid pwater sewage road   //Model 1
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\Results `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) replace
reg lii egrid pwater sewage road ps army   //Model 2
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\Results `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
reg lii egrid pwater sewage road ps army rule_law control_cor demo_sat goveff_p qual_bur   //Model 3
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\Results `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
reg lii egrid pwater sewage road ps army rule_law control_cor demo_sat goveff_p qual_bur urban east_africa_only southern_africa_only north_africa_only   //Model 4
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\Results `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append

*

/*MULTILEVEL MODELING: DO THIS PART IF YOUR COMPUTER SUPPORTS

local study "poverty"

xtmixed lpi egrid pwater sewage road [pw=withinwt]  || country: , pweight(acrosswt) || eanumb:
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\`study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) replace
xtmixed lpi egrid pwater sewage road ps army [pw=withinwt]  || country: , pweight(acrosswt) || eanumb:
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\`study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
xtmixed lpi egrid pwater sewage road ps army rule_law control_cor demo_sat goveff_p qual_bur [pw=withinwt]  || country: , pweight(acrosswt) || eanumb:
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\`study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
xtmixed lpi egrid pwater sewage road ps army rule_law control_cor demo_sat goveff_p qual_bur urban east_africa_only southern_africa_only north_africa_only [pw=withinwt]  || country: , pweight(acrosswt) || eanumb:
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\`study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append

local study "insecurity"

xtmixed lii egrid pwater sewage road [pw=withinwt]  || country: , pweight(acrosswt) || eanumb:
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\`study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) replace
xtmixed lii egrid pwater sewage road ps army [pw=withinwt]  || country: , pweight(acrosswt) || eanumb:
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\`study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
xtmixed lii egrid pwater sewage road ps army rule_law control_cor demo_sat goveff_p qual_bur [pw=withinwt]  || country: , pweight(acrosswt) || eanumb:
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\`study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
xtmixed lii egrid pwater sewage road ps army rule_law control_cor demo_sat goveff_p qual_bur urban east_africa_only southern_africa_only north_africa_only [pw=withinwt]  || country: , pweight(acrosswt) || eanumb:
	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\`study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
*/

log close
exit, clear

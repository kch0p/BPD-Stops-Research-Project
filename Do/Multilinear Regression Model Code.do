clear all
set more off
capt log close
local c_date = c(current_date)
local study "BPDSTOPS"

// log using "\\Client\C$\Users\timet\Desktop\GitHub\Berkeley-PD-ISF-110\Log\Log `study' -`c_date'.log", replace
// use "\\Client\C$\Users\timet\Desktop\GitHub\Berkeley-PD-ISF-110\Data\formatted_allstops_large(expanded).dta", clear
// sysdir set PLUS "\\Client\C$\Users\timet\Desktop\GitHub\Berkeley-PD-ISF-110"
// ssc install mcp2

log using "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Log\Multilinear_Log `study' -`c_date'.log", replace
use "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Data\census_info_multilinear.dta"
// sysdir set PLUS "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110"






reg annualstops totalpop medianincome distancefromcal   //Model 1
	outreg2 using "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Exports\census_lin_regResults `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) replace
reg annualstops totalpop medianincome distancefromcal poccomp  //Model 1
	outreg2 using "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Exports\census_lin_regResults `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
reg annualstops totalpop medianincome distancefromcal poccomp totalnumstops //Model 1
	outreg2 using "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Exports\census_lin_regResults `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
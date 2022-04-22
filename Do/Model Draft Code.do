// model code based on lab 8/lab 9






local study "arrest"
local model "arrest"


// desktop version
logit arrest black perceivedage perceivedgender, or   //Model 1
	outreg2 using "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Exports\smallmodelResults `study'-`c_date'.xls", eform dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) replace
logit arrest black perceivedage perceivedgender type infobased racepercieved reason, or   //Model 2
	outreg2 using "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Exports\smallmodelResults `study'-`c_date'.xls", eform dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
logit arrest black perceivedage perceivedgender type infobased racepercieved reason distancefromcal area_totalpop area_medianincome area_annualstops nonwhitecomp, or   //Model 3
	outreg2 using "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Exports\smallmodelResults `study'-`c_date'.xls", eform dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
	
	
	

	
	



//tablet version
// logit arrest black perceivedage perceivedgender, or   //Model 1
// 	outreg2 using "\\Client\C$\Users\timet\Desktop\GitHub\Berkeley-PD-ISF-110\Exports\smallmodelResults `study'-`c_date'.xls", eform dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) replace
// logit arrest black perceivedage perceivedgender trafficstop infobased racepercieved reasonablesuspicion, or   //Model 2
// 	outreg2 using "\\Client\C$\Users\timet\Desktop\GitHub\Berkeley-PD-ISF-110\Exports\smallmodelResults `study'-`c_date'.xls", eform dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
// logit arrest black perceivedage perceivedgender trafficstop infobased racepercieved reasonablesuspicion distancefromcal area_totalpop area_medianincome area_annualstops nonwhitecomp, or   //Model 3
// 	outreg2 using "\\Client\C$\Users\timet\Desktop\GitHub\Berkeley-PD-ISF-110\Exports\smallmodelResults `study'-`c_date'.xls", eform dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
	
	
	
	












//
//
// factor race wowater womedi wofuel woincome, pcf
// rotate
// predict arrpi
// label var arrpi "Arrest Factor Scores"
// alpha wofood wowater womedi wofuel woincome, item
//
//
//
// local study "arrpi"
//
// reg lpi egrid pwater sewage road   //Model 1
// 	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\Results `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) replace
// reg lpi egrid pwater sewage road ps army   //Model 2
// 	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\Results `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
// reg lpi egrid pwater sewage road ps army rule_law control_cor demo_sat goveff_p qual_bur   //Model 3
// 	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\Results `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
// reg lpi egrid pwater sewage road ps army rule_law control_cor demo_sat goveff_p qual_bur urban east_africa_only southern_africa_only north_africa_only   //Model 4
// 	outreg2 using "\\Client\C$\ISF_110\Lab 8\Results\Results `study'-`c_date'.xls", dec(3) alpha(0.001, 0.01, 0.05) symbol(***, **, *) append
// /
//	
// local study "lli"
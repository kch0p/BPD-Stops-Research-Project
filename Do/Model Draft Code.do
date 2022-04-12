// model code based on lab 8
use "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Data\formatted_allstops.dta"



factor wofood wowater womedi wofuel woincome, pcf
rotate
predict arrpi
label var arrpi "Arrest Factor Scores"
alpha wofood wowater womedi wofuel woincome, item



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
use "\\Client\C$\ISF_110\Lab 6\Data\usdata.dta"

cd "\\Client\C$\ISF_110\Lab 6\wb_adm0_boundary_lines_10m"

ls 

log using "\\Client\C$\ISF_110\Lab 6 `study' -`c_date'.log", replace

sysdir set PLUS "\\Client\C$\ISF_110"

sysdir set PLUS "\\Client\C$\ISF_110"

ls

shp2dta using WB_countries_Admin0_10m, database(wb_data) coord(world_shp) genid (ID) replace

use wb_data, clear
br


gen gdp_pc = (GDP_MD_EST / POP_EST) * 1000000  //GDP estimates are given in millions of dollar

ssc install spmap, replace

spmap gdp_pc using world_shp, id(ID) fcolor(Blues)  
spmap gdp_pc using world_shp, id(ID) fcolor(Reds)

set more off
clear all






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
fcolor(Reds) legtitle("Fraction of respondents who were unhappy")  ///
title("Figure 3: Housing Price and Unhappiness by Census Division, 2012")




gen unemployment_Y = unemployment
format unemployment_Y %4.1f 

spmap unhappy using uscoord.dta, id(subreg_id)  ///
point(x(xcoord) y(ycoord) proportional(unemployment_Y) fcolor(red) ocolor(white) size(*3.5))  ///
label(label(subreg_id) xcoord(xcoord) ycoord(ycoord))  /// 
fcolor(Reds) legtitle("Fraction of respondents who were unemployed")  ///
title("Figure 3: Unemployment Rates and Unhappiness by Census Division, 2012")




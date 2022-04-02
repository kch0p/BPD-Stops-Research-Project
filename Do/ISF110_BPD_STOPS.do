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

use "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Data\All_Stops_WOW2"

sysdir set PLUS "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110"

cd "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110\Data
ls

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







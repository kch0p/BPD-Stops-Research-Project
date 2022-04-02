*******************************************
*********LAB 5 – DATA VISUALIZATION********
********Written by KC HARRIS **************
*******************************************
clear all
set more off
capt log close
local c_date = c(current_date)
local study "SP500"

log using "\\Client\C$\ISF_110\Lab 5 `study' -`c_date'.log", replace

use https://www.stata-press.com/data/r17/sp500

*Write down the exact number of days in the first three months here: 62 *

twoway dropline change date in 1/62, yline(0)

twoway dropline change date in 185/248, yline(0)

twoway bar high low date in 1/22



clear all  //this command will clear the previous data set from memory
webuse citytemp
br
graph bar tempjan tempjuly, over(region) stack

graph bar (mean) tempjuly tempjan, over(region) blabel(total)




clear all
webuse pop2000
replace maletotal = -maletotal  //use this command to put male on the left
twoway bar maletotal agegrp, horizontal || bar femtotal agegrp, horizontal



clear all
webuse uslifeexp
twoway (line le year)(scatter le year) (line le_male year) (line le_female year)

clear all
webuse uslifeexp
twoway (line le year)(scatter le year) (line le_bmale year) (line le_bfemale year)  
sum le_male le_female le_w le_b if year==1900
// keep if year = 1900 & year == 1990
// graph bar le_male le_female in 1/1




log close
exit, clear



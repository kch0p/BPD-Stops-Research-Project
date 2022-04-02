*******************************************
*********LAB 4 – SUMMARY STATISTICS********
********Written by KC HARRIS **************
*******************************************

clear all
set more off
capt log close
local c_date = c(current_date)
local study "auto"

sysuse auto.dta  //

log using "\\Client\C$\isf110 lab 4\Log\LOG `study' -`c_date'.log", replace


*First, describe your data by using the following command:

describe

*Look at the number of observations and variable labels. You should also notice that the dataset has notes attached: (_dta has notes). Type the following to see the notes:

notes

*Have a feel of the data by clicking on the Data Editor (Browse) button, or by selecting Data > Data Editor > Data Editor (Browse) from the menus or by typing the command:

browse

/*A dataset is far more than simply the data it contains. It is also information that makes the data usable by someone other than the original creator.

Although describing the data tells us something about the structure of the data, it says little about the data themselves. For this, we need summary statistics. We can get them using different commands. Try this first: */

codebook

/*Note if there are missing values in any variables. Also note the total number of observations, range, mean, SD, and median of each variable. Can you calculate the interpercentile or interquartile range from the data mpg? Answer the following questions based on your calculations.

No. of missing values for rep78: There are 5 missing repair records as of 1978. 

Median mpg: Median is the 50th percentile, which in this case is displayed as 20. 

The range between 25% and 75% for price: The difference between these two is 2147. */

di(6342 - 4195)

*To use Stata as a calculator, type: display or the shortcut:

di  //For example, di 50-20

* Another useful command for getting a quick overview of a data file is the inspect command. It also shows frequency distributions in bar graphs.

inspect

/*To get all the summary statistics in one table, simply type sum or on the menu bar, go to Statistics > Summaries, tables, and tests > Summary and descriptive statistics > Summary statistics and clicking on the OK button.

From this simple summary, we can learn a bit about the data. First of all, the prices are nothing like today’s car prices—of course, these cars are now antiques. We can see that the gas mileages are not particularly good—this is in 1978!*/

*We saw before that rep78 has some missing values. We can browse only those observations for which rep78 is missing, so we could type:

browse if missing(rep78) // This command uses two new concepts for Stata commands—the if qualifier and the missing() function.

*The same ends could be achieved by typing:

list make if missing(rep78)

*We cannot impute missing values because we do not see any patterns here.

/* We saw above that the summarize command gave brief summary statistics about all the variables. Suppose now that we became interested in the prices while summarizing the data because they seemed fantastically low (it was 1978, after all). To get an in-depth look at the price variable, we can use the menus and a dialog:
1. Select Statistics > Summaries, tables, and tests > Summary and descriptive statistics >
Summary statistics.
2. Enter or select price in the Variables field.
3. Select Display additional statistics.
4. Click on Submit.

Alternatively, typing summarize price, detail will get the same result. The portion after the comma contains options for Stata commands; hence, detail is an example of an option. */

/* From the output, answer the following questions: 

The median price of the cars in the dataset is:  5006.5. We can look at the detailed breakdown of price to find the percentiles, and from there the 50th percentile. 

The four most expensive cars are all priced between: (13466,15906)

If we wished to browse the most expensive, we could start by clicking on the Data Editor (Browse) button. Once the Data Editor is open, we can click on the Filter Observations button, to bring up the Filter Observations dialog. We can look at the expensive cars by putting price > 13000 in the ‘Filter by expression’ field. 

Pressing the Apply Filter, list the four most expensive cars in 1978. 
(FROM LEAST TO MOST EXPENSIVE)
Linc. Versailles
Linc. Mark V
Cad. Eldorado
Cad. Seville

Comment on their gas mileage and repair records. Besides, the seville, the other 3 most expensive cars have fairly low mpg, at least one sd below the mean. It's important to note however that mpg has a very high variance (approx 33), so this isn't alarming. It also appears that most of them have average-quality repair records, besides the eldorado. The eldorado rep78 rates at a 2, which is just slightly lower quality. All of the repair records are below the group average of 3.405797. 

*We now decide to turn our attention to foreign cars, mileage and repairs.

*Let’s start by looking at the proportion of foreign cars in the dataset along with the proportion of cars with each type of mileage and repair record. Type:*/

tab foreign

*What percentage of cars is foreign made? What percentage of cars is domestic? 29.73 percent of the cars are foreign made. 

tab mpg
tab rep78

*Note: 1 means a poor repair record and 5 means a good one. 

* These one-way tables do not help us compare the mileage and repair records of foreign and domestic cars. A two-way table would help greatly. Type:

tab rep78 foreign, row
tab rep78 foreign, col  //See the difference with row percentages

tab mpg foreign, row

*The tables are long and difficult to compare. Use:

sum rep78 if foreign==0
sum rep78 if foreign==1

sum mpg if foreign==0
sum mpg if foreign==1

*Note: We can reduce the lines of Stata command by writing: 

by foreign, sort : summarize mpg
by foreign, sort : summarize rep78

*Compare foreign cars with domestic cars in terms of repair records and mpg. WRITE A FEW SENTENCES HERE -> It appears that the foreign cars, on average, have both better mpg and better repair records. The average rep78 for a foreign car is very high - a 4.29, while for the domestic it sits at a 3.02. The mpg is also higher, but the std is also higher for foreign cars and we have a smaller number of observations, so my guess is that with more observations the mean mpgs would be more similar. 

*Now, we will do cross tabulation to produce some formatted tables. Type:*

tab foreign, summarize(mpg)
tab foreign, summarize(rep78)

tab rep78 foreign
tab rep78 foreign, column nofreq

*Finally, we will see some correlations. Type:

cor

*Interpret the correlation between weight and mpg, and foreign and rep78. What do the results say, when investigating collinearity among predictor variables for price? MPG significantly decreases as weight increases. There is a strong negative correlation there. There is a positive correlation between foreign and rep78, but I'm not certain that this indicates much. It's possible this could just suggest that a foreign car is more LIKELY to have a more extensive record, not necesessarily that foreign car records are inherently better. 


*End of Lab*

log close
exit, clear

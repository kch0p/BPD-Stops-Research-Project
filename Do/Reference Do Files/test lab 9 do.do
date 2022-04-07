
webuse nhanes2f, clear

// Run a curvilinear regression with the DV and IVs (using the reg command), obtain the fitted values, and graph them against observed values. Does the line/model fit the data? Why?

reg diabetes age
predict y
twoway scatter y diabetes age, connect(1 .)


// Now run a logistic model with the same DV and IVs but obtain the fitted values and graph using the following command: marginscontplot or mcp in short. To use this command, you need to first install it using the following command:

// sysdir set PLUS "\\Client\C$\Users\kharr\Documents\GitHub\Berkeley-PD-ISF-110"
// ssc install mcp2

logit diabetes age
predict y1
twoway scatter y1 diabetes age, connect(1 .) sort
 

logit diabetes black female age
mcp2 age

// After running the logistic model, run

mcp2

// Does the line/model fit the data better? Note that the lower confidence interval shows a curvilinear pattern. But our age variable has only this range (20-74). Check it using the sum command. We can “project” the trend line beyond age 74, say to 100, to see if later ages show a curvilinear patter for diabetes diagnosis. To see this, run the following commands:

logit diabetes black female age c.age#c.age, or  //the last variable is an interaction term for age (with later age).
mcp2 age, at1(20(1)100)  //at1 is an option to project the age range to 20-100 with a 20-year interval.

// What does the graph say? Compare this graph with the one obtained from curvilinear regression above. Which model to choose – curvilinear or logistic?

// Now, obtain separate graphs for “age and black” and “age and female”:

mcp2 age black, at1(20(1)100)
mcp2 age female, at1(20(1)100)


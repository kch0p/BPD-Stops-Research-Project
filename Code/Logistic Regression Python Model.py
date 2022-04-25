# -*- coding: utf-8 -*-
import pandas as pd
from matplotlib import pyplot as plt

df = pd.read_csv('formatted_allstops(expanded)(2).csv')

#STEP 2: DATA PREPARATION - DROP IRRELEVANT DATA
df = df[['durationofstop', 'raceperceivedpriortostop', 'perceivedraceorethnicity',
        'gender', 'perceivedage', 'reasonforstop', 'resultofstop', 
        'informationbasedstop', 'typeofstop', 'censustract', 'tract_medianincome',
        'tract_totalpop', 'tract_whitepop', 'tract_nonwhitecomp',
        'tract_poccomp', 'tract_nonwhitepop', 'tract_pocpop',
        'tract_aapop', 'tract_na_aipop', 'tract_aisianpop',
        'tract_hawaiian', 'tract_mixed2', 'tract_totalnumstops',
        'tract_annualstops', 'tract_distancefromcal']]


#STEP 3: CODING VALUES
df.perceivedraceorethnicity[df.perceivedraceorethnicity == 'White'] = 2

df.perceivedraceorethnicity[df.perceivedraceorethnicity == 'Black/African American'] = 3
df.perceivedraceorethnicity[df.perceivedraceorethnicity ==  'Black'] = 3

# df.perceivedraceorethnicity[df.perceivedraceorethnicity=="Hispanic/Latino"] = 4 
df.perceivedraceorethnicity[df.perceivedraceorethnicity=="Hispanic"] = 4

df.perceivedraceorethnicity[df.perceivedraceorethnicity == 'Asian'] = 5
df.perceivedraceorethnicity[df.perceivedraceorethnicity != 2 &
                            df.perceivedraceorethnicity != 3 &
                            df.perceivedraceorethnicity != 4 & 
                            df.perceivedraceorethnicity != 5] = 1





# gen race = 1
# replace race = 2 if perceivedraceorethnicity=="White"  
# replace race = 3 if perceivedraceorethnicity=="Black/African American" |  perceivedraceorethnicity=="Black"
# replace race = 4 if perceivedraceorethnicity=="Hispanic/Latino" |  perceivedraceorethnicity=="Hispanic"
# replace race = 5 if perceivedraceorethnicity=="Asian"   
# replace race = 1 if !inlist(race,1,2,3,4,5)
# lab def race 1 "Other" 2 "White" 3 "Black/African American" 4 "Hispanic/Latino" 5 "Asian" 
# lab value race race
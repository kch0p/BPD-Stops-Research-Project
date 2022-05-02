# -*- coding: utf-8 -*-
"""
Created on Wed Apr 27 17:33:38 2022

@author: kharr
"""

# -*- coding: utf-8 -*-
import pandas as pd
from matplotlib import pyplot as plt
import numpy as np
import warnings
import statistics as st 
import sys


warnings.filterwarnings("ignore")

df = pd.read_csv('formatted_allstops(expanded)(2).csv')

#STEP 2: DATA PREPARATION - DROP IRRELEVANT DATA AND CONVERT TO CORRECT FORMAT
df = df[['durationofstop', 'raceperceivedpriortostop',                 
         'perceivedraceorethnicity', 'resultofstop',
        'gender', 'perceivedage',  
        'typeofstop', 'tract_medianincome',
        'tract_totalpop', 'tract_whitepop', 'tract_nonwhitecomp',
        'tract_poccomp', 'tract_nonwhitepop', 'tract_pocpop',
        'tract_aapop', 'tract_na_aipop', 'tract_aisianpop',
        'tract_hawaiian', 'tract_mixed2', 'tract_totalnumstops',
        'tract_annualstops', 'tract_distancefromcal']]




#STEP 3: CODING VALUES
df.perceivedraceorethnicity[df.perceivedraceorethnicity == 'White'] = 2
df.perceivedraceorethnicity[df.perceivedraceorethnicity == 'Black/African American'] = 3
df.perceivedraceorethnicity[df.perceivedraceorethnicity ==  'Black'] = 3
df.perceivedraceorethnicity[df.perceivedraceorethnicity=="Hispanic/Latino"] = 4 
df.perceivedraceorethnicity[df.perceivedraceorethnicity=="Hispanic"] = 4
df.perceivedraceorethnicity[df.perceivedraceorethnicity == 'Asian'] = 5
df[~df['perceivedraceorethnicity'].isin([2,3,4,5])] = 1
# print(f'the value counts for ethnicity are {df.perceivedraceorethnicity.value_counts()}\n')
# sys.exit('Look it worked!')



df['black'] = 0
df['white'] = 0
df['asian'] = 0
df['hispanic'] = 0
for i in range(df.index.size):
    if df.loc[i,'perceivedraceorethnicity'] == 3:
        df.loc[i,'black'] = 1
    elif df.loc[i,'perceivedraceorethnicity'] == 2:
        df.loc[i,'white'] = 1
    elif df.loc[i,'perceivedraceorethnicity'] == 5:
        df.loc[i,'asian'] = 1
    elif df.loc[i,'perceivedraceorethnicity'] == 4:
        df.loc[i,'hispanic'] = 1
        
        
df['bipoc'] = np.where(df['perceivedraceorethnicity'] != 2, 1,0)
df['report_risk_groups'] = np.where(df['perceivedraceorethnicity'].isin([1,3,4]), 1,0)
df.drop(columns=['perceivedraceorethnicity'], inplace=True)
# print(f'the value counts for risk groups: \n {df.report_risk_groups.value_counts()}\n')
# sys.exit()




df.gender[df.gender == 'Male'] = 1
df.gender[df.gender == 'Female'] = 2
df[~df['gender'].isin([1,2])] = 3
# print(f'the value counts for gender are {df.gender.value_counts()}\n')
# sys.exit('Look it worked!')



df['arrest'] = np.where(df['resultofstop'].str.contains('arrest'), 1,0)
df = df.drop(columns=['resultofstop'])
# print(f'the value counts for arrests are: \n {df.arrest.value_counts()}\n')



df.typeofstop[df.typeofstop == 'Vehicle'] = 1
df.typeofstop[df.typeofstop == 'Pedestrian'] = 2 
df.typeofstop[df.typeofstop == 'Bicycle'] = 3
df['trafficstop'] = np.where(df['typeofstop']==1, 1,0)
df = df.drop(columns=['typeofstop'])




df['raceperceivedpriortostop'] = np.where(df['raceperceivedpriortostop']==True, 1,0)
# print(f'the value counts for race perceived prior are {df.raceperceivedpriortostop.value_counts()}\n')
# sys.exit('Look it worked!')

averagestopduration = round(st.mean(df.durationofstop),2)
df['longstop'] = np.where(df['durationofstop'] > averagestopduration, 1,0)
df = df[df['durationofstop'] < 270]
# print(df.longstop.value_counts())
# sys.exit('Look it worked!')



# sys.exit('first part works!')
    
    
import seaborn as sns; sns.set_theme(color_codes=True)
ax = sns.regplot(x="durationofstop", y="arrest", data=df, logistic=True)
    
    
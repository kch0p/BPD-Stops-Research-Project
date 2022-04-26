# -*- coding: utf-8 -*-
import pandas as pd
from matplotlib import pyplot as plt
import numpy as np
import warnings


warnings.filterwarnings("ignore")

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

df.perceivedraceorethnicity[df.perceivedraceorethnicity=="Hispanic/Latino"] = 4 
df.perceivedraceorethnicity[df.perceivedraceorethnicity=="Hispanic"] = 4

df.perceivedraceorethnicity[df.perceivedraceorethnicity == 'Asian'] = 5

for i in range(df.index.size):
    if df.loc[i,'perceivedraceorethnicity'] in (2,3,4,5):
        continue
    else:
        df.loc[i,'perceivedraceorethnicity'] = 1

# print(f'the value counts for race are: \n {df.perceivedraceorethnicity.value_counts()}')





df.gender[df.gender == 'Male'] = 1
df.gender[df.gender == 'Female'] = 2
for i in range(df.index.size):
    if df.loc[i,'gender'] in (1,2):
        continue
    else:
        df.loc[i,'gender'] = 3




df['arrest'] = df['resultofstop']

for i in range(df.index.size):
    substring = 'arrest'
    fullstring = df.loc[i, 'arrest'] 
    
    if substring in fullstring:
        df.loc[i, 'arrest'] = 1
    else:
        df.loc[i, 'arrest'] = 0
# print(f'the value counts for arrests are: \n {df.arrest.value_counts()}')


df.typeofstop[df.typeofstop == 'Vehicle'] = 1
df.typeofstop[df.typeofstop == 'Pedestrian'] = 2 
df.typeofstop[df.typeofstop == 'Bicycle'] = 3




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





          
          
          
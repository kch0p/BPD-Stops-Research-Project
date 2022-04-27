# -*- coding: utf-8 -*-
import pandas as pd
from matplotlib import pyplot as plt
import numpy as np
import warnings
import statistics as st 


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


# df[['tract_medianincome','tract_totalpop', 'tract_whitepop', 'tract_nonwhitecomp','tract_poccomp', 'tract_nonwhitepop', 'tract_pocpop',
# 'tract_aapop', 'tract_na_aipop', 'tract_aisianpop','tract_hawaiian', 'tract_mixed2', 'tract_totalnumstops','tract_annualstops', 'tract_distancefromcal']].apply(pd.to_numeric)


print(f'nice! the size after dropping is {df.shape}')

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
# print(f'the value counts for race are: \n {df.perceivedraceorethnicity.value_counts()}')





df.gender[df.gender == 'Male'] = 1
df.gender[df.gender == 'Female'] = 2
for i in range(df.index.size):
    if df.loc[i,'gender'] in (1,2):
        continue
    else:
        df.loc[i,'gender'] = 3



# df['arrest'] = np.where(df['raceperceivedpriortostop']==True, 1,0)

df['arrest'] = df['resultofstop']
for i in range(df.index.size):
    substring = 'arrest'
    fullstring = df.loc[i, 'resultofstop'] 
    
    if substring in fullstring:
        df.loc[i, 'resultofstop'] = 1
    else:
        df.loc[i, 'resultofstop'] = 0
print(f'the value counts for arrests are: \n {df.arrest.value_counts()}')


df.typeofstop[df.typeofstop == 'Vehicle'] = 1
df.typeofstop[df.typeofstop == 'Pedestrian'] = 2 
df.typeofstop[df.typeofstop == 'Bicycle'] = 3

df['trafficstop'] = 0
for i in range(df.index.size):
    if df.loc[i,'typeofstop'] == 1:
        df.loc[i,'trafficstop'] = 1
        
    elif df.loc[i,'typeofstop'] != 1:
        df.loc[i,'trafficstop'] = 0




df['PERCEPTION'] = np.where(df['raceperceivedpriortostop']==True, 1,0)
df = df.drop(columns=['raceperceivedpriortostop'])


# df.raceperceivedpriortostop[df.raceperceivedpriortostop == 'FALSE'] = 0
# df.raceperceivedpriortostop[df.raceperceivedpriortostop == 'TRUE'] = 1


# df['wasraceperceived']
# # for i in range(df.index.size):
# #     if df.loc[i,'raceperceivedpriortostop'] == 'TRUE':
# #         df.loc[i,'raceperceivedpriortostop'] = 1
        
# #     elif df.loc[i,'raceperceivedpriortostop'] != 'TRUE':
# #         df.loc[i,'raceperceivedpriortostop'] = 0
# # print('how does TRUE look now?')


# df['wasraceperceived'] = df[df['raceperceivedpriortostop'] == 'TRUE']










averagestopduration = round(st.mean(df.durationofstop),2)
df['longstop'] = 0
for i in range(df.index.size):
    if df.loc[i,'durationofstop'] <= averagestopduration:
        df.loc[i,'longstop'] = 0
        
    elif df.loc[i,'typeofstop'] >= 1:
        df.loc[i,'longstop'] = 1
          
        
df['bipoc'] = 0
for i in range(df.index.size):
    if df.loc[i,'perceivedraceorethnicity'] == 2:
        df.loc[i,'bipoc'] = 0
    else:
        df.loc[i,'bipoc'] = 1
        
        
df['report_risk_groups'] = 0
for i in range(df.index.size):
    if df.loc[i,'perceivedraceorethnicity'] == 2:
        df.loc[i,'report_risk_groups'] = 0
    elif df.loc[i,'perceivedraceorethnicity'] in(1,3,4):
        df.loc[i,'report_risk_groups'] = 1 
    
    
    
    
#STEP 4: PREPARE DEPENDENT VARIABLES
Y1 = df['arrest'].values
X1 = df.drop(columns=['arrest'])
print(X1.head())



#STEP 5: SPLIT THE DATA 
# from sklearn.model_selection import train_test_split

# X_train, X_test, y_train, y_test = train_test_split(X1,Y1, test_size=0.4, random_state=20)
# print(X_test)


#STEP 5: SELECT THE MODEL 
from sklearn.linear_model import LogisticRegression 

model = LogisticRegression()
model.fit(X1,Y1)


# STEP 6: SKIP TESTING, EXAMINE MODEL
print(model.coef_)











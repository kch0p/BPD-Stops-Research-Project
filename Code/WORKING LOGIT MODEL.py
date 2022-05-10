# -*- coding: utf-8 -*-
"""
Created on Thu May  5 13:54:33 2022

@author: kharr

based on this guide: https://www.andrewvillazon.com/logistic-regression-python-statsmodels/#setting-a-reference-or-base-level-for-categorical-variables
"""

import pandas as pd
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



df['black'] = np.where(df['perceivedraceorethnicity'] == 3, 1,0)
np.where(df['black'] == 3, 0,0)
df['white'] = np.where(df['perceivedraceorethnicity'] == 2, 1,0)
np.where(df['white'] == 3, 0,0)
df['asian'] = np.where(df['perceivedraceorethnicity'] == 5, 1,0)
np.where(df['asian'] == 3, 0,0)
df['hispanic'] = np.where(df['perceivedraceorethnicity'] == 4, 1,0)
np.where(df['hispanic'] == 3, 0,0)

# df.rename(columns={'tract_nonwhitecomp':'tract_bipoc','tract_poccomp':'tract_reportfocusgroupcomp',''})

        
df['bipoc'] = np.where(df['perceivedraceorethnicity'] != 2, 1,0)
np.where(df['bipoc'] == 3, 0,0)

df['report_risk_groups'] = np.where(df['perceivedraceorethnicity'].isin([1,3,4]), 1,0)
df.report_risk_groups[df.report_risk_groups == 3] = 0
# df.drop(columns=['perceivedraceorethnicity'], inplace=True)
# print(f'the value counts for risk groups: \n {df.report_risk_groups.value_counts()}\n')
# sys.exit()




df.gender[df.gender == 'Male'] = 1
df.gender[df.gender == 'Female'] = 0
df[~df['gender'].isin([1,0])] = 3
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


averagestopduration = round(st.mean(df.durationofstop),2) 
df['longstop'] = np.where(df['durationofstop'] > averagestopduration, 1,0)
df = df[df['durationofstop'] < 270]


df_og = df[(df['black'] != 3) & (df['white'] != 3) & (df['asian'] != 3) & (df['hispanic'] != 3)]
df = df_og[['arrest','black','white','hispanic','bipoc','asian','report_risk_groups','perceivedage','gender',
            'trafficstop','raceperceivedpriortostop',
            'tract_distancefromcal','tract_totalpop','tract_medianincome','tract_annualstops','tract_nonwhitecomp']]
df = df[df['tract_totalpop'] > 1500]


# cols = df.columns
# df[cols] = df[cols].apply(pd.to_numeric, errors='coerce')


# df.dtypes
# for col in df: 
#     print(col,'\n',df[col].value_counts(),'\n\n')

# sys.exit('stop! one sec')


#PART 2 BUILDING THE MODEL
import pandas as pd
import numpy as np
import statsmodels.formula.api as smf

######## OUTPUT ALL FORMULAS TO A .DOCX

race_options = ['white','black','hispanic','asian','report_risk_groups','bipoc']

# my_doc = docx.Document()

for race in race_options:
    formula = f"arrest ~ C({race}, Treatment(reference=0)) + perceivedage + C(gender, Treatment(reference=0)) + \
                C(trafficstop, Treatment(reference=0)) + C(raceperceivedpriortostop, Treatment(reference=0)) + \
                tract_distancefromcal + tract_totalpop + tract_medianincome + tract_annualstops + tract_nonwhitecomp"
    log_reg = smf.logit(formula, data = df).fit()
    odds_ratios = pd.DataFrame(
        {
            "OR": log_reg.params,
            "Lower CI": log_reg.conf_int()[0],
            "Upper CI": log_reg.conf_int()[1],
        }
    )    
#     my_doc.add_paragraph(f"{race}\n\n\n{np.exp(odds_ratios)}\n\n\n{log_reg.summary()}\n\n\n\n\n\n\n\n\n\n\n\n")
# my_doc.save("out.docx")

    print(f"{race} model\n{np.exp(odds_ratios)}\n\n\n")
    print(f"{log_reg.summary()}\n\n\n\n\n\n\n\n\n")
    




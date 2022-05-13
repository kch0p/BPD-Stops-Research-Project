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

df = pd.read_csv('formatted_allstops_large(expanded) (2).csv')

#STEP 2: DATA PREPARATION - DROP IRRELEVANT DATA AND CONVERT TO CORRECT FORMAT
df = df[['perceivedraceorethnicity', 'resultofstop',
         'perceivedgender', 'perceivedage',  
         'typeofstop', 'tract_medianincome',
         'tract_totalpop', 'tract_whitepop', 'tract_bipoccomp',
         'tract_aapop', 'tract_na_aipop', 'tract_aisianpop',
         'tract_mixed2',
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


        
df['bipoc'] = np.where(df['perceivedraceorethnicity'] != 2, 1,0)
np.where(df['bipoc'] == 3, 0,0)

df['report_risk_groups'] = np.where(df['perceivedraceorethnicity'].isin([1,3,4]), 1,0)
df.report_risk_groups[df.report_risk_groups == 3] = 0
# df.drop(columns=['perceivedraceorethnicity'], inplace=True)
# print(f'the value counts for risk groups: \n {df.report_risk_groups.value_counts()}\n')
# sys.exit()




df.perceivedgender[df.perceivedgender == 'Male'] = 1
df.perceivedgender[df.perceivedgender == 'Female'] = 0
df[~df['perceivedgender'].isin([1,0])] = 3
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





df_og = df[(df['black'] != 3) & (df['white'] != 3) & (df['asian'] != 3) & (df['hispanic'] != 3)]
df = df_og[['arrest','black','white','hispanic','bipoc','asian','report_risk_groups','perceivedage','perceivedgender',
            'trafficstop',
            'tract_distancefromcal','tract_totalpop','tract_medianincome','tract_annualstops','tract_bipoccomp']]
df['perceivedage'] = df['perceivedage'].apply(pd.to_numeric, errors='coerce')
df = df[df['tract_totalpop'] > 1500]

# cols = df.columns
# df[cols] = df[cols].apply(pd.to_numeric, errors='coerce')


# df.dtypes
# for col in df: 
#     print(col,'\n',df[col].value_counts(),'\n\n')

# print(f'okay here\'s the dtype for perceivedage {df.perceivedage.dtype}')

# print(df['white'].isnull().values.any()
# ,df['black'].isnull().values.any()
# ,df['hispanic'].isnull().values.any()
# ,df['asian'].isnull().values.any()
# ,df['report_risk_groups'].isnull().values.any()
# ,df['bipoc'].isnull().values.any()
# ,df['perceivedage'].isnull().values.any(),'DOG'
# ,df['perceivedgender'].isnull().values.any()
# ,df['trafficstop'].isnull().values.any()
# ,df['tract_distancefromcal'].isnull().values.any()
# ,df['tract_annualstops'].isnull().values.any()
# ,df['tract_bipoccomp'].isnull().values.any()
# )
# sys.exit('okay stop here! check your val counts')





#PART 2 BUILDING THE MODEL
import pandas as pd
import numpy as np
import statsmodels.formula.api as smf

######## OUTPUT ALL FORMULAS TO A .DOCX

race_options = ['white','black','hispanic','asian','report_risk_groups','bipoc']

# my_doc = docx.Document()

for race in race_options:
    # formula = f"arrest ~ C({race}, Treatment(reference=0)) + perceivedage + C(perceivedgender, Treatment(reference=0)) + \
    #             C(trafficstop, Treatment(reference=0))"
                
    formula = f"arrest ~ C({race}, Treatment(reference=0))  + C(perceivedgender, Treatment(reference=0)) + \
                C(trafficstop, Treatment(reference=0)) + \
                tract_distancefromcal + tract_totalpop + tract_medianincome + tract_annualstops + tract_bipoccomp"
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
    




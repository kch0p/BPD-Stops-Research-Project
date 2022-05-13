# -*- coding: utf-8 -*-
"""
Created on Thu May 12 15:16:16 2022

@author: kharr
"""
import pandas as pd
import numpy as np
import statsmodels.formula.api as smf

df = pd.read_csv('Coded Small DF.csv')

race_options = ['white','black','hispanic','asian','report_risk_groups','bipoc']


for race in race_options:
    formula = f"arrest ~ C({race}, Treatment(reference=0)) + perceivedage + C(perceivedgender, Treatment(reference=0)) + \
                C(trafficstop, Treatment(reference=0)) + C(raceperceivedpriortostop, Treatment(reference=0)) + \
                tract_distancefromcal + tract_totalpop + tract_medianincome + tract_annualstops + tract_bipoccomp"
    log_reg = smf.logit(formula, data = df).fit()
    results = log_reg.summary()
    OR = pd.DataFrame(
        {
            "OR": log_reg.params,
            "Lower CI": log_reg.conf_int()[0],
            "Upper CI": log_reg.conf_int()[1],
        },
    )
    OR = np.exp(OR)
#     odds_ratios.rename(index={'Intercept', f'{race}','Male','Traffic Stop','Age','Distance from Cal','Total Pop','Median Income','Annual Average Stops','BIPOC Comp'})
    
    print(f"\n\n{race} model (SMALL)\n{OR}\n\n\n{results}\n\n\n\n\n\n\n\n\n")
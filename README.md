# Berkeley PD ISF 110
 
***TLDR**: Web Notebooks for Project [HERE](https://rawcdn.githack.com/kch0p/BPD-Stops-Research-Project/30dad330a101c7a2836556e974190913f5fb65ca/Exports/Final%20Exports/Web%20Presentation/Web%20Presentation%20(BPD%20PROJECT).html) and [HERE](https://github.com/kch0p/BPD-Stops-Research-Project/blob/main/Exports/Final%20Exports/Project%20Notebook/BPD%20Project%20Notebook%20(KC%20HARRIS).ipynb).*
 
This is the github for a research project analyzing police stops in the city of Berkeley from 2015-2022. This continues the work done by the Center for Policing Equity in [their 2018 report](https://newspack-berkeleyside-cityside.s3.amazonaws.com/wp-content/uploads/2018/05/Berkeley-Report-May-2018.pdf) on racial disparities in Berkeley police stops, but focuses on publicly available stops data that **incorporates more recent RIPA-Compliant information** that's been collected since late 2020. The total dataset (2015-2022) encompasses approximately 65k stops, and has 10 shared and 45 overall features.  

Stops data for this project is made available by the [City of Berkeley's Open Data Portal](https://data.cityofberkeley.info/), and is freely available to the public. Race data by census tracts is sourced from 2020 census data, with the specific table for this project available [here](https://data.census.gov/cedsci/table?t=Race%20and%20Ethnicity&g=1400000US060014,06001421100,06001421200,06001421300,06001421400,06001421500,06001421600,06001421700,06001421800,06001421900,06001422000,06001422100,06001422200,06001422300,06001422400,06001422500). GeoJson mapping files for the City of Berkeley are available [here](https://data.cityofberkeley.info/Public-Safety/Berkeley-PD-Police-Beats-2015-2016/hccy-runn#:~:text=Shapefile-,GeoJSON,-Download%20a%20non).
  
![App Screenshot](https://github.com/kch0p/BPD-Stops-Research-Project/blob/main/GitHub%20Presentation%20Files/Berkeley%20PD%20-%20Stop%20Data%20(October%201%202020%20-%20Present)%20Open%20Data%20City%20of%20Berkeley.png)

  


### Project Summary

This project aims to look for racial disparities in stop outcomes now that the City of Berkeley's stops data is [RIPA-compliant](https://post.ca.gov/Racial-and-Identity-Profiling-Act). As a supplement to the CPE's 2018 report, this research looks at more recent RIPA-compliant data that has more information about the subject being stopped, including if their race was perceived prior to the stop. We broadly revisit general questions about proportions of arrests by race, neighborhood, etc. but also create logistic regression models to compare the same arrest outcomes for different racial groups. A similar pattern of higher arrest rates was found for Black, Hispanic, Asian, and overall BIPOC subjects vs White subjects, however more specifically it was also found that the perception of race alone, regardless of race, also seriously influenced the outcome of a stop. 

**This is not only a follow-up to the previous report, but also an attempt at a snapshot of Berkeley's progress on the matter before [major changes](https://www.berkeleyside.org/2022/05/06/berkeley-city-council-approves-police-reimagining-package) to the city's rules regarding traffic stops begin to go into effect in 2023-2025.**

Additionally, the report analyzes if other factors like Distance from the University, Perceived Age, Neighborhood Racial Composition, or Area Annual Stops Averages affected stop outcomes. Interestingly, almost all factors not related to race either weren't significant, or were significant but had effectively no influence on the likelihood of arrest. 

Current work is being done to do the following: 
* Calculate yield rates by race and compare this against Berkeley's population composition
* Possibly obtain additional stops data from before 2015 from the city, and/or obtain recent use-of-force data
* Improve on existing maps and create live displays
* Further research and organize literature on yield rates, traffic stop legislation changes, and RIPA effects in other cities


![App Screenshot](https://github.com/kch0p/BPD-Stops-Research-Project/blob/main/GitHub%20Presentation%20Files/Duration%20Boxplot%20by%20Race%20(TEXT).png)
![Gif](https://github.com/kch0p/BPD-Stops-Research-Project/blob/main/GitHub%20Presentation%20Files/map_preview_gif.gif)
![App Screenshot](https://github.com/kch0p/BPD-Stops-Research-Project/blob/main/GitHub%20Presentation%20Files/logit_model_comparison.png)



### Learn More 
If you'd like to see more of the work done in the project, I've linked the current resources below!
* [Project Landing Page](https://www.notion.so/karatechop/ISF-BPD-Analysis-Landing-Page-162fb1015f8c4ff38b269d93c40ca216) (with more news/reports resources)
* [Research Presentation from Junior Year](https://docs.google.com/presentation/d/1gxzAV4evgyhWNZ6g-F8-rggxMzqc0GQfbHAsvXd6KUs/edit#slide=id.p)
* [Interactive Map](https://rawcdn.githack.com/kch0p/BPD-Stops-Research-Project/1bd281fb61243587499ac4c364757e938e14d491/Exports/Interactive%20Full%20Heatmap.html) of Berkeley Stops
* [Web Notebook](https://rawcdn.githack.com/kch0p/BPD-Stops-Research-Project/30dad330a101c7a2836556e974190913f5fb65ca/Exports/Final%20Exports/Web%20Presentation/Web%20Presentation%20(BPD%20PROJECT).html) Version of the Report
* [Original CPE Report](https://newspack-berkeleyside-cityside.s3.amazonaws.com/wp-content/uploads/2018/05/Berkeley-Report-May-2018.pdf)


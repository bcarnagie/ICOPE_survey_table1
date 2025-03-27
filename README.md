# I-COPE Survey: Table 1 Analysis


This repository contains a SAS script used to generate Table 1 from the I-COPE survey, which includes descriptive and stratified statistics on sociodemographic and clinical variables among people living with HIV (PLHIV) in Kenya.

## 🎯 Objective
To prepare Table 1 and supporting analyses for an HIV-focused public health study using cleaned and derived survey data.

## 🔧 Tools
- SAS 9.4
- `PROC FREQ`, `PROC MEANS`, `PROC IMPORT`, `PROC SGPLOT`, `INTCK`, and date manipulation functions

## 📁 File Overview
- `icope_table1_analysis.sas`: Core SAS script for cleaning, transforming, and analyzing the dataset

## 📊 Key Features
- Derived variables: gender, age bins, marital status, education levels, employment, vaccination status
- Time since HIV diagnosis and recent viral load (in years)
- Stratified analyses by facility
- Visualizations: age histogram with normal curve, household size bar plot
- Chi-square tests for categorical comparisons

## ⚠️ Data Note
This script does not include source data. Variable names and logic reflect a de-identified `.dta` dataset not shared due to privacy.

## 🧪 Sample Variables
- `bl_age`, `bl_gender`, `bl_marital`, `mr_vlrecent`
- Derived: `age_group`, `edu_level`, `time_since_diagnosis_years`

## 👩🏽‍💻 Author
Brianna Carnagie, CHES®  
MPH in Epidemiology, Columbia University  
GitHub: [@bcarnagie](https://github.com/bcarnagie)

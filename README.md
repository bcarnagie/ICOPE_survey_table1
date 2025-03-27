# I-COPE Study: SARS-CoV-2 Seroprevalence and Impact of COVID-19 among People Living with HIV in Kenya

This repository contains SAS code used to generate descriptive statistics and visualizations for Table 1 and Table 2 of the I-COPE Study, which explores the seroprevalence of SARS-CoV-2 and the impact of COVID-19 among people living with HIV in Kenya.

## 📌 Objective
To generate baseline characteristics (Table 1), COVID-19 vaccination uptake patterns (Table 2), and stratified statistics by healthcare facility for individuals enrolled in the I-COPE study using survey and clinical data.

## 📂 File Summary
- `icope_table1_analysis.sas`: SAS script for data import, cleaning, derivation of key variables, descriptive statistics, visualizations, and time-based calculations (Table 1).
- `icope_table2_vaccine_analysis.sas`: SAS script focused on COVID-19 vaccination data, including series completion, booster uptake, timing between doses, and adoption phase categorization (Table 2).

## 🧰 Tools Used
- **SAS 9.4** 
- Procedures used: `PROC IMPORT`, `PROC FREQ`, `PROC MEANS`, `PROC FORMAT`, `PROC UNIVARIATE`, `PROC SGPLOT`, `PROC CONTENTS`
- Date manipulation using `MDY`, `INTCK`, `PUT`, and conditional logic

## 📊 Key Features

### Table 1
- Derived variables for age group, gender, marital status, education, employment, vaccination status, and viral load category
- Stratified frequency tables and chi-square tests by facility (`es_hf`)
- Travel time normalization and household size categorization
- Calculation of time since HIV diagnosis and recent viral load
- Histograms and bar plots

### Table 2
- Vaccine series and booster completion status based on dose and type
- Substitution of missing baseline values with medical record data
- Month/year extraction from vaccination dates and categorization into adopter phases
- Derivation of time intervals between first and second doses
- Two-week increment grouping for vaccination timing visualization
- Comparison of vaccination variables by adopter phase, gender, age, and facility

## ⚠️ Data Disclaimer
The original dataset is not included in this repository due to privacy restrictions. The code is designed to work with a `.dta` file containing de-identified survey and clinical data.

If you wish to test the code, consider creating a mock dataset with the same variable structure.

## 🧪 Example Variables
- `bl_age`, `bl_gender`, `bl_marital`, `mr_vlrecent`, `bl_vax`, `bl_vaxtype`, `bl_vaxdoses`, `mr_vax`, `mr_vaxdose`
- Derived: `age_group`, `edu_level`, `time_since_diagnosis_years`, `adopter_status`, `vax_series_completed`, `mrvax_2weeks`

## 👩🏽‍💻 Author
**Brianna Carnagie, CHES®**  
MPH in Epidemiology, Columbia University  
GitHub: [@bcarnagie](https://github.com/bcarnagie)

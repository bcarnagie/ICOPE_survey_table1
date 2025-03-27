# I-COPE Study: SARS-CoV-2 Seroprevalence and Impact of COVID-19 among People Living with HIV in Kenya

This repository contains SAS code used to generate descriptive statistics and visualizations for Table 1 of the I-COPE Study, which explores the seroprevalence of SARS-CoV-2 and the impact of COVID-19 among people living with HIV in Kenya.

## 📌 Objective
To generate baseline characteristics (Table 1) and stratified statistics by healthcare facility for individuals enrolled in the I-COPE study using survey and clinical data.

## 📂 File Summary
- `icope_table1_analysis.sas`: SAS script containing all steps from data import, cleaning, derivation of key variables, summary statistics, visualizations, and time-based calculations.

## 🧰 Tools Used
- **SAS 9.4** 
- Procedures used: `PROC IMPORT`, `PROC FREQ`, `PROC MEANS`, `PROC SGPLOT`, `PROC FORMAT`, `PROC UNIVARIATE`
- Date manipulation using `MDY`, `INTCK`, and derived date variables

## 📊 Key Features
- Derived variables for age group, gender, marital status, education, employment, vaccination status, and viral load category
- Stratified frequency tables and chi-square tests by facility (`es_hf`)
- Travel time normalization and household size categorization
- Calculation of time since HIV diagnosis and recent viral load using SAS date functions
- Histograms and bar plots for key demographic and clinical variables

## ⚠️ Data Disclaimer
The original dataset is not included in this repository due to privacy restrictions. The code is designed to work with a `.dta` file containing de-identified survey and clinical data.

## 🧪 Example Variables
- `bl_age`, `bl_gender`, `bl_marital`, `mr_vlrecent`
- Derived: `age_group`, `edu_level`, `time_since_diagnosis_years`

## 📄 License
This project is licensed under the MIT License. See `LICENSE` for details.

## 👩🏽‍💻 Author
**Brianna Carnagie, CHES®**  
MPH in Epidemiology, Columbia University  
GitHub: [@bcarnagie](https://github.com/bcarnagie)

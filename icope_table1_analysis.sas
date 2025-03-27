********************************************************
* ICOPE Survey Table 1 Analysis                        *
* -----------------------------------------------------*
* Author: Brianna Carnagie                            *
* Date: 05-24-2023                                    *
* Purpose: Generate Table 1 and related stats         *
********************************************************;

/*******************
 * IMPORT & CLEAN  *
 *******************/

proc datasets library=work kill nolist;
quit;

proc import datafile="~/icope/cleaned_data.dta"
    out=work.icope_initial
    dbms=dta;
run;

/* Retain only necessary variables */
data icope.table1_raw;
    set work.icope_initial (keep=PTID es_hf bl_age bl_gender bl_marital bl_vax bl_employ 
        bl_school bl_schoolhighest bl_travhrs bl_travmins bl_date 
        mr_hivdiagyear mr_hivdiagday mr_hivdiagmonth 
        bl_dateyear bl_datemonth bl_dateday 
        mr_vlrecentyear mr_vlrecentmonth mr_vlrecentday
        bl_occup___1-bl_occup___12 bl_occup___96 
        bl_hhsize bl_preg mr_preg mr_cd4base mr_vlrecent cv_arvcurr);
run;

/*************************
 * VARIABLE DERIVATIONS  *
 *************************/

data icope.table1_cleaned;
    set icope.table1_raw;

    /* Gender */
    if bl_gender = 1 then gender = "Male";
    else if bl_gender = 2 then gender = "Female";

    /* Age categories */
    length age_group $15;
    if bl_age < 30 then age_group = "<30";
    else if 30 <= bl_age <= 39 then age_group = "30-39";
    else if 40 <= bl_age <= 49 then age_group = "40-49";
    else if 50 <= bl_age <= 59 then age_group = "50-59";
    else if 60 <= bl_age <= 69 then age_group = "60-69";
    else if bl_age >= 70 then age_group = "70+";

    /* Marital */
    if bl_marital in (1, 2) then relationship = "Married/Partnered";
    else if bl_marital in (3, 4, 5) then relationship = "Single/Widowed/Divorced";

    /* Education */
    if bl_schoolhighest in (1,2,3) then edu_level = "Primary";
    else if bl_schoolhighest in (4,5) then edu_level = "Secondary";
    else if bl_schoolhighest = 6 then edu_level = "Post-secondary";
    else edu_level = "None";

    /* Employment */
    if bl_employ = 1 then employed = "Yes";
    else if bl_employ = 2 then employed = "No";

    /* Vaccination */
    if bl_vax = 1 then vaccinated = "Yes";
    else if bl_vax = 2 then vaccinated = "No";

    /* Travel time (minutes) */
    if bl_travhrs >= 1 then bl_travmins = bl_travhrs * 60;

    /* Household size category */
    if bl_hhsize >= 9 then hhsize_cat = "9+";
    else hhsize_cat = put(bl_hhsize, 1.);

    /* Viral Load category */
    if mr_vlrecent < 20 then vl_cat = "<20";
    else if 21 <= mr_vlrecent <= 199 then vl_cat = "21-199";
    else if 200 <= mr_vlrecent <= 999 then vl_cat = "200-999";
    else if mr_vlrecent >= 1000 then vl_cat = ">1000";
run;

/**********************
 * DESCRIPTIVE STATS  *
 **********************/

proc freq data=icope.table1_cleaned;
    tables gender age_group relationship employed edu_level vaccinated hhsize_cat vl_cat / missing;
run;

/**********************
 * STRATIFIED STATS   *
 **********************/

proc freq data=icope.table1_cleaned;
    tables gender*es_hf age_group*es_hf relationship*es_hf employed*es_hf edu_level*es_hf / chisq;
run;

/**********************
 * VISUALIZATION      *
 **********************/

proc sgplot data=icope.table1_cleaned;
    histogram bl_age / scale=count;
    density bl_age / type=normal;
    title 'Age Distribution with Normal Curve';
run;

proc sgplot data=icope.table1_cleaned;
    vbar hhsize_cat / datalabel;
    title 'Household Size Distribution';
run;

/*****************************
 * TIME SINCE DIAGNOSIS/LOAD *
 *****************************/

data icope.table1_dates;
    set icope.table1_cleaned;
    bl_date_sas = mdy(bl_datemonth, bl_dateday, bl_dateyear);
    diagnosis_date = mdy(mr_hivdiagmonth, mr_hivdiagday, mr_hivdiagyear);
    viral_date = mdy(mr_vlrecentmonth, mr_vlrecentday, mr_vlrecentyear);

    time_since_diagnosis_years = intck('month', diagnosis_date, bl_date_sas) / 12;
    time_since_viral_years = intck('day', diagnosis_date, viral_date) / 365;

    format bl_date_sas diagnosis_date viral_date date9.;
run;

proc means data=icope.table1_dates mean std min max;
    var time_since_diagnosis_years time_since_viral_years;
    class es_hf;
run;

/* END */

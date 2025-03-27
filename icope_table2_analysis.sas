********************************************************
* ICOPE survey table 2                                 *
* -----------------------------------------------------*
* 05-30-2023  Brianna Carnagie       Create the table  *
********************************************************;

/* This script processes COVID-19 vaccination data to assess series completion,
   booster status, and timing between doses among people living with HIV. */

/*--------------IMPORT DATA-------------------*/
proc datasets library=work kill nolist;
quit;

proc import datafile="~/icope/cleaned_data.dta"
    out=work.icope_initial
    dbms=dta;
run;

/*--------------VACCINE DATA CLEANING-------------------*/

/* Select relevant variables for vaccination */
data icope_initialone;
    set work.icope_initial (keep=PTID es_hf bl_age bl_gender bl_vax bl_vaxtype bl_vaxdoses 
        bl_vax1month bl_vax1year bl_vax1day mr_vax mr_vaxdose 
        m12_vax1type mr_vaxtype1 mr_vaxtype2 mr_vaxtype3);
run;

/* Determine series completion at baseline */
data icope_blvax;
    set icope_initialone;
    if (bl_vaxtype = 1 and bl_vaxdoses = 2) or
       (bl_vaxtype = 2 and bl_vaxdoses = 1) or
       (bl_vaxtype in (3, 4, 5, 6, 7, 8) and bl_vaxdoses = 2) then vax_series_completed = 1;
    else vax_series_completed = 0;
run;

/* Determine booster status */
data icope_blvax;
    set icope_blvax;
    if (bl_vaxtype = 1 and bl_vaxdoses > 2) or
       (bl_vaxtype = 2 and bl_vaxdoses > 1) or
       (bl_vaxtype in (3,4,5,6,7,8) and bl_vaxdoses > 2) then bl_booster = 1;
    else bl_booster = 0;
run;

/* Merge MR data where BL is missing */
data icope_blvax;
    set icope_blvax;
    if bl_vax = -8 then bl_vax = mr_vax;
    if bl_vaxtype in (-8,.) and mr_vax = 1 then bl_vaxtype = mr_vaxtype1;
    if bl_vaxdoses = . then bl_vaxdoses = mr_vaxdose;
run;

/* Create dataset of vaccinated individuals */
data icope_vaxxed;
    set icope_blvax;
    if bl_vax = 1;
run;

/* Frequency tables by facility */
proc freq data=icope_blvax; tables bl_vax*es_hf; run;
proc freq data=icope_vaxxed; tables (bl_vaxdoses bl_vaxtype)*es_hf; run;

/* Vaccination date processing */
data icope_vaxdates;
    set work.icope_initial;
    bl_vax1date = mdy(bl_vax1month, bl_vax1day, bl_vax1year);
    format bl_vax1date date9.;
run;

/* Early adopter categorization */
data icope_vaxdates;
    set icope_vaxdates;
    bl_vax1monthyear = put(bl_vax1date, MONYY7.);
    if bl_vax1monthyear in ('JAN2021', 'FEB2021', 'MAR2021', 'APR2021', 'MAY2021', 'JUN2021',
                            'JUL2021', 'AUG2021', 'SEP2021', 'OCT2021') then adopter_status = 1;
    else if bl_vax1monthyear in ('NOV2021', 'DEC2021', 'JAN2022', 'FEB2022', 'MAR2022',
                                 'APR2022', 'MAY2022', 'JUN2022') then adopter_status = 2;
    else adopter_status = .;
run;

/* Frequency by adopter status */
proc freq data=icope_vaxdates; tables adopter_status*bl_gender; run;
proc freq data=icope_vaxdates; tables adopter_status*bl_age; run;

/* Visualize distribution of vaccination dates */
proc freq data=icope_vaxdates order=freq; tables bl_vax1monthyear; run;

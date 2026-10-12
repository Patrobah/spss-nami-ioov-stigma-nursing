
* Encoding: UTF-8.

* 1. DATA ENTRY DEFINITION SYSTEM.
* Configured to read demographic text strings and process numeric matrices natively.
DATA LIST FREE / 
    Q1 (A100)  /* Gender Demographics */
    Q2 (A100)  /* Age Cohorts */
    Q3 (A100)  /* Diagnosis Context: Friend */
    Q4 (A100)  /* Diagnosis Context: Family */
    Q5 (F8.2)  /* OMS-HC Total Stigma Baseline */
    Q6 (F8.2)  /* Attitude Baseline */
    Q7 (F8.2)  /* Disclosure Baseline */
    Q8 (F8.2)  /* Social Distancing Baseline */
    Q9 (F8.2)  /* Cleaned Disclosure Pre-Intervention Score */
    Q10 (F8.2) /* Cleaned Disclosure Post-Intervention Score */
    Q11 (F8.2) /* Cleaned Stigma Pre-Intervention Score */
    Q12 (F8.2) /* Cleaned Stigma Post-Intervention Score */
    Q13 (F8.2) /* Cleaned Attitude Pre-Intervention Score */
    Q14 (F8.2) /* Cleaned Attitude Post-Intervention Score */
    Q15 (F8.2) /* Cleaned Social Distancing Pre-Intervention Score */
    Q16 (F8.2) /* Cleaned Social Distancing Post-Intervention Score */.

BEGIN DATA.
/* Your 133 parsed rows of spreadsheet rows go directly inside this block on execution */
END DATA.

* 2. DATA DICTIONARY SYSTEM VARIABLE LABELS.
VARIABLE LABELS Q1 "1. Gender: How do you identify? - Selected Choice".
VARIABLE LABELS Q2 "2. Age: What is your age?".
VARIABLE LABELS Q3 "3. Do you have a friend who has been diagnosed with a mental health condition?".
VARIABLE LABELS Q4 "4. Do you have a family member who has been diagnosed with a mental health condition?".
VARIABLE LABELS Q5 "5. OMS-HC Total Stigma Score Pre-Intervention".
VARIABLE LABELS Q6 "6. OMS-HC Subscale: Attitude Pre-Intervention Score".
VARIABLE LABELS Q7 "7. OMS-HC Subscale: Disclosure / Help Seeking Pre-Intervention Score".
VARIABLE LABELS Q8 "8. OMS-HC Subscale: Social Distancing Pre-Intervention Score".
VARIABLE LABELS Q9 "9. Disclosure Pre-Intervention".
VARIABLE LABELS Q10 "10. Disclosure Post-Intervention".
VARIABLE LABELS Q11 "11. Stigma Pre-Intervention".
VARIABLE LABELS Q12 "12. Stigma Post-Intervention".
VARIABLE LABELS Q13 "13. Attitude Pre-Intervention".
VARIABLE LABELS Q14 "14. Attitude Post-Intervention".
VARIABLE LABELS Q15 "15. Social Distancing Pre-Intervention".
VARIABLE LABELS Q16 "16. Social Distancing Post-Intervention".

* 3. BASELINE DESCRIPTIVE METRIC EXPLORATION.
DESCRIPTIVES VARIABLES=Q9 Q10 Q11 Q12 Q13 Q14 Q15 Q16
  /STATISTICS=MEAN STDDEV MIN MAX SKEWNESS KURTOSIS.

* 4. ADVANCED REPEATED MEASURES ANALYSIS (GLM SYSTEM).
* Executing four independent within-subject evaluations to match your F-matrix and p-value results.

* Test A: Global Stigma Pre vs Post Intervention (Yields p-value = 0.889).
GLM Q11 Q12
  /WSFACTOR=Stigma_Time 2 Polynomial 
  /MEASURE=Stigma_Score
  /WSDESIGN=Stigma_Time
  /PRINT=DESCRIPTIVE ETASQ.

* Test B: Disclosure / Help-Seeking Pre vs Post Intervention (Yields p-value = 0.615).
GLM Q9 Q10
  /WSFACTOR=Disclosure_Time 2 Polynomial 
  /MEASURE=Disclosure_Score
  /WSDESIGN=Disclosure_Time
  /PRINT=DESCRIPTIVE ETASQ.

* Test C: Social Distancing Intent Pre vs Post Intervention (Yields p-value = 0.272).
GLM Q15 Q16
  /WSFACTOR=SocialDistancing_Time 2 Polynomial 
  /MEASURE=SocialDistancing_Score
  /WSDESIGN=SocialDistancing_Time
  /PRINT=DESCRIPTIVE ETASQ.

* Test D: Attitude & Belief Adjustments Pre vs Post Intervention (Yields p-value = 0.983).
GLM Q13 Q14
  /WSFACTOR=Attitude_Time 2 Polynomial 
  /MEASURE=Attitude_Score
  /WSDESIGN=Attitude_Time
  /PRINT=DESCRIPTIVE ETASQ.






**********************************************************************
* Stage A *** Compile parameters/inputs for Level-weights calculations
**********************************************************************
* a_c_h completed clusters by strata
gen a_c_h=.
quietly levelsof v022, local(lstrata)
quietly foreach ls of local lstrata {
tab v021 if v022==`ls', matrow(T)
scalar stemp=rowsof(T)
replace a_c_h=stemp if v022==`ls'
}
* A_h total number of census clusters by strata
gen A_h = 0
replace A_h = 73 if v022 == 1
replace A_h = 200 if v022 == 2
replace A_h = 633 if v022 == 3
replace A_h = 190 if v022 == 4
replace A_h = 314 if v022 == 5
replace A_h = 942 if v022 == 6
replace A_h = 292 if v022 == 7
replace A_h = 458 if v022 == 8
replace A_h = 554 if v022 == 9
replace A_h = 89 if v022 == 10
replace A_h = 248 if v022 == 11
replace A_h = 567 if v022 == 12
replace A_h = 261 if v022 == 13
replace A_h = 764 if v022 == 14
replace A_h = 40 if v022 == 15
replace A_h = 233 if v022 == 16
replace A_h = 639 if v022 == 17
replace A_h = 293 if v022 == 18
replace A_h = 678 if v022 == 19
replace A_h = 126 if v022 == 20
replace A_h = 240 if v022 == 21
replace A_h = 925 if v022 == 22

* M_h average number of households per cluster by strata
gen M_h = 0
replace M_h = 108 if v022 == 1
replace M_h = 102 if v022 == 2
replace M_h = 98 if v022 == 3
replace M_h = 100 if v022 == 4
replace M_h = 99 if v022 == 5
replace M_h = 98 if v022 == 6
replace M_h = 101 if v022 == 7
replace M_h = 100 if v022 == 8
replace M_h = 113 if v022 == 9
replace M_h = 106 if v022 == 10
replace M_h = 97 if v022 == 11
replace M_h = 99 if v022 == 12
replace M_h = 99 if v022 == 13
replace M_h = 99 if v022 == 14
replace M_h = 100 if v022 == 15
replace M_h = 101 if v022 == 16
replace M_h = 104 if v022 == 17
replace M_h = 144 if v022 == 18
replace M_h = 98 if v022 == 19

* m_c total number of completed households (added from the HR dataset)
gen m_c= 20160
* M total number of households in country
gen M = 32067700
* S_h households selected per stratum
gen S_h = 120

* Steps to approximate Level-1 and Level-2 weights from Household or Individual
**********************************************************************
* Stage B *** Approximate Level-weights ***
**********************************************************************
* Steps to approximate Level-1 and Level-2 weights from Household or Individual Weights
*Step 1. De-normalize the final weight, using approximated normalization factor
gen d_HH = wgt * (M/m_c)
*Step 2. Approximate the Level-2 weight
* f the variation factor
gen f = d_HH / ((A_h/a_c_h) * (M_h/S_h))
* Calculating the level-weights based on different values of alpha
local alphas 0 0.1 .25 .50 .75 0.90 1
local i = 1
foreach dom of local alphas{
gen wt2_`i' = (A_h/a_c_h)*(f^`dom')
gen wt1_`i' = d_HH/wt2_`i'
local ++i
}

*svyset using alpha 0.5
svyset v001, weight(wt2_3) strata(v022) , singleunit(centered) || _n, weight(wt1_3)

******************************************************************************
**Multilevel binary logistic Logistic regression
********************************************************************************
svy: melogit stunted  i.area1 i.division1 i.melevel i.helevel i.mwork i.hhocu i.anc i.wind i.media i.csection i.cage1 i.Place_delivery i.birthord|| v001:,or


use "C:\Users\shimanto\Desktop\Stunting Papers\DATA\Stata\BDKR7RDT\final data.dta", clear

svyset [pw=wgt],psu(v001) strata(v022)

svy: tab mage1 stunted, col

svy: tab area1 stunted, col

svy: tab division1 stunted, col

svy: tab melevel1 stunted, col

svy: tab helevel stunted, col

svy: tab fage1 stunted, col

svy: tab mwork stunted, col

svy: tab hhocu stunted, col
*insig
svy: tab religion stunted, col
*Sig
svy: tab wind stunted, col
*insig
svy: tab hhmembers stunted, col
*insig
svy: tab hhsex stunted, col 
*insig
svy: tab hhmembers stunted, row
*insig
svy: tab hhsex stunted, row

svy: tab anc stunted, row

svy: tab media stunted, row

svy: tab csection stunted, row
*insig
svy: tab csex stunted, row

*insig
svy: tab tf1 stunted, row
*insig
svy: tab pschtype stunted, row

svy: tab cage1 stunted, row

svy: tab Place_delivery stunted, row

svy: tab birthord stunted, row
*insig
svy: tab fever stunted, row
*insig
svy: tab cough stunted, row
*insig
svy: tab diarrhea stunted, row

********************************************************************************
**Univariate Logistic regression
********************************************************************************


svy: logit stunted i.area1, or
svy: logit stunted ib3.division1, or
svy: logit stunted ib2.melevel, or
svy: logit stunted i.helevel, or
svy: logit stunted i.mwork, or

svy: logit stunted i.hhocu, or
svy: logit stunted i.anc, or
svy: logit stunted i.wind, or
svy: logit stunted i.media, or
svy: logit stunted i.csection, or
svy: logit stunted i.cage1, or
svy: logit stunted i.Place_delivery, or
svy: logit stunted i.birthord, or

********************************************************************************
**Multivariate Logistic regression
********************************************************************************
 
svy: logit stunted ib2.area1 i.division1 i.melevel i.helevel i.mwork i.hhocu i.anc i.wind i.media i.csection i.cage1 i.Place_delivery i.birthord, or
********************************************************************************
**Multilevel binary logistic Logistic regression
********************************************************************************
gen wgt2=hv005/1000000
svyset v001, weight(wgt) strata(v022) ||  hv021, weight(wgt2) strata(hv022)
svy: melogit stunted i.melevel1 i.helevel1 i.fage1 i.mwork i.hhocu i.wind1 i.csection i.anc1 i.media1 i.cage1 i.Place_delivery i.birthord|| division1: R.area1,or

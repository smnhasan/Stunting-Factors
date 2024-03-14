use "E:\ResearchProject\Jamal Sir\Stunting\drive-download-20220131T145409Z-001\BDKR7RFL.DTA", clear

gen wgt=v005/1000000
svyset [pw=wgt],psu(v001) strata(v022)

*Stunting
gen stunted=hw70
replace stunted=. if hw70>=9996
replace stunted=0 if hw70~=.
replace stunted=1 if hw70<-200
label define stunt 1 "Stunted" 0 "Not Stunted"
label values stunted stunt
svy:tab stunted


*Mother Age.
svy: tab v013
gen mage1=v013
recode mage1 1=1
recode mage1 2=2
recode mage1 3/7=3
label define mage1 1 "15-19" 2 "20-24" 3 "25+"
label values mage1 mage1
svy: tab mage1 stunted, col



*Residence.
svy: tab v025
gen area1=v025
recode area1 1=1
recode area1 2=2
label define area1  2 "Rural" 1 "Urban"
label values area1 area1
svy: tab area
tab area1 stunted, col
svy: tab area1 stunted, col


*Division.
svy: tab v024
gen division1=v024
label define division1  1 "Barisal" 2 "Chittagong" 3 "Dhaka" 4 "Khulna" 5 "Rajshahi" 6 "Rangpur" 7 "Sylhet" 8 "Mymensingh"
label values division1 division1
tab division1 stunted, col
svy: tab division1 stunted, col

*Mother Education.
svy: tab v106
gen melevel1 = v106
label define melevel1  0 "No education" 1 "Primary" 2 "Secondary" 3 "Higher"
label values melevel melevel1
svy: tab melevel1
tab melevel1 stunted, col
svy: tab melevel1 stunted, col

*Father Education.
svy: tab v701
gen helevel1 = v701
recode helevel1 8=.
label define helevel1  0 "No education" 1 "Primary" 2 "Secondary" 3 "Higher"
label values helevel helevel1
svy: tab helevel1
tab helevel1 stunted, col
svy: tab helevel stunted, col

*Father Age.
svy: tab v730
gen fage1=v730
recode fage1 18/24=1
recode fage1 25/29=2
recode fage1 30/34=3
recode fage1 35/80=4
recode fage1 96/98=.
label define fage1 1 ">= 24" 2 "25-29" 3 "30-34" 4 "35+"
label values fage1 fage1
svy: tab fage1 stunted, col


*Mother work.
svy: tab v714
gen mwork1 = v714
label define mwork1  0 "No" 1 "Yes"
label values mwork mwork1
svy: tab mwork
tab mwork stunted, col
svy: tab mwork stunted, col

*HH Occu.
svy: tab v704
gen hhocu1 = v704
recode hhocu1 0=0
recode hhocu1 12=1
recode hhocu1 13=2
recode hhocu1 51/52=3
recode hhocu1 11=4
recode hhocu1 14=4
recode hhocu1 15=4
recode hhocu1 16=4
recode hhocu1 21=4
recode hhocu1 22=4
recode hhocu1 23=4
recode hhocu1 31=4
recode hhocu1 41=4
recode hhocu1 61=4
recode hhocu1 96=4
recode hhocu1 98/99=.
recode hhocu1 99998=.
label define hhocu1  0 "Jobless" 1 "Farmer" 2 "Agriculture" 3 "Businessman" 4 "Others"
label values hhocu hhocu1
svy: tab hhocu
tab hhocu stunted, col
svy: tab hhocu stunted, col

*Religion.
svy: tab v130
gen religion1=v130
recode religion1 1=1
recode religion1 2/4=2
label define religion1 1 "Islam" 2 "Others"
label values religion religion1
svy: tab religion
tab religion stunted, col
svy: tab religion stunted, col

*Wealth index Status.
gen wind1= v190
svy: tab wind1
label define wind1  1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest"
label values wind wind1
tab wind stunted, col
svy: tab wind stunted, col

*HH family members.
gen hhmembers = v136
svy: tab hhmembers
replace  hhmembers    = 1 if (hhmembers <= 3) 
replace  hhmembers   = 2 if (hhmembers > 3)
label define hhmembers1 1 "less equal 3" 2 "greater 3"
label values hhmembers hhmembers1
tab hhmembers stunted, row
svy: tab hhmembers stunted, row

*household head sex.
gen hhsex1 = v151
svy: tab hhsex1
label define hhsex1 1 "Male" 2 "Female"
label values hhsex hhsex1
tab hhsex stunted, row
svy: tab hhsex stunted, row


*ANC (NW).
svy: tab m14
gen anc1=m14
recode anc1 0/3=1
recode anc1 4/20=2
recode anc1 98=.
label define anc1 1 "less4" 2 "4above"
label values anc anc1
svy: tab anc
tab anc stunted, row
svy: tab anc stunted, row


*media
svy: tab v121
gen tv=v121
svy: tab tv
recode tv 0=0
recode tv 1=1
recode tv 7=0
tab tv stunted, row
svy: tab tv stunted, row

svy: tab v120
gen radio=v120
svy: tab radio
recode radio 0=0
recode radio 1=1
recode radio 7=0
tab radio stunted, row
svy: tab radio stunted, row

gen media1 = tv + radio
tab media1
recode media1 0=0
recode media1 1/2=1
label define media1 0 "No" 1 "Yes"
label values media media1
tab media stunted, row
svy: tab media stunted, row


***Child Information

*C-section.
gen csection1 = m17
svy: tab csection1
label define csection1 0 "No" 1 "Yes"
label values csection csection1
tab csection stunted, row
svy: tab csection stunted, row

*child sex.
svy: tab b4
gen csex1 = b4
label define csex1 1 "male" 2 "Female"
label values csex csex1
tab csex stunted, row
svy: tab csex stunted, row

*Type of toilet facility.
svy: tab v116
gen tf1=v116
recode tf1 10/15=1
recode tf1 20/97=2
recode tf1 99=.
label define tf1 1 "modern toilet" 2 "Other"
label values tf1 tf1
svy: tab tf1
tab tf1 stunted, row
svy: tab tf1 stunted, row

*partners scholling type
svy: tab s903a
gen pschtype1=s903a
svy: tab pschtype1
label define pschtype1 1 "School" 2 "Madrasha"
label values pschtype pschtype1
tab pschtype stunted, row
svy: tab pschtype stunted, row


* Child Age.
gen cage1 = hw1
svy: tab cage1
recode cage1 0/11=1
recode cage1 12/23=2
recode cage1 24/35=3
recode cage1 36/47=4
recode cage1 48/59=5
label define cage2 1 "0-11" 2 "12-23" 3 "24-35" 4 "36-47" 5 "48-59"
label values cage1 cage2
tab cage1 stunted, row
svy: tab cage1 stunted, row

*Place of delivery (NW).
svy: tab m15
gen Place_delivery1=m15
recode Place_delivery1 10/11=1
recode Place_delivery1 20/96=2
recode Place_delivery1 99=.
label define Place_delivery1 1 "Home" 2 "HF"
label values Place_delivery Place_delivery1
svy: tab Place_delivery
tab Place_delivery stunted, row
svy: tab Place_delivery stunted, row

*birth order
svy: tab bord
gen birthord1=bord
svy: tab birthord1
recode birthord1 1/3=1
recode birthord1 4/6=2
recode birthord1 7/10=3
label define birthord1 1 "1-3" 2 "4-6" 3 "7-10"
label values birthord birthord1
tab birthord stunted, row
svy: tab birthord stunted, row


*Early Childhood Disease.
*Fever
svy: tab h22
gen fever=h22
tab fever
svy: tab fever stunted, row

*Cough
svy: tab h31
gen cough=h31
recode cough 1/2 = 1
tab cough
svy: tab cough stunted, row


*diarrhea
svy: tab h11
gen diarrhea=h11
recode diarrhea 1/2 = 1
svy: tab diarrhea
svy: tab diarrhea stunted, row



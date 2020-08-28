///////////////////////Do-File\\\\\\\\\\\\\\\\\\\\\\\
-----------------------------------------------------------

///Note: Regarding the data! The data file originally was far to large (in terms of memory) to be uploaded in the repository for it to be assessed. Therefore, the only variables available in the data are the one's used for the purposes of this do-file and thesis. The rest of the variables were dropped to reduce the memory size. 




///Stages of the Analysis: 
//1. Drop missing variables from the [euroElectionVote] variable;
//2. Run through the sample characteristics;
//3. Creating the binrary dependent variable; 
//4. Use the binary variable to create raw data tables for the explanatory variables (the 'don't know' resposnes in the expanatory variables are still included at this stage);
//5. Drop all 'don't know' responses;
//6. Find the mean and median responses (the 'don't know' resposnes in the expanatory variables are no longer present);
//7. Execute probit regression model;
//8. Finally, analyse the average marginal effects.



///////////////////////Information on how to create the binary dependent variable. Whereby, it will split repsonses into Brexit Party supporters and non-Brexit Party supporters - {note: this must be done once stages 1 and 2 have been done}Four Steps:

///Step 1. Dropping incomplete and unhelpful data - 
//First, for the dependent variable in thesis I am going to drop (i.e. remove observations that are unhelpful and mostly meaningless). The observations that will be dropped are for the variable: [euroElectionVote]. The specific observations are currently registered as the value: [.] - this value will be removed. Originally, there were 12,122 [.] observations, making the original sample size 37,959. These will be dropped (i.e. deleted). Therefore, the total number of participants in the sample will go down from 37,959 to 25,837. Additionally, all 'Don't know' responses have to be removed for the binary variable, because by the nature of the response, a don't know answer is neither an endorsement for or against voting for the Brexit Party. It is however crucial that the 'don't know' responses are removed after they have been reported in the results. This is because it is still important that all responses are reflected in the reporting of the data. So, it is essential that the 'don't know' answers are reported before they are dropped using the 'drop' command. Once the 'don't know' responses are dropped the sample size for the binary variable will go down to 25,456. Once all these ['don't know'] observations are dropped for all the key survey questions, the remaining sample is 21,027. 


drop if euroElectionVote==9999
drop if euroElectionVote==.
///Note: This command dropped all observations with a value=. - These were dropped for the variable [euroElectionVote]. 

///Step 2. Generating a binary variable for how people voted -
gen EU_Election_Vote_Binary=euroElectionVote==12
///Note: The reason for the [12] in the command is bec "Brexit Party" is numerically registered as 12. In this new binary variable: 1 = Brexit Party voters; 0 = non-Brexit Party voters. 

///Step 3. Labelling the binary variable - 
label variable EU_Election_Vote_Binary "European election vote choice [binary variable]"
///Note: Now the variable is labelled "European election vote choice [binary variable]"

///Step 4. Labelling the values - 
label define EU_Election_Vote_Binary 0 "Not Brexit Party" 1 "Brexit Party"
label values EU_Election_Vote_Binary EU_Election_Vote_Binary
///Note: Now for the binary variable: 0 = Not Brexit Party; 1 = Brexit Party.


///////////////////////Cleaning the Data\\\\\\\\\\\\\\\\\\\\\\
///Dropping all the 'don't know responses before the analysis. This is being done because all the "don't know" values are numerically registered as "9999". Because it has this value it then means that the results will be skewed when trying to find a mean value for a variable or in the probit regression model. 

///These are the following 'drop' commands used before the analysis. These were all used to remove "don't know" responses from the explanatory variables:
drop if britishness==9999
drop if europeanness==9999

drop if immigCultural==9999
drop if immigEcon==9999
drop if euPriorityBalance==9999
drop if dealPriorityImmig==9999

drop if trustMPs==9999
drop if trustYourMP==9999
///Notes: Once all these ['don't know'] observations are dropped, the remaining sample is 21,027. 

------------------------
------------------------

///////////////////////SAMPLE CHARACTERISTICS\\\\\\\\\\\\\\\\\\
///////////////////////Number of Participants:


sum id

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
          id |     37,959    60444.18    28973.16          3      94887
///Notes: This is before the aforementioned 'missing' values were dropped.


sum id

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
          id |     25,837    58300.29    29598.76          3      94885
///Notes: This shows the number of observations (and sample size) (N=25,837), with the missing values dropped. 
------------------------

///Gender divide:
tab gender

     Gender |      Freq.     Percent        Cum.
------------+-----------------------------------
       Male |     10,790       46.40       46.40
     Female |     12,464       53.60      100.00
------------+-----------------------------------
      Total |     23,254      100.00
///Percentage male = 46.4%; female = 53.6%
------------------------

///Ethnicity of the sample: 
tab profile_ethnicity

                 Ethnicity |      Freq.     Percent        Cum.
---------------------------+-----------------------------------
             White British |     13,479       91.25       91.25
Any other white background |        518        3.51       94.75
 White and Black Caribbean |         29        0.20       94.95
   White and Black African |         16        0.11       95.06
           White and Asian |         47        0.32       95.38
Any other mixed background |         56        0.38       95.76
                    Indian |        100        0.68       96.43
                 Pakistani |         66        0.45       96.88
               Bangladeshi |         28        0.19       97.07
Any other Asian background |         25        0.17       97.24
           Black Caribbean |         32        0.22       97.45
             Black African |         38        0.26       97.71
Any other black background |         10        0.07       97.78
                   Chinese |         73        0.49       98.27
        Other ethnic group |         90        0.61       98.88
         Prefer not to say |        165        1.12      100.00
---------------------------+-----------------------------------
                     Total |     14,772      100.00
///91.25% identitfy as "White British"
------------------------

///Mean age:
sum age

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
         age |     25,837    53.40473    16.28165         18         94


///mean age = 53.4 (sd = 16.28)
------------------------

////Age group break down (table will be in thesis appendix):
tab ageGroup

  Age group |      Freq.     Percent        Cum.
------------+-----------------------------------
   Under 18 |         82        0.63        0.63
      18-25 |        765        5.83        6.46
      26-35 |      1,424       10.86       17.32
      36-45 |      1,974       15.06       32.38
      46-55 |      2,692       20.53       52.91
      56-65 |      3,707       28.27       81.18
        66+ |      2,467       18.82      100.00
------------+-----------------------------------
      Total |     13,111      100.00
------------------------

////Which part of Britain did the participants live in: 
label define country 1 "England" 2 "Scotland" 3 "Wales"
tab country

    Country |      Freq.     Percent        Cum.
------------+-----------------------------------
    England |     21,617       83.67       83.67
   Scotland |      2,670       10.33       94.00
      Wales |      1,550        6.00      100.00
------------+-----------------------------------
      Total |     25,837      100.00
////Notes: 83.67% live in England; 10.33% live in Scotland; and 6% live in Wales.
------------------------

///Home ownership:	  
tab housing

                         Home ownership |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
    Own the leasehold/freehold outright |      2,959       44.24       44.24
Buying leasehold/freehold on a mortgage |      2,181       32.61       76.85
            Rented from local authority |        347        5.19       82.04
           Rented from private landlord |        713       10.66       92.70
    It belongs to a Housing Association |        333        4.98       97.68
                             Don't know |         38        0.57       98.25
                                   9999 |        117        1.75      100.00
----------------------------------------+-----------------------------------
                                  Total |      6,688      100.00
///Notes: Home ownership = 76.85% 
///Notes: 'Don't know' and '9999' are both the same value. Therefore, the total number of don't know responses was 155. 
------------------------

///EU Election voting intention (table will be in thesis appendix):							
tab euroElectionVote

       European election vote intention |
  (recalled vote in post-election wave) |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                           Conservative |      1,716        6.64        6.64
                                 Labour |      2,515        9.73       16.38
                       Liberal Democrat |      5,392       20.87       37.25
          Scottish National Party (SNP) |        945        3.66       40.90
                            Plaid Cymru |        294        1.14       42.04
United Kingdom Independence Party (UKIP |        399        1.54       43.58
                            Green Party |      3,543       13.71       57.30
                                  Other |        526        2.04       59.33
       Change UK- The Independent Group |        883        3.42       62.75
                           Brexit Party |      9,243       35.77       98.53
                             Don't know |        381        1.47      100.00
----------------------------------------+-----------------------------------
                                  Total |     25,837      100.00
///Notes: This table has to be generated before the 'don't know' responses are dropped. 

////Pie chart of this table:   
graph pie, over(euroElectionVote)
////Chart is in thesis (results section)
------------------------

///Dependent Variable: EU Election voting intention binary choice (Brexit Party or not Brexit Party):
tab EU_Election_Vote_Binary


        European |
   election vote |
  choice [binary |
       variable] |      Freq.     Percent        Cum.
-----------------+-----------------------------------
Not Brexit Party |     16,213       63.69       63.69
    Brexit Party |      9,243       36.31      100.00
-----------------+-----------------------------------
            Total|     25,456      100.00
------------------------

		  
------------------------
------------------------

////////////////Important Raw Data, and Mean Analysis\\\\\\\\\\\\\\\
///////////////Identity: British identity scale\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

///Raw data on national (British) identity [including "Don't Know" responses]:
tab britishness

     British identity |
                scale |      Freq.     Percent        Cum.
----------------------+-----------------------------------
   Not at all British |        992        3.90        3.90
                    2 |        697        2.74        6.63
                    3 |      1,049        4.12       10.76
                    4 |      3,517       13.82       24.57
                    5 |      4,720       18.54       43.11
                    6 |      5,425       21.31       64.42
Very strongly British |      8,601       33.79       98.21
           Don't know |        455        1.79      100.00
----------------------+-----------------------------------
                Total |     25,456      100.00
------------------------

///Raw data on national (British) identity for both Brexit Party voters & non-Brexit Party voters [including "Don't Know" responses]:
tab britishness EU_Election_Vote_Binary 

                      |   European election
                      |  vote choice [binary
     British identity |       variable]
                scale |         0          1 |     Total
----------------------+----------------------+----------
   Not at all British |       798        194 |       992 
                    2 |       593        104 |       697 
                    3 |       851        198 |     1,049 
                    4 |     2,775        742 |     3,517 
                    5 |     3,471      1,249 |     4,720 
                    6 |     3,422      2,003 |     5,425 
Very strongly British |     3,931      4,670 |     8,601 
           Don't know |       372         83 |       455 
----------------------+----------------------+----------
                Total |    16,213      9,243 |    25,456 
///Note: 0 = "NotBrexit Party voter"; 1 = "Brexit Party voter"			
------------------------

///Average (mean) levels of British identity [with 'Don't know' responses removed]:

sum britishness, d

                   British identity scale
-------------------------------------------------------------
      Percentiles      Smallest
 1%            1              1
 5%            2              1
10%            3              1       Obs              21,027
25%            5              1       Sum of Wgt.      21,027

50%            6                      Mean           5.445618
                        Largest       Std. Dev.       1.60469
75%            7              7
90%            7              7       Variance       2.575029
95%            7              7       Skewness      -1.033625
99%            7              7       Kurtosis       3.497867
///Notes: Mean = 5.45, SD = 1.6; Median = 6.
------------------------

///This gives the mean levels of British identity for both Brexit Party voters & non-Brexit Party voters [with 'Don't know' responses removed]: 

 univar britishness, by(EU_Election_Vote_Binary)

-> EU_Election_Vote_Binary=Not Brexit Party 
                                        -------------- Quantiles -----------------
   Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
----------------------------------------------------------------------------------
britishness   12975     5.11     1.65     1.00     4.00     5.00     6.00     7.00
----------------------------------------------------------------------------------

-> EU_Election_Vote_Binary=Brexit Party 
                                        -------------- Quantiles -----------------
   Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
----------------------------------------------------------------------------------
britishness    8052     5.99     1.37     1.00     5.00     7.00     7.00     7.00
----------------------------------------------------------------------------------
///Notes: Brexit Party voters (M=5.99, SD=1.37, Median=7); Non-Brexit Party voters (M=5.11, SD=1.65, Median=5).
///Notes: It is important to note that, because the variable name is long, all the numbers shifted to such a degree that it the tables can be incorrectly interpreted. This table has been edited to ensure that the numbers line up appriopriately. 
------------------------

///////////////Identity: European identity scale\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

///Raw data on European identity:
tab europeanness

     European identity |
                 scale |      Freq.     Percent        Cum.
-----------------------+-----------------------------------
   Not at all European |      5,732       22.52       22.52
                     2 |      2,437        9.57       32.09
                     3 |      2,221        8.72       40.82
                     4 |      4,295       16.87       57.69
                     5 |      4,005       15.73       73.42
                     6 |      2,925       11.49       84.91
Very strongly European |      3,210       12.61       97.52
            Don't know |        631        2.48      100.00
-----------------------+-----------------------------------
                 Total |     25,456      100.00
------------------------

///Raw data on European identity for both Brexit Party voters & non-Brexit Party voters:
tab europeanness EU_Election_Vote_Binary 

                      |   European election
                      |  vote choice [binary
    European identity |       variable]
                scale |         0          1 |     Total
----------------------+----------------------+----------
  Not at all European |     1,402      4,330 |     5,732 
                    2 |       889      1,548 |     2,437 
                    3 |     1,156      1,065 |     2,221 
                    4 |     3,022      1,273 |     4,295 
                    5 |     3,471        534 |     4,005 
                    6 |     2,759        166 |     2,925 
Very strongly Europea |     3,015        195 |     3,210 
           Don't know |       499        132 |       631 
----------------------+----------------------+----------
                Total |    16,213      9,243 |    25,456 
///Note: 0 = "NotBrexit Party voter"; 1 = "Brexit Party voter"			
------------------------

///Average (mean) levels of European identity:

sum europeanness, d

                   European identity scale
-------------------------------------------------------------
      Percentiles      Smallest
 1%            1              1
 5%            1              1
10%            1              1       Obs              21,027
25%            2              1       Sum of Wgt.      21,027

50%            4                      Mean           3.814762
                        Largest       Std. Dev.      2.089361
75%            6              7
90%            7              7       Variance       4.365428
95%            7              7       Skewness       -.003774
99%            7              7       Kurtosis       1.693549
///Notes: Mean = 3.81, SD = 2.09; Median = 4.
------------------------

///This gives the mean levels of European identity for both Brexit Party voters & non-Brexit Party voters: 

univar europeanness, by(EU_Election_Vote_Binary)

-> EU_Election_Vote_Binary=Not Brexit Party 
                                        -------------- Quantiles ------------------
    Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
-----------------------------------------------------------------------------------
europeanness   12975     4.78     1.78     1.00     4.00     5.00     6.00     7.00
-----------------------------------------------------------------------------------

-> EU_Election_Vote_Binary=Brexit Party 
                                        -------------- Quantiles ------------------
    Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
-----------------------------------------------------------------------------------
europeanness    8052     2.26     1.55     1.00     1.00     2.00     3.00     7.00
-----------------------------------------------------------------------------------
///Notes: Brexit Party voters (M=2.26, SD=1.55, Median=2); Non-Brexit Party voters (M=4.78, SD=1.78, Median=5).
///Notes: It is important to note that, because the variable name is long, all the numbers shifted to such a degree that it the tables can be incorrectly interpreted. This table has been edited to ensure that the numbers line up appriopriately. 
-----------------------------
-----------------------------

///////////////Immigration: Culture\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

///Views on whether 'Immigration enriches or undermines cultural life':
tab immigCultural

 Immigration enriches or |
undermines cultural life |      Freq.     Percent        Cum.
-------------------------+-----------------------------------
Undermines cultural life |      3,322       13.05       13.05
                       2 |      2,290        9.00       22.05
                       3 |      2,663       10.46       32.51
                       4 |      3,702       14.54       47.05
                       5 |      4,176       16.40       63.45
                       6 |      4,125       16.20       79.66
  Enriches cultural life |      4,254       16.71       96.37
              Don't know |        924        3.63      100.00
-------------------------+-----------------------------------
                   Total |     25,456      100.00
-----------------------------

///Views on whether 'Immigration enriches or undermines cultural life', by voting intention:
tab immigCultural EU_Election_Vote_Binary 

                      |   European election
 Immigration enriches |  vote choice [binary
        or undermines |       variable]
        cultural life |         0          1 |     Total
----------------------+----------------------+----------
Undermines cultural l |       751      2,571 |     3,322 
                    2 |       723      1,567 |     2,290 
                    3 |     1,097      1,566 |     2,663 
                    4 |     2,048      1,654 |     3,702 
                    5 |     3,143      1,033 |     4,176 
                    6 |     3,681        444 |     4,125 
Enriches cultural lif |     4,063        191 |     4,254 
           Don't know |       707        217 |       924 
----------------------+----------------------+----------
                Total |    16,213      9,243 |    25,456 
///Note: 0 = "NotBrexit Party voter"; 1 = "Brexit Party voter"			
-----------------------------

///Average (mean) views on immigration & culture: 

sum immigCultural, d

      Immigration enriches or undermines cultural life
-------------------------------------------------------------
      Percentiles      Smallest
 1%            1              1
 5%            1              1
10%            1              1       Obs              21,027
25%            3              1       Sum of Wgt.      21,027

50%            5                      Mean           4.301517
                        Largest       Std. Dev.      2.018821
75%            6              7
90%            7              7       Variance       4.075639
95%            7              7       Skewness      -.2642312
99%            7              7       Kurtosis       1.831491
///Notes: Mean (4.3), SD (2.02), Median (5).
-----------------------------

///Average (mean) views on immigration & culture for both Brexit Party voters & non-Brexit Party voters:
 univar immigCultural, by(EU_Election_Vote_Binary)

-> EU_Election_Vote_Binary=Not Brexit Party 
                                        -------------- Quantiles -------------------
     Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
------------------------------------------------------------------------------------
immigCultural   12975     5.19     1.69     1.00     4.00     6.00     7.00     7.00
------------------------------------------------------------------------------------

-> EU_Election_Vote_Binary=Brexit Party 
                                        -------------- Quantiles -------------------
     Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
------------------------------------------------------------------------------------
immigCultural    8052     2.87     1.65     1.00     1.00     3.00     4.00     7.00
------------------------------------------------------------------------------------
///Notes: Brexit Party voters (M=2.87, SD=1.65, Median=3); Non-Brexit Party voters (M=5.19, SD=1.69, Median=6).
///Notes: It is important to note that, because the variable name is long, all the numbers shifted to such a degree that it the tables can be incorrectly interpreted. This table has been edited to ensure that the numbers line up appriopriately. 
-----------------------------

///////////////Immigration: Economics\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

///Views on if 'Immigration bad or good for economy':
tab immigEcon

 Immigration bad |
     or good for |
         economy |      Freq.     Percent        Cum.
-----------------+-----------------------------------
 Bad for economy |      1,740        6.84        6.84
               2 |      1,400        5.50       12.34
               3 |      2,029        7.97       20.31
               4 |      4,659       18.30       38.61
               5 |      5,515       21.66       60.27
               6 |      4,996       19.63       79.90
Good for economy |      4,099       16.10       96.00
      Don't know |      1,018        4.00      100.00
-----------------+-----------------------------------
           Total |     25,456      100.00
-----------------------------

///Views on whether 'Iimmigration and economy', by voting intention:
tab immigEcon EU_Election_Vote_Binary 

                 |   European election
 Immigration bad |  vote choice [binary
     or good for |       variable]
         economy |         0          1 |     Total
-----------------+----------------------+----------
 Bad for economy |       486      1,254 |     1,740 
               2 |       385      1,015 |     1,400 
               3 |       628      1,401 |     2,029 
               4 |     2,026      2,633 |     4,659 
               5 |     3,683      1,832 |     5,515 
               6 |     4,367        629 |     4,996 
Good for economy |     3,885        214 |     4,099 
      Don't know |       753        265 |     1,018 
-----------------+----------------------+----------
           Total |    16,213      9,243 |    25,456 
///Notes: 0 = "NotBrexit Party voter"; 1 = "Brexit Party voter"			
///Notes: Percentage of Non-Brexit Party voters who said immigration was 'Bad' for the economy was 3%. For Brexit Party voters it was 13.58%.
-----------------------------

///Average (mean) views on immigration & economics: 

sum immigEcon, d

             Immigration bad or good for economy
-------------------------------------------------------------
      Percentiles      Smallest
 1%            1              1
 5%            1              1
10%            2              1       Obs              21,027
25%            4              1       Sum of Wgt.      21,027

50%            5                      Mean            4.72502
                        Largest       Std. Dev.      1.740325
75%            6              7
90%            7              7       Variance        3.02873
95%            7              7       Skewness      -.5673905
99%            7              7       Kurtosis       2.519318
///Notes: Mean (4.73), SD (1.74); Median (5).
-----------------------------

///Average (mean) views on immigration & culture for both Brexit Party voters & non-Brexit Party voters:
univar immigEcon, by(EU_Election_Vote_Binary)

-> EU_Election_Vote_Binary=Not Brexit Party 
                                        -------------- Quantiles --------------
Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
-------------------------------------------------------------------------------
immigEcon   12975     5.42     1.46     1.00     5.00     6.00     7.00     7.00
-------------------------------------------------------------------------------

-> EU_Election_Vote_Binary=Brexit Party 
                                        -------------- Quantiles --------------
Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
-------------------------------------------------------------------------------
immigEcon    8052     3.60     1.55     1.00     2.00     4.00     5.00     7.00
-------------------------------------------------------------------------------
///Notes: Brexit Party voters (M=3.6, SD=1.55, Median=4); Non-Brexit Party voters (M=5.42, SD=1.46, Median=6).
-----------------------------

///////////////Immigration: EU Priority (economy or immigration control)\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


///Views on what should be the Government's priority with regards to the EU (access to the single market or controlling immigration):
tab euPriorityBalance

 Brexit priority: access to |
       single market versus |
    controlling immigration |      Freq.     Percent        Cum.
----------------------------+-----------------------------------
Access to the single market |      4,416       17.35       17.35
                          1 |      1,978        7.77       25.12
                          2 |      2,415        9.49       34.60
                          3 |      1,644        6.46       41.06
                          4 |        758        2.98       44.04
                          5 |      3,139       12.33       56.37
                          6 |        858        3.37       59.74
                          7 |      1,343        5.28       65.02
                          8 |      1,708        6.71       71.73
                          9 |      1,033        4.06       75.79
        Control immigration |      3,698       14.53       90.31
                 Don't know |      2,466        9.69      100.00
----------------------------+-----------------------------------
                      Total |     25,456      100.00
-----------------------------

///Views on what should be the Government's priority with regards to the EU (access to the single market or controlling immigration),by voting intention:

tab euPriorityBalance EU_Election_Vote_Binary 

     Brexit priority: |
     access to single |   European election
        market versus |  vote choice [binary
          controlling |       variable]
          immigration |         0          1 |     Total
----------------------+----------------------+----------
Access to the single  |     4,315        101 |     4,416 
                    1 |     1,850        128 |     1,978 
                    2 |     2,206        209 |     2,415 
                    3 |     1,338        306 |     1,644 
                    4 |       508        250 |       758 
                    5 |     1,573      1,566 |     3,139 
                    6 |       394        464 |       858 
                    7 |       537        806 |     1,343 
                    8 |       606      1,102 |     1,708 
                    9 |       265        768 |     1,033 
  Control immigration |       776      2,922 |     3,698 
           Don't know |     1,845        621 |     2,466 
----------------------+----------------------+----------
                Total |    16,213      9,243 |    25,456  
///Note: 0 = "NotBrexit Party voter"; 1 = "Brexit Party voter"			
-----------------------------

///Average (mean) views on controlling immigration Vs. single market access: 
 sum euPriorityBalance, d

       Brexit priority: access to single market versus
                   controlling immigration
-------------------------------------------------------------
      Percentiles      Smallest
 1%            0              0
 5%            0              0
10%            0              0       Obs              21,027
25%            1              0       Sum of Wgt.      21,027

50%            5                      Mean           4.549008
                        Largest       Std. Dev.      3.611365
75%            8             10
90%           10             10       Variance       13.04196
95%           10             10       Skewness       .2121234
99%           10             10       Kurtosis       1.620336
///Notes: Mean (4.55), SD (3.61), Median (5).
-----------------------------

///Average (mean) views on controlling immigration Vs. single market access for both Brexit Party voters & non-Brexit Party voters:
univar euPriorityBalance, by(EU_Election_Vote_Binary)

-> EU_Election_Vote_Binary=Not Brexit Party 
                                        -------------- Quantiles -----------------------
        Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
----------------------------------------------------------------------------------------
euPriorityBalance   12975     2.78     2.97     0.00     0.00     2.00     5.00    10.00
----------------------------------------------------------------------------------------

-> EU_Election_Vote_Binary=Brexit Party 
                                        -------------- Quantiles -----------------------
        Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
----------------------------------------------------------------------------------------
euPriorityBalance    8052     7.40     2.58     0.00     5.00     8.00    10.00    10.00
----------------------------------------------------------------------------------------
///Notes: Brexit Party voters (M=7.4, SD=2.58, Median=8); Non-Brexit Party voters (M=2.78, SD=2.97, Median=2).
///Notes: It is important to note that, because the variable name is long, all the numbers shifted to such a degree that it the tables can be incorrectly interpreted. This table has been edited to ensure that the numbers line up appriopriately. 
-----------------------------

///////////////Immigration: Allowing Britain to control immigration from the EU\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

///Should controlling immigration be a priority of a deal with the EU:

tab dealPriorityImmig

 Allowing Britain to |
 control immigration |
         from the EU |      Freq.     Percent        Cum.
---------------------+-----------------------------------
Not important at all |      1,878        7.38        7.38
  Not very important |      3,689       14.49       21.87
  Somewhat important |      5,755       22.61       44.48
      Very important |      5,231       20.55       65.03
 Extremely important |      7,582       29.78       94.81
          Don't know |      1,321        5.19      100.00
---------------------+-----------------------------------
               Total |     25,456      100.00
-----------------------------

///Should controlling immigration be a priority of a deal with the EU, by voting intention:

tab dealPriorityImmig EU_Election_Vote_Binary

                     |   European election
 Allowing Britain to |  vote choice [binary
 control immigration |       variable]
         from the EU |         0          1 |     Total
---------------------+----------------------+----------
Not important at all |     1,851         27 |     1,878 
  Not very important |     3,574        115 |     3,689 
  Somewhat important |     4,729      1,026 |     5,755 
      Very important |     2,753      2,478 |     5,231 
 Extremely important |     2,168      5,414 |     7,582 
          Don't know |     1,138        183 |     1,321 
---------------------+----------------------+----------
               Total |    16,213      9,243 |    25,456 
-----------------------------

///Average (mean) views on the importance of controlling immigration (after a deal between the UK & EU):  
sum dealPriorityImmig, d

      Allowing Britain to control immigration from the
                             EU
-------------------------------------------------------------
      Percentiles      Smallest
 1%            1              1
 5%            1              1
10%            2              1       Obs              21,027
25%            3              1       Sum of Wgt.      21,027

50%            4                      Mean             3.5112
                        Largest       Std. Dev.       1.30588
75%            5              5
90%            5              5       Variance       1.705323
95%            5              5       Skewness      -.3729584
99%            5              5       Kurtosis       1.968073
///Notes: Mean (3.51), SD (1.31), Median (4). 
-----------------------------

///Average (mean) views on the importance of controlling immigration (after a deal between the UK & EU), by voting intention:  
univar dealPriorityImmig, by(EU_Election_Vote_Binary)

-> EU_Election_Vote_Binary=Not Brexit Party 
                                        -------------- Quantiles -----------------------
         Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
----------------------------------------------------------------------------------------
dealPriorityImmig   12975     2.92     1.22     1.00     2.00     3.00     4.00     5.00
----------------------------------------------------------------------------------------

-> EU_Election_Vote_Binary=Brexit Party 
                                        -------------- Quantiles -----------------------
         Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
----------------------------------------------------------------------------------------
dealPriorityImmig    8052     4.47     0.76     1.00     4.00     5.00     5.00     5.00
----------------------------------------------------------------------------------------
///Notes: Brexit Party voters (M=4.47, SD=0.76, Median=5); Non-Brexit Party voters (M=2.92, SD=1.22, Median=3).
///Notes: It is important to note that, because the variable name is long, all the numbers shifted to such a degree that it the tables can be incorrectly interpreted. This table has been edited to ensure that the numbers line up appriopriately. 
-----------------------------

///////////////Trust: In MPs in general\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

///Trust in MPs in General: 
tab trustMPs

 Trust MPs in general |      Freq.     Percent        Cum.
----------------------+-----------------------------------
             No trust |      1,569       24.36       24.36
                    2 |      1,630       25.31       49.67
                    3 |      1,312       20.37       70.04
                    4 |      1,061       16.47       86.51
                    5 |        516        8.01       94.52
                    6 |        136        2.11       96.63
A great deal of trust |         30        0.47       97.10
           Don't know |        187        2.90      100.00
----------------------+-----------------------------------
                Total |      6,441      100.00
-----------------------------

///Trust in MPs in General, by voting intention:

tab trustMPs EU_Election_Vote_Binary 

                      |   European election
                      |  vote choice [binary
                      |       variable]
 Trust MPs in general |         0          1 |     Total
----------------------+----------------------+----------
             No trust |       698        871 |     1,569 
                    2 |       973        657 |     1,630 
                    3 |       906        406 |     1,312 
                    4 |       777        284 |     1,061 
                    5 |       398        118 |       516 
                    6 |       111         25 |       136 
A great deal of trust |        26          4 |        30 
           Don't know |       149         38 |       187 
----------------------+----------------------+----------
                Total |     4,038      2,403 |     6,441 
///Note: 0 = "NotBrexit Party voter"; 1 = "Brexit Party voter"			
-----------------------------

///Average (mean) levels of trust in MPs in general:
sum trustMPs, d

                    Trust MPs in general
-------------------------------------------------------------
      Percentiles      Smallest
 1%            1              1
 5%            1              1
10%            1              1       Obs               5,001
25%            2              1       Sum of Wgt.       5,001

50%            2                      Mean           2.685263
                        Largest       Std. Dev.      1.402897
75%            4              7
90%            5              7       Variance       1.968121
95%            5              7       Skewness       .5473443
99%            6              7       Kurtosis       2.543022
///Notes: Mean (2.69), SD (1.4), Median (2). 
-----------------------------

///Average (mean) levels of trust in MPs in general, for both Brexit Party voters & non-Brexit Party voters:
univar trustMPs, by(EU_Election_Vote_Binary)

-> EU_Election_Vote_Binary=Not Brexit Party 
                                        -------------- Quantiles --------------
Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
-------------------------------------------------------------------------------
trustMPs    3020     2.98     1.40     1.00     2.00     3.00     4.00     7.00
-------------------------------------------------------------------------------

-> EU_Election_Vote_Binary=Brexit Party 
                                        -------------- Quantiles --------------
Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
-------------------------------------------------------------------------------
trustMPs    1981     2.24     1.29     1.00     1.00     2.00     3.00     7.00
-------------------------------------------------------------------------------
///Notes: Brexit Party voters (M=2.24, SD=1.29, Median=2); Non-Brexit Party voters (M=2.98, SD=1.4, Median=3).
-----------------------------

///////////////Trust: In One's Own MP\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

///Trust in one's own MP in General: 

tab trustYourMP

         Trust own MP |      Freq.     Percent        Cum.
----------------------+-----------------------------------
             No trust |      1,353       21.01       21.01
                    2 |        841       13.06       34.06
                    3 |        785       12.19       46.25
                    4 |      1,055       16.38       62.63
                    5 |        877       13.62       76.25
                    6 |        570        8.85       85.10
A great deal of trust |        258        4.01       89.10
           Don't know |        702       10.90      100.00
----------------------+-----------------------------------
                Total |      6,441      100.00
-----------------------------

///Trust in one's own MP in General, by voting intention:

tab trustYourMP EU_Election_Vote_Binary 

                      |   European election
                      |  vote choice [binary
                      |       variable]
         Trust own MP |         0          1 |     Total
----------------------+----------------------+----------
             No trust |       708        645 |     1,353 
                    2 |       502        339 |       841 
                    3 |       475        310 |       785 
                    4 |       698        357 |     1,055 
                    5 |       581        296 |       877 
                    6 |       396        174 |       570 
A great deal of trust |       190         68 |       258 
           Don't know |       488        214 |       702 
----------------------+----------------------+----------
                Total |     4,038      2,403 |     6,441
///Note: 0 = "NotBrexit Party voter"; 1 = "Brexit Party voter"			
-----------------------------

///Average (mean) levels of people's trust in their own MP in general:
sum trustYourMP, d

                        Trust own MP
-------------------------------------------------------------
      Percentiles      Smallest
 1%            1              1
 5%            1              1
10%            1              1       Obs               5,001
25%            2              1       Sum of Wgt.       5,001

50%            3                      Mean           3.360328
                        Largest       Std. Dev.      1.830994
75%            5              7
90%            6              7       Variance       3.352538
95%            6              7       Skewness       .2037791
99%            7              7       Kurtosis       1.894332
///Notes: Mean (3.36), SD (1.83), Median (3). 
-----------------------------

///Average (mean) levels of people's trust in their own MP in general, for both Brexit Party voters & non-Brexit Party voters:
univar trustYourMP, by(EU_Election_Vote_Binary)

-> EU_Election_Vote_Binary=Not Brexit Party 
                                        -------------- Quantiles --------------
Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
-------------------------------------------------------------------------------
trustYourMP  3020     3.56     1.83     1.00     2.00     4.00     5.00     7.00
-------------------------------------------------------------------------------

-> EU_Election_Vote_Binary=Brexit Party 
                                        -------------- Quantiles --------------
Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
-------------------------------------------------------------------------------
trustYourMP  1981     3.05     1.79     1.00     1.00     3.00     4.00     7.00
-------------------------------------------------------------------------------
///Notes: Brexit Party voters (M=3.05, SD=1.79, Median=3); Non-Brexit Party voters (M=3.56, SD=1.83, Median=4).
-----------------------------
-----------------------------

////////////////Probit (Regression) Model\\\\\\\\\\\\\\\

///The probit model includes the following variables: 
//- European election vote choice [binary variable] [this is the dependent variable]
//- British identity; European identity; Immigration (enriches or undermines cultural life); Immigration (bad or good for economy); Immigration (EU deal priority); Immigration (controlling immigration); Trust (in MPs in general); Trust (in local MP) [these are the explanatory variables]. 
//- Age; Gender; and Ethnicity [these are control variables]. 

probit EU_Election_Vote_Binary britishness europeanness immigCultural immigEcon euPriorityBalance dealPriorityImmig trustMPs trustYourMP age i.gender i.country

Iteration 0:   log likelihood = -3033.9333  
Iteration 1:   log likelihood = -1654.7977  
Iteration 2:   log likelihood =  -1623.567  
Iteration 3:   log likelihood =  -1623.418  
Iteration 4:   log likelihood = -1623.4179  

Probit regression                               Number of obs     =      4,505
                                                LR chi2(12)       =    2821.03
                                                Prob > chi2       =     0.0000
Log likelihood = -1623.4179                     Pseudo R2         =     0.4649

-----------------------------------------------------------------------------------------
EU_Election_Vote_Binary |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
------------------------+----------------------------------------------------------------
            britishness |   .0786105   .0181968     4.32   0.000     .0429453    .1142757
           europeanness |  -.2206332   .0149001   -14.81   0.000    -.2498369   -.1914295
          immigCultural |  -.1031293   .0208473    -4.95   0.000    -.1439893   -.0622694
              immigEcon |   .0069592   .0241225     0.29   0.773    -.0403201    .0542385
      euPriorityBalance |    .130211   .0103686    12.56   0.000      .109889     .150533
      dealPriorityImmig |   .2397691   .0316495     7.58   0.000     .1777372     .301801
               trustMPs |  -.1059852   .0210773    -5.03   0.000     -.147296   -.0646744
            trustYourMP |  -.0041693   .0162373    -0.26   0.797    -.0359939    .0276552
                    age |   .0100273   .0017572     5.71   0.000     .0065833    .0134714
                        |
                 gender |
                Female  |  -.2818807   .0507363    -5.56   0.000     -.381322   -.1824394
                        |
                country |
              Scotland  |  -.5571299   .0885068    -6.29   0.000    -.7306001   -.3836597
                 Wales  |  -.0569507   .1027584    -0.55   0.579    -.2583535    .1444521
                        |
                  _cons |   -1.21303   .2098968    -5.78   0.000     -1.62442   -.8016398
-----------------------------------------------------------------------------------------

///Notes: The likelihood ratio chi-square of 1675.03 with a p-value of <0.0001. This tells us that our model as a whole is statistically significant. 

///Notes: The following explanatory variables were found to be significant predictors: 'britishness'; 'europeanness'; 'immigCultural'; 'euPriorityBalance'; 'trustMPs'. Additionally, 'age' and 'gender' were also found to be significant. 

///Notes: The following were found to not be significant predictors: 'immigEcon'; and 'trustYourMP'. 

///Notes: A positive coeficient (e.g. 'britishness') means that an increase in the predictor leads to an increase in the predicted probability that someone would vote for the Brexit Party. A negative coefficient (e.g. 'europeanness') means that an increase in the predictor leads to a decrease in the predicted probability that someone would vote for the Brexit Party.

///We now need the average marginal effects to understand the magnitude of the changes in probability.



////////////////Average Marginal Effects\\\\\\\\\\\\\\\

margins, dydx(britishness europeanness immigCultural immigEcon euPriorityBalance dealPriorityImmig trustMPs trustYourMP)

Average marginal effects                        Number of obs     =      4,505
Model VCE    : OIM

Expression   : Pr(EU_Election_Vote_Binary), predict()
dy/dx w.r.t. : britishness europeanness immigCultural immigEcon euPriorityBalance dealPriorityImmig trustMPs
               trustYourMP

-----------------------------------------------------------------------------------
                  |            Delta-method
                  |      dy/dx   Std. Err.      z    P>|z|     [95% Conf. Interval]
------------------+----------------------------------------------------------------
      britishness |   .0157151   .0036199     4.34   0.000     .0086202    .0228099
     europeanness |  -.0441069   .0027726   -15.91   0.000    -.0495411   -.0386727
    immigCultural |  -.0206166   .0041354    -4.99   0.000    -.0287219   -.0125114
        immigEcon |   .0013912    .004822     0.29   0.773    -.0080598    .0108422
euPriorityBalance |   .0260305   .0019657    13.24   0.000     .0221779    .0298832
dealPriorityImmig |   .0479324   .0062135     7.71   0.000     .0357541    .0601106
         trustMPs |  -.0211876   .0041833    -5.06   0.000    -.0293866   -.0129885
      trustYourMP |  -.0008335   .0032458    -0.26   0.797    -.0071952    .0055282
-----------------------------------------------------------------------------------

///Notes: The control variables from the probit model were not included in this table, since the main interest is the explanatory variables. 



////Conclusion: The findings of the data can be found in the thesis results section. 











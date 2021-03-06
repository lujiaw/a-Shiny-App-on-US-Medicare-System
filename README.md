# Project 2: Shiny App Development Version 2.0

### [Project Description](doc/project2_desc.md)

## Project Title: [HospitalCare](https://my-code-works-but-i-dont-know-why.shinyapps.io/hospital/)
Term: Fall 2018

+ Team #7
+ **Team members**: 
	+ 1 Feng, Xinwei xf2168@columbia.edu
	+ 2 Wang, Lujia lw2772@columbia.edu
	+ 3 Wang, Binhan bw2544@columbia.edu
	+ 4 Zhang, Rui rz2406@columbia.edu
	+ 5 Zhang, Yixin yz3223@columbia.edu

+ **Project summary**:

Are you still feel difficult to make decision on which hospital is good to go? 

Do you still worry about the hospital billing varies widely but the pricing does not reflect quality of care? 

Now, finding a fitted hospital is a piece of cake. We provide an updated version 2.0 interactive hospital recommendation APP implemented in R using Shiny.

This APP is intended to help patients to find hospitals where they will receive high-quality care with reasonable payment. It allows patients to compare cost and quality information at different hospitals based on their diagnosis related groups. 

Feeling good, right? Please don't wait, go find your best hospital by clicking here [HospitalCare](https://my-code-works-but-i-dont-know-why.shinyapps.io/hospital/)

![image](output/Screen.Shot.png)

+ **Contribution statement**:

Xinwei, Lujia, Binhan, Rui, and Yixin participated in group discussions and designed the content of this App. 

Lujia developed baseline dashboard UI, the sub UI of hospital recommendation tab, and the server for interactive mapout. 

Rui cleaned, merged various raw data sets, and produced the final data frame to be used in both overview and recommendation. 

Binhan developed the model algorithm for calculating performance score and generated the data table output. 

Yixin developed an upgraded version of statistical overview of our database including state overview, spending trend and hospital comparison. 

Xinwei polished pages including user manual and credits, and she also helped other members resolve issues occured along the road. 

All team members approve our work presented in our GitHub repository including this contribution statement.

+ **References**: 

1. https://data.cms.gov/Medicare-Inpatient/Inpatient-Prospective-Payment-System-IPPS-Provider/97k6-zzx3
2. https://data.cms.gov/Medicare-Inpatient/Inpatient-Prospective-Payment-System-IPPS-Provider/fm2n-hjj6
3. https://www.cms.gov/research-statistics-data-and-systems/statistics-trends-and-reports/medicare-provider-charge-data/inpatient.html
2. https://github.com/TZstatsADS/Spring2018-Project2-Group8
3. https://github.com/TZstatsADS/Spr2017-proj2-grp6
4. https://nycdatascience.com/blog/student-works/simple-medicare-hospital-recommendation-system/

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── app/
├── lib/
├── data/
├── doc/
└── output/
```

Please see each subfolder for a README file.


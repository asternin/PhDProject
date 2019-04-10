STEPS for running stats on Synchrony Values

1. For each ROI extract the .csv files with the structure: One row per participants, 16 columns for conditions
  data<-rename(data,c("V1"="1_song1", "V2"="1_song2", "V3"="1_song3", "V4"="1_song4",
                      "V5"="1_song5", "V6"="1_song6", "V7"="1_song7", "V8"="1_song8",
                      "V9"="2_song1", "V10"="2_song2", "V11"="2_song3", "V12"="2_song4",
                      "V13"="2_song5", "V14"="2_song6", "V15"="2_song7", "V16"="2_song8"))

2. Run AllStats.R to run all ANOVAs and ttests. This will produce a .txt with the print out of each test for each ROI. 
A *pval.csv is also produced for each ROI

3. Run AllStats_pvalAdj.R to FDR correct the pvalues. This will produce *pval_adj.csv for each ROI 
AND 
AdjPValSummary.txt document listing the indices of all p>0.06 

4. Compare the indices in the sumary document to the TestNumbers.txt document to determine which tests are significant

5. Record this in SynchronyStatsSummary.odt
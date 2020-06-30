## Reformat your GWAS summary statistics file for the analysis
# awk '{print $1, $2, $3, $4, $8, $9, $10, $16, $19, $17, $18}' METAANALYSIS_WR_RT_combined_STERR_GCOFF_1_chrpos.txt > METAANALYSIS_WR_RT_combined_STERR_GCOFF_1_chrpos_formatted.txt
# sed -Ei 's/MarkerName/SNP/;s/Allele1/A1/;s/Allele2/A2/;s/Freq1/FREQ1/;s/Effect/BETA/;s/StdErr/SE/;s/P-value/P/;s/TotalSampleSize/N/;s/chrposID/MARKER/;s/POS/BP/' METAANALYSIS_WR_RT_combined_STERR_GCOFF_1_chrpos_formatted.txt

awk '{print $1, $2, $3, $4, $8, $9, $10, $16, $19, $17, $18}' METAANALYSIS_WR_RT_EUR_combined_STERR_GCOFF_1_chrpos.txt > METAANALYSIS_WR_RT_EUR_combined_STERR_GCOFF_1_chrpos_formatted.txt
sed -Ei 's/MarkerName/SNP/;s/Allele1/A1/;s/Allele2/A2/;s/Freq1/FREQ1/;s/Effect/BETA/;s/StdErr/SE/;s/P-value/P/;s/TotalSampleSize/N/;s/chrposID/MARKER/;s/POS/BP/' METAANALYSIS_WR_RT_EUR_combined_STERR_GCOFF_1_chrpos_formatted.txt
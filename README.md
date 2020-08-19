# GenLang-evolution

All original scripts are available at Prof. Jason Stein's Bitbucket repository (https://bitbucket.org/jasonlouisstein/enigmaevolma6/src/master/). Original codes are adapted to our own data and research purposes.

## 1. Pre-processing

## 1.a) Reformatting your GWAS summary statistics
Reformat your GWAS summary statistics using `reformat_sumstats.sh`.
Your summary stats must be formatted as the following:

```
SNP A1 A2 FREQ1 BETA SE P N MARKER CHR BP
rs2977670 c g 0.9608 758.3807 485.5590 0.1183 10332 1:723891 1 723891
rs143225517 t c 0.8454 718.8055 232.3162 0.001974 15846 1:751756 1 751756
rs146277091 a g 0.0344 -1186.6514 501.2970 0.01793 10501 1:752478 1 752478
```

## 1.b) Save your summary statistics files in Rdata format
Save summary statistics files as Rdata files using `sumstats_txt2Rdata.R` and `run_sumstats_txt2Rdata.sh`.
Rdata files are smaller in size compared to txt files. Thus, working with them will speed up your analysis in the upcoming steps.
   
## 1.c) List summary statistics file names
Compile Rdata files names ("/path/to/dir/summary_stats.txt") to a single txt file using `list_rdata_files.R` and `run_list_rdata_files.sh`.

## 2. Assessing the impact of population stratification and Ancestry Regression

## 1.a) Assess your summmary stats prior to ancestry regression
Run the first correlation test between your summary statistics and 1000G phase 3 PC loadings (first 20 PCs).
Use `1000G_PC_cor_BJK_noGC.R` and `run_1000G_PC_cor_BJK_noGC.sh`.
Plot your results using `plot1000G_PC_cor_noGC_BJK.R` and `run_plot1000G_PC_cor_noGC_BJK.sh` (Fig.1a from Tilot et al., 2019).

## 1.b) Ancestry Regression - correcting for population stratification
"Using a standard multivariable regression implemented in R with the lm() function, we regress the GWAS summary statistics prior to ancestry regression (Beta_strat) with the ancestry PCs (Beta_PCs). The residuals of this model are then ancestry corrected effect sizes (Beta_r) and also have ancestry corrected standard errors and P-values." (from original repo.)
Use `AncestryRegression_noGC.R` and `run_AncestryRegression_noGC.sh`.

## 1.c) Assess your summmary stats after ancestry regression
Run the second correlation test between your summary statistics and 1000G phase 3 PC loadings (first 20 PCs).
Use `1000G_PC_cor_ancreg_BJK_noGC.R` and `run_1000G_PC_cor_ancreg_BJK_noGC.sh`.
Plot your results using `plot1000G_PC_cor_ancreg_noGC_BJK.R` and `run_plot1000G_PC_cor_ancreg_noGC_BJK.sh`  (Fig.1b from Tilot et al., 2019).

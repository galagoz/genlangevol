#!/bin/sh
#$ -N ldsc_munge
#$ -cwd
#$ -q single.q
#$ -S /bin/bash

#-----Munge Sumstats-----

# Reformat GWAS summary stats before computing LDSC intercept
# munge_sumstats.py is from github.com/bulik/ldsc
# Based on the tutorial at github.com/bulik/ldsc/wiki/Heritability-and-Genetic-Correlation

#-----Variables-----
# $input - summary statistic file
# $output - outfile_name
# ./ldsc_munge.sh /data/corpora/MPI_workspace/lag/lg-psy/raw_data/EAsumstats/data/EduYears_disc_rep_excl_ALSPAC_23andMe_sumstats.txt SES.2016 

input="/data/clusterfs/lag/users/gokala/METAANALYSIS_WR_RT_EUR_combined_STERR_GCOFF_1_chrpos_formatted.txt"
output="/data/clusterfs/lag/users/gokala/METAANALYSIS_WR_RT_EUR_combined_STERR_GCOFF_1_chrpos_formatted_munged.txt"

#-----

echo $input
echo $output
echo "Munging sumstats"

/usr/shared/modules/modulefiles/python-2.7.15/bin/python /usr/shared/modules/modulefiles/ldsc-v1.0.1/munge_sumstats.py \
--sumstats $input \
--out $output \
--merge-alleles /data/workspaces/lag/workspaces/lg-genlang/Working/Evolution/LDSC/Data/w_hm3.snplist

echo "Finished munging"

#-----

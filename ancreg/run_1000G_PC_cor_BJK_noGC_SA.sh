#!/bin/sh
#$ -N PC_cor_BJK_noGC_SA
#$ -cwd
#$ -q multi15.q
#$ -S /bin/bash

Rscript /data/clusterfs/lag/users/gokala/1000G_PC_cor_BJK_noGC_SA.R

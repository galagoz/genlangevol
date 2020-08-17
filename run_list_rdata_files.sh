#!/bin/sh
#$ -N ldsc_munge
#$ -cwd
#$ -q single.q
#$ -S /bin/bash

echo "Starting"
/usr/local/bin/Rscript testcor.R
echo "Done!"

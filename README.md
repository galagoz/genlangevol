# GenLang-evolution

All original scripts are available at Prof. Jason Stein's Bitbucket repository (https://bitbucket.org/jasonlouisstein/enigmaevolma6/src/master/). Original codes are adapted to our own data and research purposes.

1) Reformat your GWAS summary statistics as the following:

```
SNP A1 A2 FREQ1 BETA SE P N MARKER CHR BP
rs2977670 c g 0.9608 758.3807 485.5590 0.1183 10332 1:723891 1 723891
rs143225517 t c 0.8454 718.8055 232.3162 0.001974 15846 1:751756 1 751756
rs146277091 a g 0.0344 -1186.6514 501.2970 0.01793 10501 1:752478 1 752478
```

Use reformat_sumstats.sh

(Skip this step if you have a single phenotype)
2) a. Save summary statistics files as Rdata files.
   b. Compile files names ("/path/to/dir/summary_stats.txt") to a single txt file.

# ========================================================
# Make tables of LDSC partitioned heritability results

# The results files (.results) from the LDSC run should be organized
# by annotation, with separate directories for each annotation. 

# Updated for the nonGC version

# ========================================================

library(tidyverse)
library(kableExtra)

options(stringsAsFactors=FALSE)

annots = list.dirs(path = "/data/clusterfs/lag/users/gokala/genlang-evol/ancreg/munged/results/", full.names = F, recursive = F)



partheritresults = data.frame(Category = character(0),
                              Prop._SNPs= numeric(0),
                              Prop._h2= numeric(0),
                              Prop._h2_std_error= numeric(0),
                              Enrichment= numeric(0),
                              Enrichment_std_error= numeric(0),
                              Enrichment_p= numeric(0),
                              Annotation=character(0),
                              Analysis=character(0)) #Will have a matrix with rows = number of E3MAs and columns = # of annotations

#i=1
for (i in 1:length(annots)){
  print(annots[i])
  files = Sys.glob(path = paste0("/data/clusterfs/lag/users/gokala/genlang-evol/ancreg/munged/results/",annots[i],"/*.gz.results"))
  results = read.table(files,header=TRUE);
  info1 = str_split(files, pattern = "/")
  results$Annotation = info1[[1]][11]
  partheritresults = rbind(partheritresults,results[1,])
}
partheritresults$bonferroni = p.adjust(partheritresults$Enrichment_p, method = "bonferroni") # correcting for 7 tests/annotations
#partheritresults$annot.p <- if_else(partheritresults$bonferroni < 0.05, as.character(round(partheritresults$bonferroni, digits = 4)), "")
partheritresults$significant = if_else(partheritresults$bonferroni < 0.05, "Yes", "")
write.table(partheritresults, 
            paste0("/data/clusterfs/lag/users/gokala/genlang-evol/ancreg/munged/results/new_annots_partherit_results_bonf9.txt"),
            sep = "\t", col.names = TRUE, row.names = TRUE, quote = FALSE)

# Put eveything into a table
new_annot_results=read.table("/data/clusterfs/lag/users/gokala/genlang-evol/ancreg/munged/results/new_annots_partherit_results_bonf9.txt",header=T, sep = "\t")
save_kable(kable(new_annot_results, "latex", booktabs = T),"/data/workspaces/lag/workspaces/lg-genlang/Working/Evolution/results/partitioned_heritability/9annots_heritability_results.pdf")
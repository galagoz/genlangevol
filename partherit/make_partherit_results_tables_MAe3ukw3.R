# ========================================================
# Make tables of LDSC partitioned heritability results

# The results files (.results) from the LDSC run should be organized
# by annotation, with separate directories for each annotation. 

# Updated for the nonGC version

# ========================================================

library(tidyverse)

options(stringsAsFactors=FALSE)

annots = list.dirs(path = "/data/clusterfs/lag/users/gokala/genlang-evol/partherit/results/", full.names = F, recursive = F)
#i=1
for (i in 1:length(annots)){
      print(annots[i])
      files = Sys.glob(path = paste0("/data/clusterfs/lag/users/gokala/genlang-evol/partherit/results/",annots[i],"/*.gz.results"))
      partheritresults = data.frame(Category = character(0),
                                    Prop._SNPs= numeric(0),
                                    Prop._h2= numeric(0),
                                    Prop._h2_std_error= numeric(0),
                                    Enrichment= numeric(0),
                                    Enrichment_std_error= numeric(0),
                                    Enrichment_p= numeric(0),
                                    Annotation=character(0),
                                    Trait=character(0),
                                    Sample=character(0)) #Will have a matrix with rows = number of GenLang traits and columns = # of annotations
      
      for (j in 1:length(files)) {
        results = read.table(files[j],header=TRUE);
        info1 = str_split(files[j], pattern = "/")
        info2 = str_split(info1[[1]][11], pattern = "_")
        results$Annotation = info1[[1]][10]
        results$Trait = info2[[1]][1]
        results$Sample = info2[[1]][2]
        partheritresults = rbind(partheritresults,results[1,])
      }
      partheritresults = partheritresults %>% 
        #group_by(Trait) %>%
        mutate(fdr = p.adjust(Enrichment_p, method = "fdr"))# %>% # correcting for 35 tests, not 70
        #ungroup(partheritresults)
      partheritresults$annot.p <- if_else(partheritresults$fdr < 0.05, as.character(round(partheritresults$fdr, digits = 4)), "")
      partheritresults$significant = if_else(partheritresults$fdr < 0.05, "Yes", "")
      write.table(partheritresults, 
                  paste0("/data/clusterfs/lag/users/gokala/genlang-evol/partherit/results_tables/",unique(partheritresults$Annotation),"_results_FDR35.txt"),
                  sep = "\t", col.names = TRUE, row.names = TRUE, quote = FALSE)
    }

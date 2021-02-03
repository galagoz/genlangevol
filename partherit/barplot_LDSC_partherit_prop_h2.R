# ========================================================
# Making a barplot of the LDSC partitioned heritability
# "proportion of SNP heritability explained" for a single
# annotation. The human gained enhancers data is what
# I'm plotting here, for manuscript Figure 3B.

# updated for the nonGC version

# ========================================================

library(tidyverse)
library(scales)
library(BSDA)
library(ggplot2)

options(stringsAsFactors=FALSE)

annots = list.files(path = "/data/clusterfs/lag/users/gokala/genlang-evol/partherit/results_tables/", full.names = F,recursive = F)
datalist=list()

for (i in 1:length(annots)){
  print(annots[i])
  annotname=str_split(annots[i], pattern = "\\.")[[1]][1]
  resultsFile <- Sys.glob(paste0("/data/clusterfs/lag/users/gokala/genlang-evol/partherit/results_tables/",annots[i]))
  results <- read.table(resultsFile[1], header = TRUE, sep = "\t")
  results$Trait <- factor(results$Trait)
  datalist[[i]] <- results # add it to your list
  #label.df <- data.frame(Trait = results$Trait[results$significant=="Yes"],Prop._h2=results$Prop._h2[results$significant=="Yes"]+0.05)
}
all_data = do.call(rbind, datalist)
eur_data = all_data[all_data$Sample=="EUR",]
com_data = all_data[all_data$Sample=="combined",]

y_max <- max(com_data[, 3])
y_axis_max <- y_max + com_data[com_data$Prop._h2 == y_max, 4] + 0.01
label.df <- data.frame(Trait = com_data$Trait[com_data$significant=="Yes"],Prop._h2=com_data$Prop._h2[com_data$significant=="Yes"]-0.015)
plot_data=com_data[com_data$Annotation=="NeanSNPs_3col",]

p1 <- ggplot(data = plot_data, aes(Trait, Prop._h2)) +
  geom_bar(stat = "identity", position = "dodge", fill = "burlywood4") +
  geom_linerange(position = position_dodge(width = 0.9), aes(ymin = Prop._h2 - Prop._h2_std_error, ymax = Prop._h2 + Prop._h2_std_error)) +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position = "bottom") +
  labs(
    x = "Trait",
    y = expression(paste("Proportion ", italic("h"^{2}))),
    title = "Partitioned heritability for reading traits, following ancestry regression",
    subtitle = "Proportion of heritability explained - All ancestries"
  )
p1 + geom_text(data = label.df, label = "*")
ggsave("/data/workspaces/lag/workspaces/lg-genlang/Working/Evolution/partherit/h2_Prop_genlang_combined_subset_ancreg_Phase3_squished.pdf", width = 6.5, height = 3.25, units = "in")

p2 <- ggplot(data = plot_data, aes(Trait, Enrichment)) +
  geom_bar(stat="identity", position = "dodge", fill = "saddlebrown")+
  geom_linerange(position = position_dodge(width = 0.9), aes(ymin=Enrichment-Enrichment_std_error, ymax=Enrichment+Enrichment_std_error))+
  geom_text(aes(x = Trait, y = Enrichment+(Enrichment_std_error+2), label = annot.p), position = position_dodge(width = 0.9), size = 3,  fontface=3, hjust = 0, vjust = 0, angle = 45)+
  theme_classic()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(x = "Trait", 
       y = "Enrichment")
p2
ggsave("/data/workspaces/lag/workspaces/lg-genlang/Working/Evolution/partherit/h2_enrich_genlang_combined_subset_ancreg_Phase3_squished.pdf", width = 6.5, height = 3.25, units = "in")
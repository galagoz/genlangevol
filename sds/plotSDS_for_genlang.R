

corvals = read.csv("/data/clusterfs/lag/users/gokala/genlang-evol/sds/SDS_bjk_NOancreg_1kblocks.csv")
corvals_ancreg = read.csv("/data/clusterfs/lag/users/gokala/genlang-evol/sds/SDS_bjk_ancreg_1kblocks.csv")
combined = corvals[grep("combined",corvals$X),]
eur = corvals[grep("EUR",corvals$X),]
combined_ancreg = corvals_ancreg[grep("combined",corvals_ancreg$X),]
eur_ancreg = corvals_ancreg[grep("EUR",corvals_ancreg$X),]

combined$trait = sapply(as.character(combined$X),function (x) {unlist(strsplit(x,"_",fixed=TRUE))[1]})
eur$trait = sapply(as.character(eur$X),function (x) {unlist(strsplit(x,"_",fixed=TRUE))[1]})
combined_ancreg$trait = sapply(as.character(combined_ancreg$X),function (x) {unlist(strsplit(x,"_",fixed=TRUE))[1]})
eur_ancreg$trait = sapply(as.character(eur_ancreg$X),function (x) {unlist(strsplit(x,"_",fixed=TRUE))[1]})

# benjamini-hochberg correction and filtering

combined$padj = p.adjust(combined$BJK_ESTIM_PVAL,"BH")
combined$BJK_ESTIM_AVE[which(combined$padj > 0.05)] = 0
eur$padj = p.adjust(eur$BJK_ESTIM_PVAL,"BH")
eur$BJK_ESTIM_AVE[which(eur$padj > 0.05)] = 0
combined_ancreg$padj = p.adjust(combined_ancreg$BJK_ESTIM_PVAL,"BH")
combined_ancreg$BJK_ESTIM_AVE[which(combined_ancreg$padj > 0.05)] = 0
eur_ancreg$padj = p.adjust(eur_ancreg$BJK_ESTIM_PVAL,"BH")
eur_ancreg$BJK_ESTIM_AVE[which(eur_ancreg$padj > 0.05)] = 0
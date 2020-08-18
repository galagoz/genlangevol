##/usr/local/R-3.2.3/bin/R
##Run Correlation of effect sizes from GWAS of 1000G PC components with effect sizes from ENIGMA
##The effects sizes from GWAS of 1000G PC components were acquired from Katya and are from phase 3
##They were calculated by deriving PCs from 1000G (all populations) and correlating that with SNPs
##The goal here is to see if population stratification is driving the results

##This script does the work for 1000G_PC_cor_BJK_noGC_pp.R

options(stringsAsFactors=FALSE)

args = commandArgs(trailingOnly=TRUE)
frdatafile = args[1];
phenoname = args[2];
outputdir = args[3];

#frdatafile = "1kg_phase3_ns.allpop.unrel2261_eigenvec.P1to20_beta_se_pval.RData"
phenoname = "word_reading"
#outputdir = "P:/workspaces/lg-genlang/Working/Evolution/output";
outputdir = "K:/data/MPI"

##load 1000G PC effect sizes (basically an estimate population stratification for each SNP)
kGread=read.table("P:/workspaces/lg-genlang/Working/Evolution/1kg_phase3_ns.allpop.unrel2261_eigenvec.P1to20_beta_se_pval.txt",header=T,stringsAsFactors=F)
#save(kGread,file="1kg_phase3_ns.allpop.unrel2261_eigenvec.P1to20_beta_se_pval.RData")
frdatafile=read.table("P:/workspaces/lg-genlang/Working/Evolution/METAANALYSIS_WR_RT_EUR_combined_STERR_GCOFF_1_chrpos_formatted.txt",header=T,fill=T,stringsAsFactors=F)
#save(frdatafile,file="METAANALYSIS_WR_RT_EUR_combined_STERR_GCOFF_1_chrpos_formatted.RData")

##Block jackknife function
cor.test.jack = function(x, y, blocks=1000) {

  keep = is.finite(x) & is.finite(y)
  x = x[keep]
  y = y[keep]
  mat = cbind(x, y, floor(seq(1, blocks+1-1e-3, len=length(x))))
  part_ests = sapply(1:blocks, function(i) cor(mat[mat[,3] != i, 1], mat[mat[,3] != i, 2]))
  jack_est = mean(part_ests)
  jack_se = sqrt((blocks-1)/blocks * sum((jack_est - part_ests)^2))
  jack_z = jack_est/jack_se;
  jack_p = 2*pnorm( -abs(jack_z));
  list(estimate=jack_est, se=jack_se, p=jack_p, estimate_normal=cor(x, y), se_normal=cor.test.plus(x, y)$se)

}

cor.test.plus <- function(x, y, ...) {

  # like cor.test, but also returns se of correlation
  corr = cor.test(x, y, ...)
  corr$se = unname(sqrt((1 - corr$estimate^2)/corr$parameter))
  corr

}

##set output variable
output=data.frame(matrix(NA,ncol=60,nrow=1));
colnames(output)[seq(1,60,3)] = paste0("BJK_cor",seq(1,20));
colnames(output)[seq(2,60,3)] = paste0("BJK_SE",seq(1,20));
colnames(output)[seq(3,60,3)] = paste0("BJK_P",seq(1,20))
rownames(output) = phenoname;

##Read in 1000G file
#load(kGread);
##Read in the summary statistics
#load(frdatafile);

##calculate Z score in GWAS files
frdatafile$Z=NA;
frdatafile$Z=frdatafile$BETA/frdatafile$SE;
GWAS = frdatafile #as.data.frame(mcols(GWASranges));

##Merge 1kgp with GWAS
merged = merge(kGread, GWAS, by="SNP") ##x=kG, y=GWAS
##remove all NAs, keep only SNPs that have both measurements
ind=which(!is.na(merged$Z))
merged=merged[ind,]
##for unaligned alleles, flip the Z score
unalignedind=which(toupper(merged$A1.x)==toupper(merged$A2.y) & toupper(merged$A2.x)==toupper(merged$A1.y));
##alignedind=which(toupper(merged$A1.x)==toupper(merged$A1.y) & toupper(merged$A2.x)==toupper(merged$A2.y));

merged$Z[unalignedind] = (-1)* merged$Z[unalignedind];
merged$BETA[unalignedind] = (-1)* merged$BETA[unalignedind];

##Need to resort the merged file
mergedGR = GRanges(merged$CHR.x,IRanges(merged$POS,merged$POS));
mcols(mergedGR) = merged[,c(1,3,5:74)];
merged = as.data.frame(sort(sortSeqlevels(mergedGR)));

##Loop over all components
for  (k in 1:20) {

     coroutput=cor.test.jack(merged[,seq(10,67,3)[k]], merged$BETA);
     output[1,seq(1,60,3)[k]] = coroutput$estimate;
     output[1,seq(2,60,3)[k]] = coroutput$se;
     output[1,seq(3,60,3)[k]] = coroutput$p;

     print(k);
     print(coroutput);

}
  
write.csv(output, paste0(outputdir, "/corvalues_",phenoname,"_BJK.csv"))

#############################

phenoname = "word_reading"
#outputdir = "P:/workspaces/lg-genlang/Working/Evolution/output";
outputdir = "K:/data/MPI"

##load 1000G PC effect sizes (basically an estimate population stratification for each SNP)
kGread=read.table("P:/workspaces/lg-genlang/Working/Evolution/1kg_phase3_ns.allpop.unrel2261_eigenvec.P1to20_beta_se_pval.txt",header=T,stringsAsFactors=F)
#save(kGread,file="1kg_phase3_ns.allpop.unrel2261_eigenvec.P1to20_beta_se_pval.RData")
frdatafile_total=read.table("P:/workspaces/lg-genlang/Working/Evolution/METAANALYSIS_WR_RT_combined_STERR_GCOFF_1_chrpos_formatted.txt",header=T,fill=T,stringsAsFactors=F)
#save(frdatafile,file="METAANALYSIS_WR_RT_EUR_combined_STERR_GCOFF_1_chrpos_formatted.RData")

##Block jackknife function
cor.test.jack = function(x, y, blocks=1000) {
  
  keep = is.finite(x) & is.finite(y)
  x = x[keep]
  y = y[keep]
  mat = cbind(x, y, floor(seq(1, blocks+1-1e-3, len=length(x))))
  part_ests = sapply(1:blocks, function(i) cor(mat[mat[,3] != i, 1], mat[mat[,3] != i, 2]))
  jack_est = mean(part_ests)
  jack_se = sqrt((blocks-1)/blocks * sum((jack_est - part_ests)^2))
  jack_z = jack_est/jack_se;
  jack_p = 2*pnorm( -abs(jack_z));
  list(estimate=jack_est, se=jack_se, p=jack_p, estimate_normal=cor(x, y), se_normal=cor.test.plus(x, y)$se)
  
}

cor.test.plus <- function(x, y, ...) {
  
  # like cor.test, but also returns se of correlation
  corr = cor.test(x, y, ...)
  corr$se = unname(sqrt((1 - corr$estimate^2)/corr$parameter))
  corr
  
}

##set output variable
output_total=data.frame(matrix(NA,ncol=60,nrow=1));
colnames(output_total)[seq(1,60,3)] = paste0("BJK_cor",seq(1,20));
colnames(output_total)[seq(2,60,3)] = paste0("BJK_SE",seq(1,20));
colnames(output_total)[seq(3,60,3)] = paste0("BJK_P",seq(1,20))
rownames(output_total) = phenoname;

##Read in 1000G file
#load(kGread);
##Read in the summary statistics
#load(frdatafile);

##calculate Z score in GWAS files
frdatafile_total$Z=NA;
frdatafile_total$Z=frdatafile_total$BETA/frdatafile_total$SE;
GWAS_total = frdatafile_total #as.data.frame(mcols(GWASranges));

##Merge 1kgp with GWAS
merged_total = merge(kGread, GWAS_total, by="SNP") ##x=kG, y=GWAS
##remove all NAs, keep only SNPs that have both measurements
ind=which(!is.na(merged_total$Z))
merged_total=merged_total[ind,]
##for unaligned alleles, flip the Z score
unalignedind_total=which(toupper(merged_total$A1.x)==toupper(merged_total$A2.y) & toupper(merged_total$A2.x)==toupper(merged_total$A1.y));
##alignedind=which(toupper(merged$A1.x)==toupper(merged$A1.y) & toupper(merged$A2.x)==toupper(merged$A2.y));

merged_total$Z[unalignedind_total] = (-1)* merged_total$Z[unalignedind_total];
merged_total$BETA[unalignedind_total] = (-1)* merged_total$BETA[unalignedind_total];

##Need to resort the merged file
mergedGR_total = GRanges(merged_total$CHR.x,IRanges(merged_total$POS,merged_total$POS));
mcols(mergedGR_total) = merged_total[,c(1,3,5:74)];
merged_total = as.data.frame(sort(sortSeqlevels(mergedGR_total)));

##Loop over all components
for  (k in 1:20) {
  
  coroutput_total=cor.test.jack(merged_total[,seq(10,67,3)[k]], merged_total$BETA);
  output_total[1,seq(1,60,3)[k]] = coroutput_total$estimate;
  output_total[1,seq(2,60,3)[k]] = coroutput_total$se;
  output_total[1,seq(3,60,3)[k]] = coroutput_total$p;
  
  print(k);
  print(coroutput_total);
  
}

write.csv(output_total, paste0(outputdir, "/corvalues_",phenoname,"_total_BJK.csv"))
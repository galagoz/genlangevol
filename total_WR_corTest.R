phenoname = "word_reading"
outputdir = "/data/clusterfs/lag/users/gokala"

##load 1000G PC effect sizes (basically an estimate population stratification for each SNP)
kGread=read.table("/data/clusterfs/lag/users/gokala/1kg_phase3_ns.allpop.unrel2261_eigenvec.P1to20_beta_se_pval.txt",header=T,stringsAsFactors=F)
#save(kGread,file="1kg_phase3_ns.allpop.unrel2261_eigenvec.P1to20_beta_se_pval.RData")
frdatafile=read.table("/data/clusterfs/lag/users/gokala/METAANALYSIS_WR_RT_combined_STERR_GCOFF_1_chrpos_formatted.txt",header=T,fill=T,stringsAsFactors=F)
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
  
  coroutput_total=cor.test.jack(merged[,seq(10,67,3)[k]], merged$BETA);
  output[1,seq(1,60,3)[k]] = coroutput_total$estimate;
  output[1,seq(2,60,3)[k]] = coroutput_total$se;
  output[1,seq(3,60,3)[k]] = coroutput_total$p;
  
  print(k);
  print(coroutput_total);
  
}

write.csv(output, paste0(outputdir, "/corvalues_",phenoname,"_total_BJK.csv"))
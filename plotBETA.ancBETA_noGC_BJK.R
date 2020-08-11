##/usr/local/R-3.2.3/bin/R
##Correlate the effect sizes before and after ancestry regression
options(stringsAsFactors=FALSE)
library(GenomicRanges);

##read in gwas statistics file (compiled for all traits)
fGWASsumstats = "/ifs/loni/faculty/dhibar/ENIGMA3/MA6/evolution/1000Gphase3_PC_cor/AncestryRegressionData_noGC/GWASfiles.txt";
##LDSC intercept values from original ENIGMA (not ancestry regressed)
fLDSCint = "/ifs/loni/faculty/dhibar/ENIGMA3/MA6/evolution/SDS_E3ancreg1KGP3_noGC/code/LDSC_intercepts_from_Rdata_w_and_wo_GC_ancreg.csv";

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

##Match the Rdata file locations of sumstats, text file sumstats, and clumped files
GWASsumstats=read.table(fGWASsumstats, header=FALSE)$V1;
##Parse to get trait name
tmpname = sapply(GWASsumstats,function (x) {unlist(strsplit(x,"/",fixed=TRUE))[11]});
tmpnamepheno = paste(sapply(tmpname,function (x) {unlist(strsplit(x,"_",fixed=TRUE))[1]}),sapply(tmpname,function (x) {unlist(strsplit(x,"_",fixed=TRUE))[2]}),sapply(tmpname,function (x) {unlist(strsplit(x,"_",fixed=TRUE))[3]}),sep="_");
phenoname = "WR_Eur_ancreg";

##Make output matrices for the correlations
output = matrix(NA,nrow=length(phenoname),ncol=3);
rownames(output) = phenoname;
colnames(output) = c("corBETA","corSE","corP");

##Perform correlations pre and post ancestry regression
for (i in 1:length(GWASsumstats)) {
    #load("P:/workspaces/lg-genlang/Working/Evolution/Word_Reading_ancreg.Rdata")
    #GWAS = as.data.frame(mcols(mergedGR))
    coroutput=cor.test.jack(mergedGR$BETA,mergedGR$ancBETA);
    output[i,1] = coroutput$estimate;
    output[i,2] = coroutput$se;
    output[i,3] = coroutput$p;
}

write.csv(output,file="P:/workspaces/lg-genlang/Working/Evolution/BETA.ancBETA_WR_Eur.csv",quote=FALSE);
##output = read.csv('BETA.ancBETA_noGC_BJK.csv',row.names=1);
stop();

##Plot the results
pdf(file="P:/workspaces/lg-genlang/Working/Evolution/BETA.ancBETA_WR_Eur.pdf");
plot(1,output[,1],ylab="cor(BETA,ancestry adj BETA)",xlab="GWAS",pch=19,xaxt="n",main="Effect sizes");
axis(1,at=1,labels=phenoname,las=2,cex.axis=0.3);

##Correlate these to the LDSC intercept values
##Take only the LDSC intercepts from ancestry regressed, non-GC corrected, surface area
#LDSCint = read.csv(fLDSCint);
#ind = which(LDSCint$Surf_Thic=="Surface Area" & LDSCint$GC_status==FALSE & LDSCint$ancreg==TRUE);
#LDSCint = LDSCint[ind,];
##Rearrange in same order
#LDSCint = LDSCint[c(7,1:6,8:35),];

#matchedout = output[c(grep("Full_SurfArea",rownames(output)),grep("surfavg",rownames(output))),];

#tmpcor = cor.test(matchedout$corBETA,LDSCint$LDSC_intercept);
#corval = tmpcor$estimate;
#pval = tmpcor$p.value;
#model = lm(LDSCint$LDSC_intercept ~ matchedout$corBETA);
#plot(matchedout$corBETA,LDSCint$LDSC_intercept,xlab="cor(BETA, ancestry adj BETA)",ylab="LDSC Intercept unadjusted",main=paste0("LDSC intercept vs BETA correlation\ncor=",signif(corval,3),"; pval=",signif(pval,3)),pch=19);
#x = range(matchedout$corBETA);
#y = model$coefficients[1] + model$coefficients[2]*x;
#lines(x,y,lty=2,col="grey");
##Label some of the big ones with text
#labelind = which(LDSCint$LDSC_intercept>1.02 | matchedout$corBETA<0.9980);
#text(matchedout$corBETA[labelind],LDSCint$LDSC_intercept[labelind],rownames(matchedout)[labelind],pos=4);

#dev.off();

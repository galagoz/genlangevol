##/usr/local/R-3.2.3/bin/R
##Run Correlation of effect sizes from GWAS of 1000G PC components with effect sizes from GIANT height after ancestry regression
##The effects sizes from GWAS of 1000G PC components were acquired from Katya and are from phase 3
##They were calculated by deriving PCs from 1000G (all populations) and correlating that with SNPs
##The goal here is to see if population stratification is driving the results

##Install hexbin package for making hexagon scatterplots
##install.packages("hexbin")
##library(hexbin)
options(stringsAsFactors=FALSE)
library(GenomicRanges);

dircorvals = "P:/workspaces/lg-genlang/Working/Evolution/corvals";
##Output file
foutput = "P:/workspaces/lg-genlang/Working/Evolution/corvalues_WR_Eur_BJK.pdf";

fcorvals = dir(dircorvals,full.names=TRUE,pattern="csv");

##Make a pdf file of correlation estimates
pdf(foutput);
par(las=2);

for (i in 1:length(fcorvals)) {
    
    ##Read in correlation values
    corvals = read.csv("P:/workspaces/lg-genlang/Working/Evolution/corvals/corvalues_WR_Eur_BJK.csv");
    #corvals = read.csv(fcorvals[i]);
    ##Make barplots of correlation estimates for each
    corind = grep("BJK_cor",colnames(corvals));
    pind = grep("BJK_P",colnames(corvals));
    seind = grep("BJK_SE",colnames(corvals));
    x = barplot(as.matrix(corvals[1,corind]),main="WR_Eur",ylab="correlation coefficient",xlab="Ancestry PC",names.arg=paste0("PC",seq(1,20)),ylim=c(-0.1,0.1));#main=corvals$X[1]
    y0 = as.numeric(corvals[1,corind]-corvals[1,seind]);
    y1 = as.numeric(corvals[1,corind]+corvals[1,seind]);
    arrows(x,y0,x,y1,angle=90,length=0)
    ##Add asterisk when significant (Bonferroni corrected)
    bonfsigind = which(corvals[1,pind] < 0.05/20);
    ## draw asterisk for significant ones
    ##text(x[sigind]+((x[sigind+1]-x[sigind])/2),0.095,"*");
    text(x[bonfsigind],0.095,"*");
    ##Add o when nominally significant
    nomsigind = which(corvals[1,pind] >= 0.05/20 & corvals[1,pind] < 0.05);
    text(x[nomsigind],0.095,"o");
    
}
dev.off();

options(stringsAsFactors=FALSE)
library(GenomicRanges);

dircorvals = "/ifs/loni/faculty/dhibar/ENIGMA3/MA6/evolution/1000Gphase3_PC_cor/beta_r_noGC/output/";
##Output file
foutput = "/ifs/loni/faculty/dhibar/ENIGMA3/MA6/evolution/1000Gphase3_PC_cor/beta_r_noGC/output/corvalues_residual_BJK_allinone.pdf";

fcorvals = dir(dircorvals,full.names=TRUE);
ind = grep("surfavg",fcorvals);
fcorvals = fcorvals[ind];

##Make a pdf file of correlation estimates
pdf(foutput,width=8.5,height=11);
par(las=2,mfrow=c(5,4));

for (i in 1:length(fcorvals)) {
    
    ##Read in correlation values
    corvals = read.csv(fcorvals[i]);
    
    ##Make barplots of correlation estimates for each
    corind = grep("BJK_cor",colnames(corvals));
    pind = grep("BJK_P",colnames(corvals));
    seind = grep("BJK_SE",colnames(corvals));
    x = barplot(as.matrix(corvals[1,corind]),main=unlist(strsplit(corvals$X[1],"_"))[2],ylab="correlation coefficient",xlab="Ancestry PC",names.arg=paste0("PC",seq(1,20)),ylim=c(-0.1,0.1),cex.axis=0.7,cex.names=0.7);
    y0 = as.numeric(corvals[1,corind]-corvals[1,seind]);
    y1 = as.numeric(corvals[1,corind]+corvals[1,seind]);
    arrows(x,y0,x,y1,angle=90,length=0)
    ##Add asterisk when significant (Bonferroni corrected)
    bonfsigind = which(corvals[1,pind] < 0.05/20);
    ## draw asterisk for significant ones
    ##text(x[sigind]+((x[sigind+1]-x[sigind])/2),0.095,"*");
    text(x[bonfsigind],0.095,"*");
    ##Add o when nominally significant
    nomsigind = which(corvals[1,pind] >= 0.05/20 & corvals[1,pind] < 0.05);
    text(x[nomsigind],0.095,"o");
    
}
dev.off();
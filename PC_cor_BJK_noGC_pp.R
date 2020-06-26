##/usr/local/R-3.2.3/bin/R
##Run Correlation of effect sizes from GWAS of 1000G PC components with effect sizes from ENIGMA
##The effects sizes from GWAS of 1000G PC components were acquired from Katya and are from phase 3
##They were calculated by deriving PCs from 1000G (all populations) and correlating that with SNPs
##The goal here is to see if population stratification is driving the results

##This script will drive 1000G_PC_cor_BJK_noGC_slave.R
##So it can be distributed across multiple nodes
 
##Install hexbin package for making hexagon scatterplots
##install.packages("hexbin")
##library(hexbin)
options(stringsAsFactors=FALSE)

##directory of spearman's output
outputdir = "/data/clusterfs/lag/users/gokala/";
##Rdata files containing GWAS summary statistics
rdatafileloc = "/data/clusterfs/lag/users/gokala/Rdatafiles_noGC/";
##read in gwas statistics file (compiled for all traits)
#fGWASsumstats = "GWASfiles_noGC.txt"

##Match the Rdata file locations of sumstats, text file sumstats
#GWASsumstats=read.table(fGWASsumstats, header=FALSE)$V1
##Parse to get trait name
#tmpname = sapply(GWASsumstats,function (x) {unlist(strsplit(x,"/",fixed=TRUE))[9]});
#tmpnamepheno = paste("Mean",sapply(tmpname,function (x) {unlist(strsplit(x,"_",fixed=TRUE))[5]}),sapply(tmpname,function (x) {unlist(strsplit(x,"_",fixed=TRUE))[6]}),sep="_");
#phenoname = substr(tmpnamepheno,1,nchar(tmpnamepheno)-1);
#rdatafiles = paste0(rdatafileloc,substr(tmpnamepheno,1,nchar(tmpnamepheno)-1),".Rdata");
#allfileloc = data.frame(txtfile=GWASsumstats,rdatafile=rdatafiles);

#for (i in 1:nrow(allfileloc)) {
for (i in 1:nrow(rdatafileloc)) {
    ##Generate the file to submit to the grid
    cat('cd /data/clusterfs/lag/users/gokala/Rdatafiles_noGC/\n',file=paste0(outputdir,"WR_RT",'.sh'));
    cat(paste0('/usr/local/R-3.2.3/bin/Rscript /data/clusterfs/lag/users/gokala/PC_cor_BJK_noGC_sp.R ',allfileloc$rdatafile[i]," ",phenoname[i]," ",outputdir,"/output"),file=paste0(outputdir,'/scripts/',phenoname[i],'.sh'),append=TRUE);

    ##Make executable
    system(paste0("chmod a+x ",outputdir,'/scripts/',phenoname[i],'.sh'));

    ##Submit the file to the grid
    system(paste0('qsub ',outputdir,'/scripts/',phenoname[i],'.sh'));
}



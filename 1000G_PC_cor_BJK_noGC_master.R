##/usr/local/R-3.2.3/bin/R
##Run Correlation of effect sizes from GWAS of 1000G PC components with effect sizes from ENIGMA
##The effects sizes from GWAS of 1000G PC components were acquired from Katya and are from phase 3
##They were calculated by deriving PCs from 1000G (all populations) and correlating that with SNPs
##The goal here is to see if population stratification is driving the results

##This script will drive PC_cor_BJK_noGC_sp.R
##So it can be distributed across multiple nodes
 
options(stringsAsFactors=FALSE)

##directory of spearman's output
outputdir = "/data/clusterfs/lag/users/gokala/beta/"
##Rdata files containing GWAS summary statistics
rdatafileloc = "/data/clusterfs/lag/users/gokala/sumstatsRdata/"

##read in gwas statistics file (compiled for all traits)
fGWASsumstats=gsub(" ","",paste(outputdir,"sumstats_rdata_list.txt"))
#write.table(dir(rdatafileloc, pattern="Rdata", all.files=T,full.names=T),file=fGWASsumstats,row.names=F,col.names=F,quote=F)

#GWASsumstats=as.character(read.table("P:/workspaces/lg-genlang/Working/Evolution/sumstats_rdata_list.txt",header=F)$V1)
#fGWASsumstats="P:/workspaces/lg-genlang/Working/Evolution/sumstats_rdata_list.txt"
##Match the Rdata file locations of sumstats, text file sumstats
GWASsumstats=as.character(read.table(fGWASsumstats, header=FALSE)$V1)
##Parse to get trait name
tmpname = sapply(GWASsumstats,function (x) {unlist(strsplit(x,"/",fixed=TRUE))[7]})
phenoname = paste(sapply(tmpname,function (x) {unlist(strsplit(x,"_",fixed=TRUE))[2]}),sapply(tmpname,function (x) {unlist(strsplit(x,"_",fixed=TRUE))[4]}),sep="_")
allfileloc = data.frame(rdatafiles=GWASsumstats)

for (i in 1:nrow(allfileloc)) {
    ##Generate the file to submit to the grid
    cat('cd /data/clusterfs/lag/users/gokala/scripts\n',file=paste0(outputdir,'/scripts/',phenoname[i],'.sh'))
    cat(paste0('/usr/local/bin/Rscript /data/clusterfs/lag/users/gokala/1000G_PC_cor_BJK_noGC_slave.R ',allfileloc$rdatafile[i]," ",phenoname[i]," ",outputdir,"/output"),file=paste0(outputdir,'/scripts/',phenoname[i],'.sh'),append=TRUE)
    ##Make executable
    system(paste0("chmod a+x ",outputdir,'/scripts/',phenoname[i],'.sh'))
    ##Submit the file to the grid
    system(paste0('qsub ',outputdir,'/scripts/',phenoname[i],'.sh'))
}
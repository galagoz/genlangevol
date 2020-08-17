options(stringsAsFactors=FALSE)

##directory of spearman's output
outputdir = "/data/clusterfs/lag/users/gokala/beta/"
#P:/workspaces/lg-genlang/Working/Evolution/
#/data/clusterfs/lag/users/gokala/beta/
##Rdata files containing GWAS summary statistics
rdatafileloc = "/data/clusterfs/lag/users/gokala/sumstatsRdata"
#/data/clusterfs/lag/users/gokala/sumstatsRdata/
#P:/data/clusterfs/lag/users/gokala/sumstatsRdata
##read in gwas statistics file (compiled for all traits)
fGWASsumstats=gsub(" ","",paste(outputdir,"sumstats_rdata_list.txt"))
write.table(dir(rdatafileloc, pattern="Rdata", all.files=T,full.names=T),file=fGWASsumstats,row.names=F,col.names=F,quote=F)

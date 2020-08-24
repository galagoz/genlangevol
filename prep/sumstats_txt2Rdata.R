## This script converts txt files to Rdata format;
## PC_cor_BJK_no_pp.R script reads the output of this script.

inputDir="/data/clusterfs/lag/users/gokala/sumstats/"
outputDir="/data/clusterfs/lag/users/gokala/sumstatsRdata/"
#/data/clusterfs/lag/users/gokala/sumstats
#P:/workspaces/lg-genlang/Working/Evolution/sumstatsRdata/
#/data/workspaces/lag/workspaces/lg-genlang/Working/Evolution/sumstats

for (i in dir(inputDir, pattern="formatted", all.files=F, full.names=F)) {
  tmp_dir=gsub(" ","", paste(inputDir,i), fixed=T)
  tmp_ss_table=read.table(tmp_dir, header=T, fill=T, stringsAsFactors=F)
  RdataDir=paste(outputDir,gsub("txt", "Rdata", i))
  save(tmp_ss_table,file=gsub(" ","", RdataDir))
}

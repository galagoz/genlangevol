## This script converts txt files to Rdata forma

inputDir="/data/clusterfs/lag/users/gokala/"
outputDir="/data/clusterfs/lag/users/gokala/beta"
#/data/clusterfs/lag/users/gokala/sumstats
#P:/workspaces/lg-genlang/Working/Evolution/sumstatsRdata/
#/data/workspaces/lag/workspaces/lg-genlang/Working/Evolution/sumstats


for (i in dir(inputDir, pattern="averaged.out", all.files=F, full.names=F)) {
  tmp_dir=gsub(" ","", paste(inputDir,i), fixed=T)
  tmp_ss_table=read.table(tmp_dir, header=T, fill=T, stringsAsFactors=F)
  save(tmp_ss_table,file=tmp_dir)
}

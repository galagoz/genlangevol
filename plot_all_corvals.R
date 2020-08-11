## Plot all

dircorvals = "P:/workspaces/lg-genlang/Working/Evolution/corvals"
##Output file
foutput = "P:/workspaces/lg-genlang/Working/Evolution/corvalues_all_BJK.pdf";
#fcorvals = dir(dircorvals,full.names=TRUE,pattern="csv");

##Make a pdf file of correlation estimates
pdf(foutput,width=8.5,height=7.5);
par(las=2,mfrow=c(2,2));


  ##Read in correlation values
  corvals = read.csv("P:/workspaces/lg-genlang/Working/Evolution/corvals/corvalues_WR_Eur_BJK.csv");
  
  ##Make barplots of correlation estimates for each
  corind = grep("BJK_cor",colnames(corvals));
  pind = grep("BJK_P",colnames(corvals));
  seind = grep("BJK_SE",colnames(corvals));
  x = barplot(as.matrix(corvals[1,corind]),main="EUR",ylab="Correlation Coefficient",xlab="Ancestry PCs",names.arg=paste0("PC",seq(1,20)),ylim=c(-0.1,0.1));
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
  
  corvals = read.csv("P:/workspaces/lg-genlang/Working/Evolution/corvals/corvalues_WR_total_BJK.csv");
  
  ##Make barplots of correlation estimates for each
  corind = grep("BJK_cor",colnames(corvals));
  pind = grep("BJK_P",colnames(corvals));
  seind = grep("BJK_SE",colnames(corvals));
  x = barplot(as.matrix(corvals[1,corind]),main="Total",ylab="Correlation Coefficient",xlab="Ancestry PCs",names.arg=paste0("PC",seq(1,20)),ylim=c(-0.1,0.1));
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
  
  corvals = read.csv("P:/workspaces/lg-genlang/Working/Evolution/corvals/corvalues_WR_ancreg_Eur_BJK.csv");
  
  ##Make barplots of correlation estimates for each
  corind = grep("BJK_cor",colnames(corvals));
  pind = grep("BJK_P",colnames(corvals));
  seind = grep("BJK_SE",colnames(corvals));
  x = barplot(as.matrix(corvals[1,corind]),main="EUR - Ancestry Regressed",ylab="Correlation Coefficient",xlab="Ancestry PCs",names.arg=paste0("PC",seq(1,20)),ylim=c(-0.1,0.1));
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
  
  corvals = read.csv("P:/workspaces/lg-genlang/Working/Evolution/corvals/corvalues_WR_ancreg_total_BJK.csv");
  
  ##Make barplots of correlation estimates for each
  corind = grep("BJK_cor",colnames(corvals));
  pind = grep("BJK_P",colnames(corvals));
  seind = grep("BJK_SE",colnames(corvals));
  x = barplot(as.matrix(corvals[1,corind]),main="Total - Ancestry Regressed",ylab="Correlation Coefficient",xlab="Ancestry PCs",names.arg=paste0("PC",seq(1,20)),ylim=c(-0.1,0.1));
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
  
dev.off()
## Plot all
library(ggplot2)
library(dplyr)
library(tidyr)
library(cowplot)

dircorvals = "P:/workspaces/lg-genlang/Working/Evolution/corvals"

##Read in correlation values
corvals = read.csv("P:/workspaces/lg-genlang/Working/Evolution/corvals/corvalues_WR_Eur_BJK.csv");

##Make barplots of correlation estimates for each
corind = grep("BJK_cor",colnames(corvals));
pind = grep("BJK_P",colnames(corvals));
seind = grep("BJK_SE",colnames(corvals));

dfplot=data.frame(t(corvals[1,corind]))
dfplot = dfplot %>% separate(X1, sep=" ",c("Correlation Coefficient"))
df<-data.frame(AncPCs=rownames(dfplot),CorCoef=dfplot[,1])
df$PCnum <- as.numeric(gsub('BJK_cor', '', df$AncPCs))
df$PCs <- as.character(gsub('BJK_cor', 'PC', df$AncPCs))
df$PCs <- factor(df$PCs, levels = df$PCs[order(df$PCnum)])

bonfsigind = which(corvals[1,pind] < 0.05/20)
df.bonf=data.frame(PCs=df$PCs[bonfsigind],CorCoef=0.045)
nomsigind = which(corvals[1,pind] >= 0.05/20 & corvals[1,pind] < 0.05)
df.nom=data.frame(PCs=df$PCs[nomsigind],CorCoef=0.045)

p1=ggplot(df,aes(x=PCs,y=as.numeric(CorCoef)))+geom_bar(stat="identity",fill="steelblue")+
  scale_y_continuous(limits=c(-0.05,0.05))+theme(legend.position = "none")+
  geom_linerange(aes(ymin=as.numeric(corvals[1,corind]-corvals[1,seind]),ymax=as.numeric(corvals[1,corind]+corvals[1,seind])))+
  ggtitle("EUR")+ylab("Correlation Coefficient")+xlab("Ancestry PCs")+
  geom_text(data=df.bonf,label="*")+geom_text(data=df.nom,label="o")+
  theme_classic()+theme(plot.title=element_text(hjust=0.5),axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

###
  
corvals = read.csv("P:/workspaces/lg-genlang/Working/Evolution/corvals/corvalues_WR_total_BJK.csv");
  
##Make barplots of correlation estimates for each
corind = grep("BJK_cor",colnames(corvals));
pind = grep("BJK_P",colnames(corvals));
seind = grep("BJK_SE",colnames(corvals));

dfplot=data.frame(t(corvals[1,corind]))
dfplot = dfplot %>% separate(X1, sep=" ",c("Correlation Coefficient"))
df<-data.frame(AncPCs=rownames(dfplot),CorCoef=dfplot[,1])
df$PCnum <- as.numeric(gsub('BJK_cor', '', df$AncPCs))
df$PCs <- as.character(gsub('BJK_cor', 'PC', df$AncPCs))
df$PCs <- factor(df$PCs, levels = df$PCs[order(df$PCnum)])

bonfsigind = which(corvals[1,pind] < 0.05/20)
df.bonf=data.frame(PCs=df$PCs[bonfsigind],CorCoef=0.045)
nomsigind = which(corvals[1,pind] >= 0.05/20 & corvals[1,pind] < 0.05)
df.nom=data.frame(PCs=df$PCs[nomsigind],CorCoef=0.045)

p2=ggplot(df,aes(x=PCs,y=as.numeric(CorCoef)))+geom_bar(stat="identity",fill="steelblue")+
  scale_y_continuous(limits=c(-0.05,0.05))+theme(legend.position = "none")+
  geom_linerange(aes(ymin=as.numeric(corvals[1,corind]-corvals[1,seind]),ymax=as.numeric(corvals[1,corind]+corvals[1,seind])))+
  ggtitle("Total")+ylab("Correlation Coefficient")+xlab("Ancestry PCs")+
  geom_text(data=df.bonf,label="*")+geom_text(data=df.nom,label="o")+
  theme_classic()+theme(plot.title=element_text(hjust=0.5),axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

###

corvals = read.csv("P:/workspaces/lg-genlang/Working/Evolution/corvals/corvalues_WR_ancreg_Eur_BJK.csv");
  
##Make barplots of correlation estimates for each
corind = grep("BJK_cor",colnames(corvals));
pind = grep("BJK_P",colnames(corvals));
seind = grep("BJK_SE",colnames(corvals));

dfplot=data.frame(t(corvals[1,corind]))
dfplot = dfplot %>% separate(X1, sep=" ",c("Correlation Coefficient"))
df<-data.frame(AncPCs=rownames(dfplot),CorCoef=dfplot[,1])
df$PCnum <- as.numeric(gsub('BJK_cor', '', df$AncPCs))
df$PCs <- as.character(gsub('BJK_cor', 'PC', df$AncPCs))
df$PCs <- factor(df$PCs, levels = df$PCs[order(df$PCnum)])

bonfsigind = which(corvals[1,pind] < 0.05/20)
df.bonf=data.frame(PCs=df$PCs[bonfsigind],CorCoef=0.045)
nomsigind = which(corvals[1,pind] >= 0.05/20 & corvals[1,pind] < 0.05)
df.nom=data.frame(PCs=df$PCs[nomsigind],CorCoef=0.045)

p3=ggplot(df,aes(x=PCs,y=as.numeric(CorCoef)))+geom_bar(stat="identity",fill="steelblue")+
  scale_y_continuous(limits=c(-0.05,0.05))+theme(legend.position = "none")+
  geom_linerange(aes(ymin=as.numeric(corvals[1,corind]-corvals[1,seind]),ymax=as.numeric(corvals[1,corind]+corvals[1,seind])))+
  ggtitle("EUR - Ancestry Regressed")+ylab("Correlation Coefficient")+xlab("Ancestry PCs")+
  theme_classic()+theme(plot.title=element_text(hjust=0.5),axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
  
###

corvals = read.csv("P:/workspaces/lg-genlang/Working/Evolution/corvals/corvalues_WR_ancreg_total_BJK.csv");
  
##Make barplots of correlation estimates for each
corind = grep("BJK_cor",colnames(corvals));
pind = grep("BJK_P",colnames(corvals));
seind = grep("BJK_SE",colnames(corvals));

dfplot=data.frame(t(corvals[1,corind]))
dfplot = dfplot %>% separate(X1, sep=" ",c("Correlation Coefficient"))
df<-data.frame(AncPCs=rownames(dfplot),CorCoef=dfplot[,1])
df$PCnum <- as.numeric(gsub('BJK_cor', '', df$AncPCs))
df$PCs <- as.character(gsub('BJK_cor', 'PC', df$AncPCs))
df$PCs <- factor(df$PCs, levels = df$PCs[order(df$PCnum)])

bonfsigind = which(corvals[1,pind] < 0.05/20)
df.bonf=data.frame(PCs=df$PCs[bonfsigind],CorCoef=0.045)
nomsigind = which(corvals[1,pind] >= 0.05/20 & corvals[1,pind] < 0.05)
df.nom=data.frame(PCs=df$PCs[nomsigind],CorCoef=0.045)

p4=ggplot(df,aes(x=PCs,y=as.numeric(CorCoef)))+geom_bar(stat="identity",fill="steelblue")+
  scale_y_continuous(limits=c(-0.05,0.05))+theme(legend.position = "none")+
  geom_linerange(aes(ymin=as.numeric(corvals[1,corind]-corvals[1,seind]),ymax=as.numeric(corvals[1,corind]+corvals[1,seind])))+
  ggtitle("Total - Ancestry Regressed")+ylab("Correlation Coefficient")+xlab("Ancestry PCs")+
  theme_classic()+theme(plot.title=element_text(hjust=0.5),axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

pdf("all_plots_ggplot.pdf")
plot_grid(p1,p2,p3,p4)
dev.off()
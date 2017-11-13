library(ggplot2)
library(grid)
annotation_table<-read.table("FP1_without_FP2.vcf.format.filter.txt", header=TRUE, quote="", row.names=NULL)
annotation_table<-annotation_table[grep("Chr",annotation_table$Chr),]
for(i in 1:length(rownames(annotation_table))){
 annotation_table$AF3_a[i]<-strsplit(as.vector(annotation_table$AF3),'=')[[i]][1]
 annotation_table$AF4_a[i]<-strsplit(as.vector(annotation_table$AF4),'=')[[i]][1]
 }
annotation_table$AF3_a<-as.numeric(annotation_table$AF3_a)
annotation_table$AF4_a<-as.numeric(annotation_table$AF4_a)
annotation_table$AF_s<-annotation_table$AF3_a - annotation_table$AF4_a
#lines<-data.frame(x1=c(-Inf,-Inf,-Inf,-Inf,-Inf),x2=c(-Inf,-Inf,-Inf,-Inf,-Inf),y1=c(-Inf,-Inf,-Inf,-Inf,-Inf),y2=c(Inf,Inf,Inf,Inf,Inf),Chr=c("Chr1","Chr2","Chr3","Chr4","Chr5"))
length<-data.frame(Pos=c(0,30,0,24,0,40,0,24,0,29,0,30,0,20),AF_s=rep(c(-100,100),7),Chr=rep(c("Chr1","Chr2","Chr3","Chr4","Chr5","Chr6","Chr7"),each=2),stringsAsFactors=FALSE)
length_down<-data.frame(Pos=c(0,30,0,24,0,40,0,24,0,29,0,30,0,20),AF3_a=rep(c(-100,100),7),Chr=rep(c("Chr1","Chr2","Chr3","Chr4","Chr5","Chr6","Chr7"),each=2),stringsAsFactors=FALSE)
length_up<-data.frame(Pos=c(0,30,0,24,0,40,0,24,0,29,0,30,0,20),AF4_a=rep(c(-100,100),7),Chr=rep(c("Chr1","Chr2","Chr3","Chr4","Chr5","Chr6","Chr7"),each=2),stringsAsFactors=FALSE)
g<-ggplot(annotation_table, aes(x=Pos/1000000, y=AF_s*100, group=Chr))+
	facet_grid(. ~ Chr, scales = "free_x", space = "free_x")+
	coord_fixed(ratio=1/3)+
	geom_point(size=.5)+
	theme_bw()+
	theme(#panel.grid = element_blank(),
#		panel.border = element_blank(),
		axis.line.x = element_line(colour="black"),
		axis.line.y = element_line(colour="black"))+
#	geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = lines)
	xlab("mutation position(megabases)")+
	ylab("Allele Frequency(%)")+
	geom_blank(data=length)+
	scale_x_continuous(breaks=seq(0,40,10))+
	ylim(-100,100)+
	geom_smooth()
print(g)
ggsave("FP1_without_FP2_delta.pdf",width=20,height=5)
down<-ggplot(annotation_table, aes(x=Pos/1000000, y=AF3_a*100, group=Chr))+
        facet_grid(. ~ Chr, scales = "free_x", space = "free_x")+
	    coord_fixed(ratio=1/3)+
	    geom_point(size=.5)+
	    theme_bw()+
		theme(#panel.grid = element_blank(),
#              panel.border = element_blank(),
			   axis.line.x = element_line(colour="black"),
			   axis.line.y = element_line(colour="black"))+
#       geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = lines)
		xlab("SNP position(megabases)")+
	    ylab("Concurrance(%)")+
		geom_blank(data=length_down)+
		scale_x_continuous(breaks=seq(0,40,10))+
		ylim(0,100)+
		geom_smooth()
print(down)
ggsave("FP1_without_FP2_down.pdf",width=20,height=5)
up<-ggplot(annotation_table, aes(x=Pos/1000000, y=AF4_a*100, group=Chr))+
		facet_grid(. ~ Chr, scales = "free_x", space = "free_x")+
		coord_fixed(ratio=1/3)+
		geom_point(size=.5)+
		theme(
			axis.line.x = element_line(colour="black"),
			axis.line.y = element_line(colour="black"))+
		xlab("SNP position(megabases)")+
		ylab("Concurrance(%)")+
		geom_blank(data=length_up)+
		scale_x_continuous(breaks=seq(0,40,10))+
		ylim(0,100)+
		geom_smooth()
print(up)
ggsave("FP1_without_FP2_up.pdf",width=20,height=5)

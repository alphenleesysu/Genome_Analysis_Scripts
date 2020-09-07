library("ggplot2")

# plot bgr.ks
bg.ks<-read.table("bg.kaks_cal.output.am.filter",header = F)
bg.ks<-bg.ks[,c(1,4)]
colnames(bg.ks)<-c("ID","ks")
p1<-ggplot(data=bg.ks,aes(x=ks))+geom_density()

# plot bse.ks
bse.ks<-read.table("bse.kaks_cal.output.am.filter",header = F)
bse.ks<-bse.ks[,c(1,4)]
colnames(bse.ks)<-c("ID","ks")
p2<-ggplot(data=bse.ks,aes(x=ks))+geom_density()

# plot rap.ks
rap.ks<-read.table("rap.kaks_cal.output.am.filter",header = F)
rap.ks<-rap.ks[,c(1,4)]
colnames(rap.ks)<-c("ID","ks")
p3<-ggplot(data=rap.ks,aes(x=ks))+geom_density()

# pull the three together
bg.ks$type<-rep("bg",dim(bg.ks)[1])
bse.ks$type<-rep("bse",length(bse.ks[,1]))
rap.ks$type<-rep("rap",dim(rap.ks)[1])
all.ks<-rbind(bg.ks,bse.ks,rap.ks)
p4<-ggplot(all.ks,aes(x=ks,fill=type,color=type))+geom_density(alpha=0.4,size=.9)

# adjust the figure and using ggsave() for saving 
p5<-p4+scale_x_continuous(breaks = seq(0,6,0.5),limits = c(0,6))+
  scale_y_continuous(breaks = seq(0,1,0.2))+
  coord_fixed(ratio=3.5)
ggsave("bg_bse_rap.ks.pdf",p5)
  



# ** Old Scripts to Refer **
# ctrl+shift+C:多行注释
  
# bg.ks<-read.table("bg.kaks_cal.output.am",header=T)
# p0<-ggplot(data=bg.ks,aes(x=Ks))+geom_density()
# p0
# 


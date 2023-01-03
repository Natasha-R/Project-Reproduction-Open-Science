ya=read.table("/Mizzou/cog_load_masculinity_and_yaoran/yaoran_study/merged data2.csv",head=T,sep=",",na.string="")

as.data.frame(tapply(rep(1,length(ya$Subj)),ya$Subj,length))
hist(as.data.frame(tapply(rep(1,length(ya$Subj)),ya$Subj,length))[,1])
table(as.data.frame(tapply(rep(1,length(ya$Subj)),ya$Subj,length))[,1])

wi=reshape(ya,idvar="Subj",timevar="Trial",direction="wide")
write.table(wi,"/Mizzou/cog_load_masculinity_and_yaoran/yaoran_study/merged data2_WIDE.csv",row=F,col=T,sep=",",na="",quote=F)

age=as.numeric(as.character(wi$Name.167))
age[age==1993]=2012-1993
mean(age,na.rm=T)
sd(age,na.rm=T)
#then run study 3
age2=as.numeric(as.character(wi$Name.167))
age2[is.na(age2)]=19
age=c(age,age2)
mean(age,na.rm=T)
sd(age,na.rm=T)
mean(age2)
sd(age2)

#subjects 18 and 58 should be deleted - didn't finish
# 1=neutral
# 2=intragroup
# 3=intergroup
# 4=women
# 5=parasite

#slides 1,3,5,7,9,10,12,14,16,18,20: 9 is masc; 2,4,6,8,11,13,15,17,19: 1 is masc
y2=ya[ya$Trial %in% c(4:23,51:70),]
y2=y2[y2$Resp>0,]
y2=y2[!y2$Subj==18,]
y2=y2[!y2$Subj==58,]
y2$mascright=rep(1,length(y2$Subj))
y2$mascright[y2$Trial %in% c(5,7,9,11,14,16,18,20,22,52,54,56,58,61,63,65,67,69)]=0
y2$masc=rep(0,length(y2$Subj))
y2$masc[y2$mascright==0 & y2$Resp==1]=1
y2$masc[y2$mascright==1 & y2$Resp==9]=1
y2$id=as.factor(y2$Subj)
y2$prime=rep(0,length(y2$id))
y2$prime[y2$Order>30]=1

library(sciplot)
par(mfrow=c(1,2))
lineplot.CI(Order,masc,dat=y2,xlab="Order",ylab="Facial Masculinity Preference")
abline(v=20.5,lwd=2)
lineplot.CI(Order,masc,Cond,dat=y2,col=c(1:5),xlab="Order",ylab="p(Masculine Face)")
abline(v=20.5,lwd=2)

olev=as.character(as.numeric(levels(as.factor(y2$Order))))
orank=c(1:length(olev))
orank=data.frame(olev,orank)
y2=merge(y2,orank,by.x="Order",by.y="olev",all=T)
y2$Cond=as.factor(y2$Cond)

lineplot.CI(orank,masc,dat=y2,xlab="Order",ylab="Facial Masculinity Preference")
abline(v=20.5,lwd=2)


library(lme4)
#summary(lmer(masc~orank+prime+(1|id),data=y2,family=binomial))
#summary(lmer(masc~orank*prime+(1|id),data=y2,family=binomial))
#summary(lmer(masc~orank+prime*Cond+(1|id),data=y2,family=binomial))
#summary(lmer(masc~orank*prime*Cond+(1|id),data=y2,family=binomial))

#added stim as random
summary(lmer(masc~orank+prime+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank*prime+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+prime*Cond+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+I(orank^2)+prime+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+(1|id)+(1|Stim),data=y2[y2$orank<20.5,],family=binomial))

#cross-nested
#summary(lmer(masc~orank+prime+(1|id:Stim),data=y2,family=binomial))
#summary(lmer(masc~orank*prime+(1|id:Stim),data=y2,family=binomial))
#summary(lmer(masc~orank+prime*Cond+(1|id:Stim),data=y2,family=binomial))

summary(lmer(masc~orank+prime+(1|id)+(1|Stim),data=y2[y2$orank<24 & y2$orank>16,],family=binomial))
summary(lmer(masc~orank*prime+(1|id)+(1|Stim),data=y2[y2$orank<24 & y2$orank>16,],family=binomial))
summary(lmer(masc~orank+prime*Cond+(1|id)+(1|Stim),data=y2[y2$orank<24 & y2$orank>16,],family=binomial))


summary(lmer(masc~orank+prime+(1|id)+(1|Stim),data=y2[y2$Cond=="1",],family=binomial))
summary(lmer(masc~orank+prime+(1|id)+(1|Stim),data=y2[y2$Cond=="2",],family=binomial))
summary(lmer(masc~orank+prime+(1|id)+(1|Stim),data=y2[y2$Cond=="3",],family=binomial))
summary(lmer(masc~orank+prime+(1|id)+(1|Stim),data=y2[y2$Cond=="4",],family=binomial))
summary(lmer(masc~orank+prime+(1|id)+(1|Stim),data=y2[y2$Cond=="5",],family=binomial))

summary(lmer(masc~orank*prime+(1|id)+(1|Stim),data=y2[y2$Cond=="1",],family=binomial))
summary(lmer(masc~orank*prime+(1|id)+(1|Stim),data=y2[y2$Cond=="2",],family=binomial))
summary(lmer(masc~orank*prime+(1|id)+(1|Stim),data=y2[y2$Cond=="3",],family=binomial))
summary(lmer(masc~orank*prime+(1|id)+(1|Stim),data=y2[y2$Cond=="4",],family=binomial))
summary(lmer(masc~orank*prime+(1|id)+(1|Stim),data=y2[y2$Cond=="5",],family=binomial))

summary(lmer(masc~orank+prime*Cond+(1|id)+(1|Stim),data=y2[y2$Cond=="2" | y2$Cond=="1",],family=binomial))
summary(lmer(masc~orank+prime*Cond+(1|id)+(1|Stim),data=y2[y2$Cond=="3" | y2$Cond=="1",],family=binomial))
summary(lmer(masc~orank+prime*Cond+(1|id)+(1|Stim),data=y2[y2$Cond=="4" | y2$Cond=="1",],family=binomial))
summary(lmer(masc~orank+prime*Cond+(1|id)+(1|Stim),data=y2[y2$Cond=="5" | y2$Cond=="1",],family=binomial))
summary(lmer(masc~orank+prime*Cond+(1|id)+(1|Stim),data=y2[y2$Cond=="2" | y2$Cond=="3",],family=binomial))

#IS CONDITION*PRIME INDEPENDENT OF COND*ORDER?
summary(lmer(masc~orank+prime*Cond+(1|id)+(1|Stim),data=y2[y2$Cond=="4" | y2$Cond=="1",],family=binomial))
summary(lmer(masc~orank*Cond+prime*Cond+(1|id)+(1|Stim),data=y2[y2$Cond=="4" | y2$Cond=="1",],family=binomial))


submean=data.frame(tapply(y2$masc,data.frame(y2$Subj,y2$prime),mean))
subcond=data.frame(tapply(as.numeric(as.character(y2$Cond)),y2$Subj,mean))
submean=merge(submean,subcond,by.x="row.names",by.y="row.names")
names(submean)=c("id","pre","post","cond")
t.test(submean$pre,submean$post,paired=T)
t.test(submean$pre[submean$cond==1],submean$post[submean$cond==1],paired=T)
t.test(submean$pre[submean$cond==2],submean$post[submean$cond==2],paired=T)
t.test(submean$pre[submean$cond==3],submean$post[submean$cond==3],paired=T)
t.test(submean$pre[submean$cond==4],submean$post[submean$cond==4],paired=T)
t.test(submean$pre[submean$cond==5],submean$post[submean$cond==5],paired=T)

table(y2$Resp[y2$Trial==4])
table(y2$Resp[y2$Trial==5])
table(y2$Resp[y2$Trial==6])
table(y2$Resp[y2$Trial==7])
table(y2$Resp[y2$Trial==8])

time=rep(0:1,each=length(submean$cond))
meanmasc=c(submean$pre,submean$post)
condl=as.factor(c(submean$cond,submean$cond))
idl=as.factor(c(submean$id,submean$id))

lineplot.CI(time,meanmasc,condl,xlab="Time",ylab="Mean Facial Masculinity Preference",fixed=T,leg.lab=c("Control","Male-on-Male",'Male Intergroup','Male-on-Female','Pathogen'),x.leg=1.6,y.leg=.47,ylim=c(.42,.66),lwd=3,col=c("red","blue","green","orange","purple"))

summary(lme(meanmasc~time*condl,random=~1|idl,na.action='na.omit',method="ML"))
anova(lme(meanmasc~time*condl,random=~1|idl,na.action='na.omit'),type="marginal",adjustSigma=F)

#reference group is 1
condl2=as.numeric(condl)
condl2[condl2==1]=6
condl2=as.factor(condl2)
summary(lme(meanmasc~time*condl2,random=~1|idl,na.action='na.omit'))

y2face=data.frame(y2$Subj,y2$orank,y2$prime,y2$masc,y2$Stim,y2$Cond)
names(y2face)=c("id","order","prime","masc","stim","cond")
write.csv(y2face,file="/Mizzou/cog_load_masculinity_and_yaoran/yaoran_study/s2face.csv")

#voice:
y3=ya[ya$Trial %in% c(119,122,125,128,131,134),]
y3=y3[!y3$Subj==18,]
y3=y3[!y3$Subj==58,]
y3$masc=y3$Resp
y3$masc[y3$Trial %in% c(119,125,131,134)]=10-y3$masc[y3$Trial %in% c(119,125,131,134)]
y3$id=as.factor(y3$Subj)
y3$Cond=as.factor(y3$Cond)
y3$Order=y3$Order-min(y3$Order)

par(mfrow=c(1,2))
lineplot.CI(Order,masc,dat=y3,xlab="Order",ylab="Masculine Voice Preference")
lineplot.CI(Order/3+1,masc,Cond,dat=y3,xlab="Order",ylab="Vocal Masculinity Preference",fixed=T,leg.lab=c("Control","Male-on-Male",'Male Intergroup','Male-on-Female','Pathogen'),x.leg=4,y.leg=5,lwd=3,col=c("red","blue","green","orange","purple"))


summary(lme(masc~Order,random=~1|Subj,data=y3,method="ML"))
summary(lme(masc~Order*Cond,random=~1|Subj,data=y3,method="ML"))

y3$orank=y3$Order/3+1
y2voice=data.frame(y3$Subj,y3$orank,y3$masc,y3$Stim,y3$Cond)
names(y2voice)=c("id","order","masc","stim","cond")
write.csv(y2voice,file="/Mizzou/cog_load_masculinity_and_yaoran/yaoran_study/s2voice.csv")



# fear=3
# disgust=4
# anger=5
# sexual arousal=6
# romantic arousal=7
# happiness=10

emotions=data.frame(wi$Subj,wi$Resp.137,wi$Resp.138,wi$Resp.139,wi$Resp.140,wi$Resp.141,wi$Resp.144)
names(emotions)=c("id","fear","disgust","anger","sex","romance","happy")

y2=merge(y2,emotions,by.x="Subj",by.y="id",all=T)
summary(lmer(masc~orank+prime*fear+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+prime*disgust+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+prime*anger+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+prime*sex+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+prime*romance+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+prime*happy+(1|id)+(1|Stim),data=y2,family=binomial))

summary(lmer(masc~orank+disgust+(1|id)+(1|Stim),data=y2[y2$Cond==5 & y2$orank>20,],family=binomial))


summary(lmer(masc~orank+prime*Cond+disgust*prime+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+prime*Cond+anger*prime+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+prime*Cond+sex*prime+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+prime*Cond+disgust*prime+anger*prime+sex*prime+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+prime*Cond+disgust*prime+anger*prime+(1|id)+(1|Stim),data=y2,family=binomial))
summary(lmer(masc~orank+prime*Cond+(1|id)+(1|Stim),data=y2,family=binomial))

summary(lmer(masc~orank+prime*Cond+log(disgust)*prime+log(anger)*prime+(1|id)+(1|Stim),data=y2,family=binomial))


#pref
pref=as.data.frame(tapply(y2$masc[y2$Cond==1],y2$orank[y2$Cond==1],mean,na.rm=T))
names(pref)=c('pref')

bargraph.CI(Cond,disgust,data=y2)
bargraph.CI(Cond,sex,data=y2)
bargraph.CI(Cond,anger,data=y2)
bargraph.CI(Cond,happy,data=y2)
bargraph.CI(Cond,fear,data=y2)


y3=merge(y3,emotions,by.x="Subj",by.y="id",all=T)
summary(lme(masc~fear,random=~1|Subj,data=y3,method="ML",na.action="na.omit"))
summary(lme(masc~disgust,random=~1|Subj,data=y3,method="ML",na.action="na.omit"))
summary(lme(masc~anger,random=~1|Subj,data=y3,method="ML",na.action="na.omit"))
summary(lme(masc~sex,random=~1|Subj,data=y3,method="ML",na.action="na.omit"))
summary(lme(masc~romance,random=~1|Subj,data=y3,method="ML",na.action="na.omit"))
summary(lme(masc~happy,random=~1|Subj,data=y3,method="ML",na.action="na.omit"))

summary(lme(masc~Order*Cond,random=~1|Subj,data=y3,method="ML",na.action="na.omit"))
summary(lme(masc~Order*Cond+fear,random=~1|Subj,data=y3,method="ML",na.action="na.omit"))
summary(lme(masc~Order*Cond+disgust,random=~1|Subj,data=y3,method="ML",na.action="na.omit"))
summary(lme(masc~Order*Cond+anger,random=~1|Subj,data=y3,method="ML",na.action="na.omit"))
summary(lme(masc~Order*Cond+happy,random=~1|Subj,data=y3,method="ML",na.action="na.omit"))

summary(lme(masc~Order*Cond+fear+disgust+happy,random=~1|Subj,data=y3,method="ML",na.action="na.omit"))

emotions2=data.frame(wi$Subj,wi$Resp.137,wi$Resp.138,wi$Resp.139,wi$Resp.140,wi$Resp.141,wi$Resp.144)
names(emotions2)=c("id","fear","disgust","anger","sex","romance","happy")
emotions2=merge(emotions2,submean,by.x="id",by.y="id",all=T)
t.test(emotions2$fear[emotions2$cond==1 & !is.na(emotions2$cond)],emotions2$fear[emotions2$cond==4 & !is.na(emotions2$cond)],var.equal=T)

t.test(emotions2$anger[emotions2$cond==1 & !is.na(emotions2$cond)],emotions2$anger[emotions2$cond==4 & !is.na(emotions2$cond)],var.equal=T)

t.test(emotions2$disgust[emotions2$cond==1 & !is.na(emotions2$cond)],emotions2$disgust[emotions2$cond==4 & !is.na(emotions2$cond)],var.equal=T)

t.test(emotions2$sex[emotions2$cond==1 & !is.na(emotions2$cond)],emotions2$sex[emotions2$cond==4 & !is.na(emotions2$cond)],var.equal=T)
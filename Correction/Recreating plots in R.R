library(sciplot)

# face data confidence interval plot
face_fixed=read.table("data/main_study_face_data_fixed.csv",head=T,sep=",")
face_fixed$cond = as.factor(face_fixed$cond)

fig1 <- lineplot.CI(x.factor=prime, response=masc, group=cond, data=face_fixed,
                    xlab="Time", ylab="Mean Facial Masculinity Preference",
                    fixed=T, x.leg=1.6, y.leg=0.53, ylim=c(0.48,0.68), lwd=3, 
                    col=c("red","blue","green","orange","purple"),
                    leg.lab=c("Control","Male-on-Male",'Male Intergroup',
                              'Male-on-Female','Pathogen'))

# voice data confidence interval plot
voice_fixed=read.table("data/main_study_voice_data_fixed.csv",head=T,sep=",")
voice_fixed$cond = as.factor(voice_fixed$cond)

fig2 <- lineplot.CI(x.factor=order, response=masc, group=cond, data=voice_fixed, 
                    xlab="Order", ylab="Mean Vocal Masculinity Preference",
                    fixed=T, x.leg=4, y.leg=4.6, lwd=3, 
                    col=c("red","blue","green","orange","purple"),
                    leg.lab=c("Control","Male-on-Male",'Male Intergroup',
                              'Male-on-Female','Pathogen'))

library(sciplot)

# face data confidence interval plot
face_fixed=read.table("main_study_face_data_fixed.csv",head=T,sep=",")
face_fixed$prime_condition = as.factor(face_fixed$prime_condition)

plot <- lineplot.CI(x.factor=pre_post_prime, response=chose_masc, 
                    group=prime_condition, data=face_fixed,
                    xlab="Time", ylab="Mean Facial Masculinity Preference",
                    fixed=T, x.leg=1.6, y.leg=0.53, ylim=c(0.48,0.68), lwd=3, 
                    col=c("red","blue","green","orange","purple"),
                    leg.lab=c("Control","Male-on-Male",'Male Intergroup',
                              'Male-on-Female','Pathogen'))

# voice data confidence interval plot
voice_fixed=read.table("main_study_voice_data_fixed.csv",head=T,sep=",")
voice_fixed$prime_condition = as.factor(voice_fixed$prime_condition)

plot <- lineplot.CI(x.factor=trial_number, response=masc_rating, 
                    group=prime_condition, data=voice_fixed, 
                    xlab="Order", ylab="Mean Vocal Masculinity Preference",
                    fixed=T, x.leg=4, y.leg=4.6, lwd=3, 
                    col=c("red","blue","green","orange","purple"),
                    leg.lab=c("Control","Male-on-Male",'Male Intergroup',
                              'Male-on-Female','Pathogen'))

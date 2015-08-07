#install.packages("RCurl")
library(RCurl)
#install.packages("rvest")
library(rvest)
#install.packages("selectr")
library(selectr)
library(XML)
library(stringr)

mmwr_contents <- htmlParse("http://www.cdc.gov/mmwr/preview/mmwrhtml/mm6430a1.htm?s_cid=mm6430a1_e")
p1<-readHTMLTable(mmwr_contents, header=TRUE, which=1)
p2<-readHTMLTable(mmwr_contents, header=TRUE, which=2)
p1<-p1[-(1:9),]
p2<-p2[-(1:3),]
p2<-p2[-25,]
school<-rbind(p1,p2)

names(school)[c(1,6)]<-c("state","start_time")
school<-school[,c("state","start_time")]
school$start_time<-ifelse(str_detect(as.character(school$start_time), "\\*"), "", as.character(school$start_time))
write.csv(x = school, "c:/proj/misc/school.csv",row.names=FALSE)

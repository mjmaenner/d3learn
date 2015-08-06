#install.packages("RCurl")
library(RCurl)
#install.packages("rvest")
library(rvest)
#install.packages("selectr")
library(selectr)
library(XML)
#install.packages("maps")
library(maps)

mmwr_contents <- htmlParse("http://www.cdc.gov/mmwr/preview/mmwrhtml/mm6430a1.htm?s_cid=mm6430a1_e")
p1<-readHTMLTable(mmwr_contents, header=TRUE, which=1)
p2<-readHTMLTable(mmwr_contents, header=TRUE, which=2)
p1<-p1[-(1:9),]
p2<-p2[-(1:3),]
p2<-p2[-25,]
school<-rbind(p1,p2)

school$state<-tolower(school$V1)

library(stringr)
statenames<-function(states){
  sub_state<-character(length(states))
  end_pos <- str_locate(states, pattern=":")
  for (i in 1:length(states)){
      end_pos[i]<-ifelse(is.na(end_pos[i]), nchar(states[i]), end_pos[i]-1)
      sub_state[i]<-str_sub(states[i], start=1, end=end_pos[i])
  }
    return(sub_state)
}

state.fips$statename<-statenames(as.character(state.fips$polyname))
state.fips.u<-state.fips[,-which(names(state.fips) %in% c("polyname"))]
state.fips.u<-state.fips.u[!duplicated(state.fips),]

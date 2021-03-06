library(dplyr)
ind.eu<-read.csv("retail-electricity-price-indutrial-EU.csv") #nrg_pc_205, 해당 키워드 구글링 해보셈 
household.eu<-read.csv("retail-electricity-price-household-EU.csv")#nrg_pc_204 ,해당 키워드 구글링 해보셈 
period<-levels(ind.eu$TIME)
ind.eu$GEO<-as.character(ind.eu$GEO)
household.eu$GEO<-as.character(household.eu$GEO)
ind.eu$Value<-as.numeric(as.character(ind.eu$Value))
household.eu$Value<-as.numeric(as.character(household.eu$Value))

when<-"2015S2"#언제 데이터를 볼것인가? 분기별 데이터 조회 가능, 2014S2


ind.eu<-ind.eu[!is.na(ind.eu$Value),] #자료값이 나와있지 않는 자료는 제외한다. 
household.eu<-household.eu[!is.na(household.eu$Value),]

for(i in 1:length(period)){
  x<-subset(ind.eu,ind.eu$TIME==period[i])
  y<-subset(household.eu,household.eu$TIME==period[i])
  assign(paste("ind.eu",period[i], sep="."),x)
  assign(paste("household.eu",period[i], sep="."),y)
}

ind.final.price<-filter(ind.eu.2015S2, TAX=="All taxes and levies included"& CURRENCY=="Euro")
household.final.price<-filter(household.eu.2015S2, TAX=="All taxes and levies included"& CURRENCY=="Euro")

View(ind.final.price)
View(household.final.price)

short.ind<-grep("Euro area|Germany|Kosovo|Macedonia",ind.final.price$GEO)
short.household<-grep("Euro area|Germany|Kosovo|Macedonia",ind.final.price$GEO)
ind.final.price$GEO[short.ind]<-c("Euro Area","Germany","Kosovo","Macedonia")
household.final.price$GEO[short.household]<-c("Euro Area","Germany","Kosovo","Macedonia")

eu.ind.grpah<-ggplot(ind.final.price,aes(x=GEO,y=Value,fill=Value))+
  geom_bar(stat="identity")+
  theme_bw(base_family = "AppleGothic")+
  ylab("가장용 전력요금 평균판매단가(Euro/Kwh")+
  xlab(paste("EU 국가별 가정요금(Euro/Kwh)"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

eu.household.graph<-ggplot(household.final.price,aes(x=GEO,y=Value,fill=Value))+
  geom_bar(stat="identity")+
  theme_bw(base_family = "AppleGothic")+
  ylab("가장용 전력요금 평균판매단가(Euro/Kwh")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
  xlab(paste("EU 국가별 가정요금(Euro/Kwh"))

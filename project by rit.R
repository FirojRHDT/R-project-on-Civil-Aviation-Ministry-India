library(ggfortify)
library(ggplot2)
library(dplyr)
library(gganimate)
library(plotly)
library(hrbrthemes)
library(scales)


#reading csv files
#dataset1
airfin<-read_csv("budget.csv")
#Dataser2
airportdata<-read_csv("airports.csv")
#dataset3
ap<-read_csv("india.csv")
#dataset4
airpass<-read_csv("india.csv")
#extracting variable values
#dataset1
finyear<-airfin$Ecoyear
budget<-airfin$Budget
#dataset2
States<-airportdata$SUT
Airports<-airportdata$No_of_Airports
Domestic<-airportdata$Domestic
International<-airportdata$International
Defence<-airportdata$Defence
Construction<-airportdata$Proposed
Others<-airportdata$Others
Private<-airportdata$Private
#dataset3
passenger<-ap$Passengers
year<-ap$Year

#plotting garph for civil aviation department(dataset1)
finyear<-as.integer(finyear)
budget<-budget/1000
frame1<-data.frame(finyear,budget)

#animating financial data
gg<-ggplot(frame1, aes(x=finyear, y=budget)) +
  geom_line(aes(color='blue')) +
  geom_point() +
  scale_color_viridis_d() +
  ggtitle("India budget for Civil Aviation")+
  geom_area(fill="#69b3a2", alpha=1)+
  ylab("Budget in 100 Crores Rs.")+
  transition_reveal(finyear)

animate(gg, renderer = gifski_renderer())

#area chart of finacial data
plot3<-ggplot(frame1,aes(x=finyear, y=budget))+
  geom_area(fill="#69b3a2", alpha=1)+
  geom_line(color="#69b3a2")+
  xlab("Financial Year")+
  ylab("Civil Aviation Budget in thousand Crores")+
  theme_ipsum()+
  labs(title="Civil Aviation Budget")+
  scale_y_continuous(name = "Civil Aviation Budget in thousand Crores", labels=comma)
ggplotly(plot3)

#plotting graph of airports in india(datset2)
datamatrix<-rbind(Domestic,International,Defence,Construction,Others,Private)
categories<-c("Domestic","International","Defence","Construction","Others","Private")

colors<-c("#1c2841","#00416a","#006994","#0067a5","#0087bd","#1dacd6")
#plotting staked bargraph
par(mar=(c(7,5,2,2)))
barplot(datamatrix,
        main = "Airports in India",
        ylab = "No. of airports with categories",
        ylim = c(0,50),
        col = colors,
        las=2,
        names.arg= States,
        cex.names = 0.7)+
  legend("topright",categories,
         cex=0.8,col=colors, pch = c(16,16,16,16,16,16))

#plotting graph airpassenger
#plotting line graph
p<- airpass %>%
  ggplot(aes(y=passenger, x=year))+
  geom_area(fill="#69b3a2", alpha=0.5)+
  geom_line(color="#69b3a2")+
  ylab("Number  of passengers")+
  theme_ipsum()+
  labs(title="Number of Passengers vs Year")+
  scale_y_continuous(name = "Number of Passengers", labels=comma)

ggplotly(p)

#plotting area chart
q<-airpass %>%
  ggplot( aes(x=year, y=passenger)) +
  geom_line(color="#69b3a2") +
  ylim(0,18000000)+
  annotate(geom="text", x=as.Date("2019"),y=167499116,
           label="Airpasseger hype at year 2019")
annotate(geom="point", x=as_Date("2019") ,size=10, shape=21, fill="transparent") +
  geom_hline(yintercept=5000000, color="orange", size=.5) +
  theme_ipsum()


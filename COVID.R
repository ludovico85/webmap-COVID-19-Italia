#setwd("working directory")
library(RCurl)
library(ggplot2)
library(tidyr)
library(plotly)
library(reshape2)
library(rjson)
source("custom_theme.R") ##funzione per customizzare l'output di ggplot2 ##


########################################################################################
### lettura dei dati andamento nazionale direttamente dal repo github e formattazione###
########################################################################################

url<-getURL("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-andamento-nazionale/dpc-covid19-ita-andamento-nazionale.csv")
andamento_nazionale<-read.csv(text = url, head = T)
andamento_nazionale<-separate(data = andamento_nazionale, col = data, into = c("data", "ora"), sep = "\\ ")
andamento_nazionale$data<-as.Date(andamento_nazionale$data)

#####################################################################
### chart 1 grafico sui casi totali e i casi attualemtne positivi####
################# N.B. aggiornare la data############################
#####################################################################

### lettura e formattazione dei dati ###
data_chart1<-andamento_nazionale[, c("data", "totale_casi", "totale_attualmente_positivi")]
colnames(data_chart1)<-c("data", "totali", "attualmente positivi")
data_chart1<-melt(data_chart1, id.vars = "data", measure.vars = c("totali", "attualmente positivi"))

### creazione del grafico utilizzando ggplot2 ###
chart1<-ggplot(data=data_chart1, aes(x=data, y=value, color=variable)) +
  ggtitle("Casi totali e attualmente positivi")+
  geom_line()+
  geom_point(shape = 21, size = 3, stroke = 0.5)+
  labs(x = "data", y = "numero di casi")+scale_x_date(date_breaks = "6 day",
                                                            date_labels = "%b %d",
                                                            limits = as.Date(c('2020-02-24','2020-03-22')))+
  scale_color_manual(labels = c("totale", "attualmente positivi"), values=c("#F81608", "#FD6407"))+
  theme_map()

### opzioni per la conversione del grafico di ggplot2 in plotly## 
l <- list(
    font = list(
    family = "sans-serif",
    size = 12,
    color = "white"),
    bgcolor = NA,
    bordercolor = NA,
    borderwidth = 0,
    orientation = "h",
    x = 0.25,
    y = -0.25)

### salvataggio del grafico in html utilizzando la libreria plotly###
chart1<-ggplotly(chart1) %>%
  layout(legend = l)

htmlwidgets::saveWidget(chart1, "chart1.html",  background = "rgba(0,0,0,0.0)")


###########################################################
#### chart 2 grafico sul numero di guariti e di decessi ###
################# N.B. aggiornare la data##################
###########################################################

data_chart2<-andamento_nazionale[, c("data", "dimessi_guariti", "deceduti")]
colnames(data_chart2)<-c("data", "guariti", "deceduti")
data_chart2<-melt(data_chart2, id.vars = "data", measure.vars = c("guariti", "deceduti"))

chart2<-ggplot(data=data_chart2, aes(x=data, y=value, color=variable)) +
  ggtitle("Guariti VS deceduti")+
  geom_line()+
  geom_point(shape = 21, size = 3, stroke = 0.5)+
  labs(x = "data", y = "numero di casi")+scale_x_date(date_breaks = "6 day",
                                                      date_labels = "%b %d",
                                                      limits = as.Date(c('2020-02-24','2020-03-22')))+
  scale_color_manual(labels = c("guariti", "deceduti"), values=c("#94D402", "#5F46E4"))+
  theme_map()


chart2<-ggplotly(chart2) %>%
  layout(legend = l)

htmlwidgets::saveWidget(chart2, "chart2.html",  background = "rgba(0,0,0,0.0)")

###########################################################
#### chart 3 grafico sul numero di attualemnte positivi ###
################# N.B. aggiornare la data##################
###########################################################

data_chart3<-andamento_nazionale[, c("data", "nuovi_attualmente_positivi")]
colnames(data_chart3)<-c("data", "nuovi_casi")

chart3<-ggplot(data=data_chart3, aes(x=data, y=nuovi_casi, group=1)) +
  ggtitle("Nuovi casi")+
  geom_line(aes(color="nuovi casi"))+
  geom_point(shape = 21, size = 3, stroke = 0.5, aes(color="nuovi casi"))+
  labs(x = "data", y = "numero di nuovi casi")+scale_x_date(date_breaks = "6 day",
                                                      date_labels = "%b %d",
                                                      limits = as.Date(c('2020-02-24','2020-03-22')))+
  scale_color_manual(name = NA, breaks = "nuovi casi", values = "#DEFA05")+theme_map()%+replace%
  theme(plot.margin = margin(0, -1, 0, -2, "cm"))


chart3<-ggplotly(chart3) %>%
  layout(legend = l)

htmlwidgets::saveWidget(chart3, "chart3.html",  background = "rgba(0,0,0,0.0)")


##############################################################################
### lettura dei dati regionali direttamente dal repo github e formattazione###
##############################################################################

url2<-getURL("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-regioni/dpc-covid19-ita-regioni.csv")
regioni<-read.csv(text = url2, head = T)
regioni<-separate(data = regioni, col = data, into = c("data", "ora"), sep = "\\ ")
regioni$data<-as.Date(regioni$data)

#############################################################
### chart 4 grafico sul numero di casi totali per regione ###
################# N.B. aggiornare la data####################
#############################################################

data_chart4<-regioni

### creazione palette con colori casuali per le regioni ###
library(randomcoloR)
n <- 21
palette<-distinctColorPalette(n)


chart4<-ggplot(data=data_chart4, aes(x=data, y=(totale_casi), color=denominazione_regione)) +
  ggtitle("Casi totali per regione")+
  geom_line()+
  geom_point(shape = 21, size = 3, stroke = 0.5)+
  labs(x = "data", y = "numero di casi")+scale_x_date(date_breaks = "6 day",
                                                      date_labels = "%b %d",
                                                      limits = as.Date(c('2020-02-24','2020-03-22')))+
  scale_color_manual(values=palette)+
  theme_map()

l <- list(
  font = list(
  family = "sans-serif",
  size = 12,
  color = "white"),
  bgcolor = NA,
  bordercolor = NA,
  borderwidth = 0,
  orientation = "h",
  x = 0,
  y = -0.2)

chart4<-ggplotly(chart4) %>%
  layout(legend = l)

htmlwidgets::saveWidget(chart4, "chart4.html",  background = "rgba(0,0,0,0.0)")

#############################################################
#### chart 5 grafico sul numero di tamponi e casi totali  ###
################# N.B. aggiornare la data####################
#############################################################

data_chart5<-andamento_nazionale[, c("data", "totale_casi", "tamponi")]
colnames(data_chart5)<-c("data", "casi totali", "tamponi")
data_chart5<-melt(data_chart5, id.vars = "data", measure.vars = c("casi totali", "tamponi"))


chart5<-ggplot(data=data_chart5, aes(x=data, y=value,fill=variable)) +
  ggtitle("Tamponi giornalieri (cumulati)")+
  geom_bar(stat="identity", position=position_dodge())+
  labs(x = "data", y = " ")+scale_x_date(date_breaks = "6 day",
                                                            date_labels = "%b %d",
                                                            limits = as.Date(c('2020-02-24','2020-03-22')))+
    #scale_color_manual(labels = c("casi totali", "tamponi effettuati"))+
    theme_map()

  l <- list(
    font = list(
      family = "sans-serif",
      size = 12,
      color = "white"),
    bgcolor = NA,
    bordercolor = NA,
    borderwidth = 0,
    orientation = "h",
    x = 0.25,
    y = -0.2)

chart5<-ggplotly(chart5) %>%
  layout(legend = l)

htmlwidgets::saveWidget(chart5, "chart5.html",  background = "rgba(0,0,0,0.0)")



###########################################################################################
### creazione dati di base per le mappe regionali e provinciali da utilizzare in leaflet###
##################### N.B. aggiornare la data##############################################
###########################################################################################
library(rgdal)
library(sp)

###################### dati provinciali ###################################################################################
url3<-getURL("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-province/dpc-covid19-ita-province-latest.csv")
province<-read.csv(text = url3, head = T)
province<-separate(data = province, col = data, into = c("data", "ora"), sep = "\\ ")
province$data<-as.Date(province$data)
province$sigla_provincia<-as.character(province$sigla_provincia)### NA viene riconosciuto con null
province[20,8]<-'NA'


### lettura e formattazione dati. N.B. Cambiare la data per aggiornare le mappe###
regioni_dati<-regioni
regioni_dati<-split(regioni_dati, regioni_dati$data)
regioni_dati<-regioni_dati$`2020-03-22`
colnames(regioni_dati)[5]<-"DEN_REG"

province_dati<-province
colnames(province_dati)[8]<-"SIGLA"

### selezione dei datatset di interesse ###
casi_totali<-regioni_dati[, c(5, 16)]
deceduti<-regioni_dati[, c(5, 15)]
guariti<-regioni_dati[, c(5, 14)]
attualmente_positivi<-regioni_dati[, c(5, 12)]

casi_totali_prov<-province_dati[, c(7, 8, 11)]
casi_totali_prov<-subset(casi_totali_prov, denominazione_provincia!='In fase di definizione/aggiornamento')

### caricamento del file vettoriale delle regioni ###
regioni_geo<-readOGR("dati_territoriali.gpkg", "regioni_popolazione")
### caricamento del file vettoriale delle province ###
province_geo<-readOGR("dati_territoriali.gpkg", "province_popolazione")

### join tra il dato vettoriale e gli attributi ###
regioni_geo_casi_totali<-sp::merge(regioni_geo, casi_totali, by='DEN_REG')
regioni_geo_deceduti<-sp::merge(regioni_geo, c(deceduti, casi_totali), by='DEN_REG')
regioni_geo_guariti<-sp::merge(regioni_geo, guariti, by='DEN_REG')
regioni_geo_positivi<-sp::merge(regioni_geo, attualmente_positivi, by='DEN_REG')

province_geo_casi_totali<-sp::merge(province_geo, casi_totali_prov, by='SIGLA')

### nuovi dati su incidenza dei contagi su popolazione totale residente e tasso di mortalità per regionale ###
regioni_geo_casi_totali@data$incidenza_pop_tot<-round((regioni_geo_casi_totali@data$totale_casi/regioni_geo_casi_totali@data$popolazione_ISTAT_2019_POP_TOT*10000), 2)
regioni_geo_deceduti@data$tasso_mortalita<-round((regioni_geo_deceduti@data$deceduti*100/regioni_geo_deceduti@data$totale_casi), 2)

province_geo_casi_totali@data$incidenza_pop_tot<-round((province_geo_casi_totali@data$totale_casi/province_geo_casi_totali@data$POP_TOT_ISTAT*10000), 2)

### formattazione per leaflet ###
regioni_geo_casi_totali@data$totale_casi<-as.character(regioni_geo_casi_totali@data$totale_casi)
regioni_geo_deceduti@data$deceduti<-as.character(regioni_geo_deceduti@data$deceduti)
regioni_geo_guariti@data$dimessi_guariti<-as.character(regioni_geo_guariti@data$dimessi_guariti)
regioni_geo_positivi@data$totale_attualmente_positivi<-as.character(regioni_geo_positivi@data$totale_attualmente_positivi)

province_geo_casi_totali@data$totale_casi<-as.character(province_geo_casi_totali@data$totale_casi)

### export in formato geojson js per caricamento in leaflet ###
writeOGR(regioni_geo_casi_totali, "webmap/dati/casi_totali.js", layer="regioni_geo_casi_totali", driver="GeoJSON", overwrite_layer = T)
writeOGR(regioni_geo_deceduti, "webmap/dati/deceduti.js", layer="regioni_geo_deceduti", driver="GeoJSON", overwrite_layer = T)
writeOGR(regioni_geo_guariti, "webmap/dati/guariti.js", layer="regioni_geo_guariti", driver="GeoJSON", overwrite_layer = T)
writeOGR(regioni_geo_positivi, "webmap/dati/positivi.js", layer="regioni_geo_positivi", driver="GeoJSON", overwrite_layer = T)

writeOGR(province_geo_casi_totali, "webmap/dati/casi_totali_prov.js", layer="province_geo_casi_totali", driver="GeoJSON", overwrite_layer = T)








#TAREA 2 

#CALL USEFULL PACKAGES 
library(dplyr)
library(tidyr)
library(readxl)

#SET DIRECTORY AND OPEN FILE

user <- Sys.getenv("USERNAME")
setwd( paste0("C:/Users/",user,"/Documents/GitHub/1ECO35_2022_2/Trabajo_grupal/WG2") ) 

junin_data<-read_excel("../../data/Region_Junin.xlsx")

#1. Obtener nombres de las variables o columnas
var_names<-(variable.names(junin_data))
var_names

#2. Tipo de variables y estadisticas principales
sapply(junin_data, class)  #TYPE

stat<-(summary(junin_data)) #STATS OF MY VARIABLES
stat

#3. Verificar si hay valores missing en la datadrame 
any(is.na.data.frame(junin_data)) #TRUE= There are mising values
apply(is.na(junin_data), 2, which) #Return the positions with missing values in each variable.

#4. Cambiar el nombre de las variables
junin_data <- junin_data %>% rename(comunidad = Place,homxlee = men_not_read, mujerxlee = women_not_read,totalxlee = total_not_read)
variable.names(junin_data)

#5. Valores Unicos de las variables "comunidad" y "District"
unique(junin_data$comunidad) 
unique(junin_data$District) 

#6. Crear columnas con las siguiente información: el % de mujeres del que no escriben ni leen (mujerxlee/totalxlee) % de varones que no escriben ni leen (homxlee/totalxlee) y % de nativos respecto al total de la población. Para el total de la población sumar (peruvian_men + peruvian_women + foreign_men + foreign_women) 
junin_data['index1'] = junin_data$mujerxlee / junin_data$totalxlee
junin_data['index2'] = junin_data$homxlee / junin_data$totalxlee

junin_data['total_pop'] = junin_data$peruvian_men + junin_data$peruvian_women + junin_data$foreign_men + junin_data$foreign_women
junin_data['index3'] = junin_data$natives / junin_data$total_pop


#7. Crear base de datos

#A 
junin_data2 <- junin_data[junin_data$District %in% c("CIUDAD DEL CERRO","JAUJA","ACOLLA","SAN GERÓNIMO","TARMA","OROYA","CONCEPCIÓN"),]
junin_data2$District #Así se comprueba qué distritos se quedaron

#B
junin_data2 <- junin_data2 %>% filter( (natives > 0) & ( mestizos > 0 ) )

#C
junin_data2 <- junin_data2[,c('index1','index2','index3','District','comunidad')] # seleccionar columnas
View(junin_data2)

#D Guardar base de datos 
write.csv(junin_data2, 'Base_cleaned_WG2.xlsx')
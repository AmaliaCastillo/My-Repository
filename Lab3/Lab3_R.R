# install.packages("dplyr") # filter data
# install.packages("readxl") # excel, csv
# install.packages("tidyr")

'Solo es necesario cargar una vez los paquetes, luego simplemente debemos llamarlo:'

library(dplyr) # librería de limpieza de datos
library(tidyr)# librería de limpieza de datos
library(readxl) # lobreria para subir archivos excel, csv

getwd() #muestra mi directorio actual get working directory
user <- Sys.getenv("USERNAME")  # username / get environmental variables


print(user)


setwd( paste0("C:/Users/",user,"/Documents/GitHub/1ECO35_2022_2/Lab3") ) # set directorio

netflix <- read.csv("../data/netflix_titles.csv", encoding = "UTF-8") # encoding : Leer caracteres especiales

# ../ salir del directorio o de una carpeta, ../../  será salir dos veces de la carpeta

netflix <- read.csv("../data/netflix_titles.csv", encoding = "UTF-8", na.strings=c("",NA)) 

# na.strings=c("",NA) reemplaza vacios por missing 

# NA, o NULL es missing en R

# Filas y columnas
dim(netflix) 

# Clase de estructura de objeto

class(netflix)

# Mostrar la variable release_year

print(release_year)

print(netflix$release_year) # será necesario llamar la variable desde la base de datos

# Permite convertir cada columna como objeto independiente sin tener que llamarla con el nombre de la base de datos

attach(netflix) #ahora sus columnas o variables son obj independientes

print(release_year)

# -------------------------------------------------------

# Información de cada variable

str(netflix)

# 

lapply(netflix, class) #bota cada variable con su tipo/ lapply(x, FUN):: output list()

str(lapply)

sapply(netflix, class) # sapply(x, FUN):: output vector, Datrame, 

summary(netflix) # estadisticas desciptivas de las variables

## Verificando ID

unique(show_id) #lista de valores unicos de show_id

length(unique(show_id)) #numero de valores unicos que tengo

duplicated(show_id) #me saldra duplicados de cada show_id

sum(duplicated(show_id) ) # suma de cantidad de duplicados

### ***Exploring a DataFrame***:

class( netflix["director"] ) # Dataframe
netflix["director"]

class( netflix[director,] )

class( netflix$director ) # lista o vector

#-----------------------------------------------------------------------

## revisando missing values

" En R, tenemos dos formas de missing, en general, NA y Null "
unique(director) 
unique(director)[1]

any( is.na(netflix["director"]) ) # TRUE: al menos un missing value

any(is.null(netflix["director"])) 

any(is.na(netflix$director))

any(is.na(director))  # al menos una observación es Missing

## cantidad de missing 

sum(is.na(director))

## Manipulando missing values

netflix %>% drop_na()  #%>% cuando usas la lib dyplr
                      #de esta forma no me elimina los missing

netflix2  <- netflix %>% drop_na() # borras todas las filas con missig values y debo crear una nueva
netflix  <- netflix %>% drop_na() #tambien puedo hacerlo así

netflix2 <- netflix %>% drop_na(director)

# borras observaciones con missing values de la columna director

netflix <- netflix %>% replace_na(list(director = "Sin director")) #reemplaza los missing por sin director y esa nueva base se llamara netflix

"En R debe asignarse el objeto alterado a uno nuevo. En este caso a Netflix2"
#----------------------------------------------------------------------------

### ***Subsetting columns***

netflix2 <- netflix[,c('director','release_year','show_id')] # seleccionar columnas
View(netflix2)

View( netflix[1:100,c('director','release_year')] ) # filtrar columnas y filas / de la obs 1 a la 100 

View( netflix[c(1,10,100),c('director','release_year')] ) #fila 1, 10 , 100

View( netflix[c(1,10,100),c(1,5)] ) # usando posiciones


View( netflix[1:100, c(1:5,10)] ) # usando posiciones / fila 1 a la 100 y columnas 1 a 5 y 10 

names(netflix)

names(netflix)[2]

#----------------------------------------------------------------------------

# Crear una nueva variable

netflix['number'] = runif(n = dim(netflix)[1], min = 1, max = 10)
netflix$number2 = runif(n = dim(netflix)[1], min = 1, max = 10)

### ***Sorting and Subsetting*** SUMAR

netflix['new'] = netflix['release_year'] + netflix['number'] 

netflix['new2'] = netflix$release_year + netflix$number

# ordering de manera ascendente por default

netflix <- netflix[order(netflix$release_year),] #se ordena de acuerdo a release year

netflix <- netflix[order(- netflix$release_year),] # descendente

#attach(netflix) 

netflix <- netflix[order(netflix$release_year, netflix$number2),]

netflix <- netflix[order(netflix$release_year, - netflix$number2),]
  
#----------------------------------------------------------------------------

### ***Subsetting rows*** FILTRAR

netflix2 <- netflix[which(netflix$release_year < 2011 & netflix$number > 5), ]
View(netflix2) #which y dentro van los condicionales

netflix %>% filter( release_year < 2011 & netflix$number > 5  )  # using Tdyr library


### ***Subsetting based on text data***

netflix2 <- netflix[which(netflix$country == "Peru"), ] #filtro en base a los que sean Perú
View(netflix2)

netflix2 <- netflix[which(netflix$country == "Mexico"), ]
View(netflix2)


netflix2 <- netflix %>% filter( (country == "Brazil") | ( netflix$country == "Peru") ) 
View(netflix2)

# American movies

netflix2 <- netflix %>% filter( (type == "Movie") & ( country == "United States") 
                                & (release_year > 2019) ) 

# %in%

"
If you want to filter by multiple values of a categorical variable,
the easiest way is to use the %in% method "


data_frame <- netflix[netflix$country %in% c("Peru","Chile"),]

data_frame <- netflix[! netflix$country %in% c("Peru","Chile"),]  # ! negación en R

data_frame <- netflix %>% rename(Titulo = title,
                                 Duration_movie = duration) #RENOMBRAR


data_frame <- netflix[, ! names(netflix) %in% c('show_id', 'director')] # Drop variables

# Export dataset

write.csv(base, '../data/new_base.csv')

write.csv(base, '../data/new_base.xlsx')


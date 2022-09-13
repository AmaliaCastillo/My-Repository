#EJERCICIO 2 R
##---------------------------

set.seed(123)

#Creo mi vector con 100 observaciones aleatorias
v1 <- c(runif(100, min=0, max=20))

#Creo mi matriz 100x50, igual que el vector anterior con numeros aleatorios
M1 <- matrix(runif(5000,min=0, max=10), nrow= 100, ncol= 50)
dim(M1) #con ello se comprueba que la matriz tiene 100 filas y 50 columnas
#Creo mi función

calculator_scalar <- function( v, M, n){
  if(! is.double(v)) stop("v must be a double")
  if(! is.double(M)) stop("M must be a double")
#Defino los componentes de mi función:   
  y <- v[n] 
  z <- M[,n]
  m3 <- min(z)
  m4 <- max(z)

  result= y-m3/ m4-m3
  
  return(result)
}  

#Pruebo mi función, con el índice 3, esto es el tercer componente de mi vector y la tercera columna de mi matriz    
calculator_scalar(v1,M1,3)

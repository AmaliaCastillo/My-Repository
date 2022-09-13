# -*- coding: utf-8 -*-
"""
Ejercicio 2 

@author: Amalia Castillo
"""
import random
import numpy as np

#fijar semilla
np.random.seed(123) 

# Crear vector con 100 observaciones
v1 = np.random.rand(100) 

#Para crear mi matriz voy a empezar con un vector base
x1 = np.random.rand(100) 
# Crear matriz en base a ese vector que sea 100x50 
X1 = x1.reshape(-1, 1) ** np.arange(0, 50)
# Vector
print(x1)
# Matriz
print(X1)
print(X1.shape) # nos dice cuantas filas y columnas tiene la matriz

# Crear función para reescalar matriz

def calculator_scalar(x, M, n):
    if not isinstance( x , np.ndarray ) :      
        raise TypeError( "x must be a n-array")
        
    if not isinstance( M , np.ndarray ) :      
        raise TypeError( "M must be a n-array") 
    
    y1 = x[n]
    z1 = M[:, n]
    m1 = min(z1)
    m2 = max(z1)

    result= y1 - m1/ m2 - m1 
    
    return result

#Hallo mi resultado con el vector y matriz creada, 
#En este caso, pondre de orden 3(elemento 3 del vector y columna 3 de la matriz) 
print(calculator_scalar(v1, X1, 3)) 
# Por ejemplo, result= 0.7903050938324261

#En esta prueba, me debe salir el error y "x must be a n-array"
print(calculator_scalar("Hola", X1, 3)) 




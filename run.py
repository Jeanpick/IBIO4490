# -*- coding: utf-8 -*-
"""
Created on Thu Feb 14 11:04:21 2019

@author: Juan David Triana
"""

#!/usr/bin/python

import numpy as np
from PIL import Image, ImageDraw
from urllib import request
import time
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import os
import zipfile
import random
import shutil

#Comienza el contador de tiempo

tic = time.time()
# Importa la base de datos
if os.path.exists(os.getcwd() + '/' + 'CG.zip')==False:
    sg_url = 'https://www.dropbox.com/s/bhcpqyvl1kr1qt0/SG.zip?dl=1'
    cg_url = 'https://www.dropbox.com/s/2wgayi8r9astx2z/CG.zip?dl=1'
    sg_b = request.urlopen(sg_url)
    cg_b = request.urlopen(cg_url)

#Lee los archivos .zip y luego los almacena en archivos .zip idénticos en
#el directorio de trabajo.
    sg_data = sg_b.read()
    cg_data = cg_b.read()

    file_s =open(os.getcwd() + '/' + 'CG.zip','wb')
    file_s.write(cg_data)
    file_s.close()

    file_c = open(os.getcwd() + '/' + 'SG.zip','wb')
    file_c.write(sg_data)
    file_c.close()

#Se descomprimeen los archivos en cuestión, creando dos directorios con la base
#de datos.
    zip_sg = zipfile.ZipFile(os.getcwd() + '/'+'SG.zip','r')
    zip_sg.extractall()
    zip_sg.close()

    zip_cg = zipfile.ZipFile(os.getcwd() + '/'+'CG.zip','r')
    zip_cg.extractall()
    zip_cg.close()

#Crea dos carpetas una para cada clase de imágenes.
if os.path.exists(os.getcwd()+'/'+'new_Base')==False:
    os.mkdir(os.getcwd()+'/'+'new_Base')


#Crea un número aleatorio entre 6 y 16.
X = random.randint(3,5)
Y = random.randint(3,5)
#Recorridos donde se observan los directorios en los cuales se encuentran las
# clases especificadas
for i in list(range(0,X)):
    cI_name = random.choice(os.listdir(os.getcwd()+'/'+'CG'))
    cg_Im = mpimg.imread(os.getcwd()+'/'+'CG'+'/'+cI_name)
    cg_Io = Image.open(os.getcwd()+'/'+'CG'+'/'+cI_name)
    c_draw = ImageDraw.Draw(cg_Io)
    c_draw.rectangle([(10,10),(40,40)],fill=(0,0,255),outline=(0,255,0))
    cg_Im_resize = cg_Io.resize(size=(256,256))
    cg_Im_resize.save(os.getcwd()+'/'+'new_Base'+'/'+'C_'+str(i)+'.png',)
    
for k in list(range(0,Y)):
    sI_name = random.choice(os.listdir(os.getcwd()+'/'+'SG'))
    sg_Im = mpimg.imread(os.getcwd()+'/'+'SG'+'/'+sI_name)
    sg_Io = Image.open(os.getcwd() + '/'+'SG'+'/'+sI_name)
    s_draw = ImageDraw.Draw(sg_Io)
    s_draw.ellipse([(10,10),(40,40)],fill=(0,255,0),outline=(0,255,0))
    sg_Im_resize = sg_Io.resize(size=(256,256))
    sg_Im_resize.save(os.getcwd()+'/'+'new_Base'+'/'+'S_'+str(k)+'.png',)

#Se crea una figura con todas las imágenes encontradas con su respectivo tag. 
fig=plt.figure()    
lista_f = os.listdir(os.getcwd()+'/'+'new_Base')
for j in list(range(1,X*Y))    :
    ax = fig.add_subplot(X,Y,j)
    imagen = mpimg.imread(os.getcwd()+'/'+'new_Base'+'/'+lista_f[j-1])
    implot = plt.imshow(imagen)
    
#Se elimina el directorio creado previamente.

shutil.rmtree(os.getcwd()+'/'+'new_Base')    
    
toc = time.time()

print('El tiempo transcurrido es: '+ str(toc-tic) +' segundos.')


#Bibliografía
#https://pillow.readthedocs.io/en/3.1.x/reference/Image.html
#https://pillow.readthedocs.io/en/3.0.x/reference/ImageDraw.html
#https://docs.python.org/2/library/os.path.html#module-os.path
#https://docs.python.org/2/library/zipfile.html#zipfile-objects
#https://docs.python.org/2/library/os.html#os-file-dir
#https://docs.python.org/2/library/random.html
#https://matplotlib.org/users/image_tutorial.html
#
#
#













    
    
    
    
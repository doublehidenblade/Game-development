from __future__ import division
import numpy as np
import scipy as sc
import sys, time, json, copy, subprocess, os
from skimage import transform
from skimage.io import imread
from PyQt5 import QtGui, QtCore, QtWidgets
import pyqtgraph as pg
import matplotlib.image
import matplotlib.image as mpimg
from PIL import Image
from matplotlib import pyplot as plt
from sklearn.feature_extraction.image import extract_patches_2d,reconstruct_from_patches_2d# for divided image into overlapping blocks
from sklearn.preprocessing import normalize # normalize the array
from skimage.util import view_as_windows
from itertools import product
from typing import Tuple
from sklearn.decomposition import PCA
from sklearn.neighbors import KNeighborsClassifier
import pandas as pd
from sklearn.metrics import confusion_matrix
# %% All functions
import function_user as uf
import importlib
from sklearn.preprocessing import StandardScaler
importlib.reload(uf)

#first image training
path1 = 'training_data/training_set2/20171026_raw.tif' # define path1 for raw img_data
path2 = 'training_data/training_set2/20171026.tif' # define path2 for masked img_data
def get_training_data(path1,path2):
    frame1,frame1_2,frame1_2_binary,frame1_2_rgb,frame1_2_rgba = uf.img_read(path1,path2)
    training_sample1 = frame1.astype(float)
    patches_size = 8
    patches_step = np.int(patches_size/2)
    training_sample1,patches_sample1,result1 = uf.generate_training(frame1_2_binary,training_sample1,patches_size,patches_step)
    feature_training1,result1,a,b,c,d = uf.feature_generate(patches_sample1,result1)
    PCs1 = uf.PCA_analysis(10,feature_training1)
    return PCs1,result1,frame1,frame1_2,frame1_2_binary,frame1_2_rgb,frame1_2_rgba
PCs1,result1,frame1,frame1_2,frame1_2_binary,frame1_2_rgb,frame1_2_rgba = get_training_data(path1,path2)
path3 = 'training_data/training_set2/2017111513_raw.tif' # define path1 for raw img_data
path4 = 'training_data/training_set2/2017111513.tif' # define path2 for masked img_data
PCs2,result2,frame2,frame2_2,frame2_2_binary,frame2_2_rgb,frame2_2_rgba = get_training_data(path3,path4)
PC= np.concatenate((PCs1,PCs2),axis=0)
result = np.concatenate((result1,result2),axis=0)
#result,brain = uf.KNN_analysis(result,5,PC,len(result))



result,brain = uf.QDA_analysis(result,PC,len(result))
y_predict1 = brain.predict(PCs1)
y_predict2 = brain.predict(PCs2)
print(confusion_matrix(result1,y_predict1))
print(confusion_matrix(result2,y_predict2))
patches_size = 8
patches_step = np.int(patches_size/2)
predict_plot1 = uf.reconstruct_image_prediction(223,319,patches_size,y_predict1,frame1)
predict_plot2 = uf.reconstruct_image_prediction(239,319,patches_size,y_predict2,frame2)
plt.figure(1,figsize=(12,12))
uf.final_plot(frame1,frame1_2,frame1_2_rgba,predict_plot1)
plt.figure(2,figsize=(12,12))
uf.final_plot(frame2,frame2_2,frame2_2_rgba,predict_plot2)

#test
path5 = 'training_data/training_set2/20170830.tif' # define path1 for raw img_data
path6 = 'training_data/training_set2/20170830_masked.tif' # define path2 for masked img_data
PCs3,result3,frame3,frame3_2,frame3_2_binary,frame3_2_rgb,frame3_2_rgba = get_training_data(path5,path6)
y_predict3 = brain.predict(PCs3)
confusion_matrix(result3,y_predict3)
predict_plot3 = uf.reconstruct_image_prediction(253,383,patches_size,y_predict3,frame3)
plt.figure(3,figsize=(12,12))
uf.final_plot(frame3,frame3_2,frame3_2_rgba,predict_plot3)

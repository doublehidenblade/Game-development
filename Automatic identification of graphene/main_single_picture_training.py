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
importlib.reload(uf)

# %% load training_data with masked and raw
path1 = 'training_data/training_set2/20171026_raw.tif' # define path1 for raw img_data
path2 = 'training_data/training_set2/20171026.tif' # define path2 for masked img_data
frame,frame2,frame2_binary,frame2_rgb,frame2_rgba = uf.img_read(path1,path2)
# %% preprocessing
training_sample = frame.astype(float)
# training_sample = normalize(training_sample,norm = 'max')
# generate training data
# %% find patches size
patches_size = uf.patches_size_find(frame)
# %% find patches step
assert patches_size % 2 == 0
patches_step = np.int(patches_size/2)
# %% break the image into overlapping image tile
 # define the patches size, we prefer to try 5 first, must be odd number
training_sample,patches_sample,result = uf.generate_training(frame2_binary,training_sample,patches_size,patches_step)
# %% show the hist plot for training sample data
plt.figure(1,figsize = (8,6))
hist1 = plt.hist(training_sample.flatten(),bins = np.linspace(0,255,num=128))

# %% generate feature from training data
feature_training,result,a,b,c,d = uf.feature_generate(patches_sample,result)
# %% using KNN to classification
# preform PCA first
PCs = uf.PCA_analysis(10,feature_training)
# using KNN method
result,y_predict,brain = uf.KNN_analysis(result,5,PCs,a*b)
# predict the training data
predict_plot = uf.reconstruct_image_prediction(a,b,patches_size,y_predict,frame)
# %% show image
plt.figure(3,figsize=(12,12))
uf.final_plot(frame,frame2,frame2_rgba,predict_plot)
confusion_matrix(result,y_predict)

# %% test

path1 = 'training_data/training_set2/2017111513_raw.tif' # define path1 for raw img_data
path2 = 'training_data/training_set2/2017111513.tif' # define path2 for masked img_data
frame,frame2,frame2_binary,frame2_rgb,frame2_rgba = uf.img_read(path1,path2)
frame.shape
training_sample = frame.astype(float)
patches_size = uf.patches_size_find(frame)
patches_size = 8
assert patches_size % 2 == 0
patches_step = np.int(patches_size/2)
testing_sample,patches_sample,result = uf.generate_training(frame2_binary,training_sample,patches_size,patches_step)
plt.figure(4,figsize = (8,6))
hist1 = plt.hist(testing_sample.flatten(),bins = np.linspace(0,255,num=128))
feature_training,result,a,b,c,d = uf.feature_generate(patches_sample,result)
PCs = uf.PCA_analysis(10,feature_training)
y_predict = brain.predict(PCs)
predict_plot = uf.reconstruct_image_prediction(a,b,patches_size,y_predict,frame)
plt.figure(5,figsize=(12,12))
uf.final_plot(frame,frame2,frame2_rgba,predict_plot)
confusion_matrix(result,y_predict)

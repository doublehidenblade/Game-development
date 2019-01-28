import cv2
path5 = 'training_data/training_set2/20170830.tif' # define path1 for raw img_data
path6 = 'training_data/training_set2/20170830_masked.tif'
im=cv2.imread(path6)
cv2.imshow('img',im)
from matplotlib import pyplot as plt
im = im[:-80,:]
plt.imshow(im)
cv2.imwrite(path6,im)

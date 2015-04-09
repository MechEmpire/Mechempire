#!/usr/bin/env python 
# -*- coding: utf-8 -*- 
 
from zipfile import * 
import zipfile


source_zip="/vagrant/Mechempire/public/uploads/mech/code/552683537661670ee2000000/myAI_3.zip" 
target_dir="./" 
myzip=ZipFile(source_zip) 
myfilelist=myzip.namelist() 
for name in myfilelist: 
    f_handle=open(target_dir+name,"wb") 
    f_handle.write(myzip.read(name))       
    f_handle.close() 
myzip.close() 
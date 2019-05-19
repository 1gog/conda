#!/bin/bash
 

eval ". /root/.bashrc" 
export LANG=en_US.utf8
export LC_LANG=en_US.utf8

conda activate py36

pip install mlflow 

mlflow --help 
python -V

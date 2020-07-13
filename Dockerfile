#FROM ubuntu:18.04
FROM neurodebian:stretch-non-free
MAINTAINER Giulia Berto <giulia.berto.4@gmail.com>

#install fsl
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           fsl-core \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV FSLDIR=/usr/share/fsl/5.0
ENV PATH=$PATH:$FSLDIR/bin
ENV LD_LIBRARY_PATH=/usr/lib/fsl/5.0:/usr/share/fsl/5.0/bin

#simulate . ${FSLDIR}/etc/fslconf/fsl.sh
ENV FSLBROWSER=/etc/alternatives/x-www-browser
ENV FSLCLUSTER_MAILOPTS=n
ENV FSLLOCKDIR=
ENV FSLMACHINELIST=
ENV FSLMULTIFILEQUIT=TRUE
ENV FSLOUTPUTTYPE=NIFTI_GZ
ENV FSLREMOTECALL=
ENV FSLTCLSH=/usr/bin/tclsh
ENV FSLWISH=/usr/bin/wish
ENV POSSUMDIR=/usr/share/fsl/5.0

#RUN apt-get update && apt-get install -y wget jq vim fsl mrtrix3 ants  #fsl and mrtrix3 do not work
RUN apt-get update && apt-get install -y wget jq vim ants

## install mrtrix3 requirements
RUN apt-get install -y git g++ python python-numpy libeigen3-dev zlib1g-dev libqt4-opengl-dev libgl1-mesa-dev libfftw3-dev libtiff5-dev

## install and compile mrtrix3
RUN git clone https://github.com/MRtrix3/mrtrix3.git
RUN cd mrtrix3 && git fetch --tags && git checkout tags/3.0_RC3 && ./configure -nogui && ./build

## manually add to path
ENV PATH=$PATH:/mrtrix3/bin

#installing dipy dependencies
RUN apt-get update && apt-get install -y python-pip git
RUN pip install numpy cython scipy matplotlib==2.2.3 h5py nibabel nipype
#RUN pip install cvxpy scikit-learn  #cvxpy does not work
RUN pip install scikit-learn==0.20.3

#RUN git clone https://github.com/nipy/dipy.git && cd dipy && pip install .
ENV DEBIAN_FRONTEND=noninteractive
RUN pip install dipy==0.16.0 joblib

#make it work under singularity
#RUN ldconfig && mkdir -p /N/u /N/home /N/dc2 /N/soft

#https://wiki.ubuntu.com/DashAsBinSh
#RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV PYTHONNOUSERSITE=true

COPY . .
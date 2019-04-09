FROM jupyter/base-notebook:8ccdfc1da8d5

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential=12.4ubuntu1 \
        emacs \
        git \
        inkscape \
        jed \
        libsm6 \
        libxext-dev \
        libxrender1 \
        lmodern \
        netcat \
        unzip \
        nano \
        curl \
        wget \
        gfortran \
        cmake \
        bsdtar  \
        rsync \
        imagemagick \
        gnuplot-x11 \
        libopenblas-base \
        python3-dev && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN cd $HOME/work;\
    pip install --upgrade pip; \
    pip install matplotlib \
                plotly \
                dash \
                dash_core_components \
                dash_html_components \
                dash_dangerously_set_inner_html \
                dash-renderer \
                flask \
                ipywidgets \
                nbconvert==5.4.0 \
                jupyterlab>=0.35.4; \
    git clone --single-branch -b master https://github.com/electropy/notebooks.git;   \
    chmod -R 777 $HOME/work/notebooks; \
    cd notebooks;\
    git clone --single-branch -b master https://github.com/electropy/electropy.git; \
    cd electropy;\
    pip install -e .;\
    cd ..;
    

WORKDIR $HOME/work/notebooks

USER $NB_UID

RUN jupyter labextension install @jupyterlab/plotly-extension;  \
    jupyter labextension install @jupyterlab/celltags;
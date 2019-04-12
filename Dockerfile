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
        libxtst6 \
        libgconf2-4 \
        xvfb \
        fuse \
        desktop-file-utils \
        gnupg2 \
        libopenblas-base \
        python3-dev && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update -y && \
    apt-get install -y google-chrome-stable


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
                psutil \
                jupyterlab>=0.35.4; \
    git clone --single-branch -b orca https://github.com/electropy/notebooks.git;     \
    chmod -R 777 $HOME/work/notebooks; \
    cd notebooks;\
    git clone --single-branch -b master https://github.com/electropy/electropy.git;  \
    cd electropy;\
    pip install -e .;\
    cd ..;\
    cd bin; \
    wget "https://github.com/plotly/orca/releases/download/v1.2.1/orca-1.2.1-x86_64.AppImage";\
    chmod 777 orca-1.2.1-x86_64.AppImage;

ENV PATH "/home/jovyan/work/notebooks/bin:$PATH"

WORKDIR $HOME/work/notebooks

USER $NB_UID

RUN jupyter labextension install @jupyterlab/plotly-extension;  \
    jupyter labextension install @jupyterlab/celltags;

FROM jupyter/scipy-notebook

USER root

RUN cd $HOME;\
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
    conda install psutil;\
    conda install -c plotly plotly-orca;\
    git clone --single-branch -b orca https://github.com/electropy/notebooks.git;     \
    chmod -R 777 $HOME/notebooks; \
    cd notebooks;\
    git clone --single-branch -b master https://github.com/electropy/electropy.git;  \
    cd electropy;\
    pip install -e .;\
    cd ..;

WORKDIR $HOME/notebooks

USER $NB_UID

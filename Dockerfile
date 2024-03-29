# This Dockerfile is based on
# https://dev.classmethod.jp/articles/use-rust-in-jupyter-notebooks-with-evcxr/

FROM jupyter/scipy-notebook

# Install dev packages
RUN conda install -y -c conda-forge \
    jupytext \
    jupyter_contrib_nbextensions \
    jupyterlab_code_formatter \
    && \
    conda clean --all -f -y

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# Install/enable extension for JupyterLab users
RUN jupyter labextension install @jupyterlab/toc --no-build && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    jupyter labextension install @z-m-k/jupyterlab_sublime --no-build && \
    jupyter labextension install @hokyjack/jupyterlab-monokai-plus --no-build && \
    jupyter labextension install jupyterlab-jupytext --no-build && \
    jupyter lab build -y && \
    jupyter lab clean -y && \
    npm cache clean --force && \
    rm -rf ${HOME}/.cache/yarn && \
    rm -rf ${HOME}/.node-gyp && \
    echo Done

# Set color theme Monokai++ by default (This choice comes from my preference.)
RUN mkdir -p ${HOME}/.jupyter/lab/user-settings/@jupyterlab/apputils-extension && \
    echo '{ "theme": "JupyterLab Dark" }' \
    >> ${HOME}/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings

# Show line numbers by default
RUN mkdir -p ${HOME}/.jupyter/lab/user-settings/@jupyterlab/notebook-extension && \
    echo '{"codeCellConfig": {"lineNumbers": true,},}' \
    >> ${HOME}/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings

# assig `Alt-R` restart run all command 
RUN mkdir -p ${HOME}/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension && echo '\
{"shortcuts": [{"command": "runmenu:restart-and-run-all","keys":["Alt R"],"selector": "[data-jp-code-runner]"}]}' >> ${HOME}/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings

RUN wget https://raw.githubusercontent.com/mwouts/jupytext/main/binder/labconfig/default_setting_overrides.json -P  ~/.jupyter/labconfig/

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

## Install Rust
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    cmake \
    libssl-dev pkg-config \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_USER}
# Setup Rust
# Reference: https://github.com/rust-lang/rustup/issues/297
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH ${HOME}/.cargo/bin:$PATH

RUN rustup --version; \
    cargo --version; \
    rustc --version;

## Install Evcxr
RUN cargo install evcxr_jupyter && \
    evcxr_jupyter --install

RUN cargo install cargo-edit

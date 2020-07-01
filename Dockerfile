# This Dockerfile is based on
# https://dev.classmethod.jp/articles/use-rust-in-jupyter-notebooks-with-evcxr/

FROM jupyter/minimal-notebook

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

## Install Rust
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    cmake \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER 1000
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

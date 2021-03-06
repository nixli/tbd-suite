FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    git \
    vim \
    pbzip2\
    pv \
    bzip2 \
    cabextract \
 && rm -rf /var/lib/apt/lists/*


# Create a working directory
RUN mkdir /build
COPY docker/environment.yml /build/
RUN mkdir /workspace


# Create a non-root user and switch to it
ARG host_uid
RUN adduser --disabled-password --gecos '' --shell /bin/bash user --uid $host_uid
RUN echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-user
ENV HOME=/home/user
RUN chmod 777 /home/user
RUN  chown -R user:user /build \
 &&  chown -R user:user /workspace
USER user


# prepare conda
ENV CONDA_AUTO_UPDATE_CONDA=false
ENV PATH=/home/user/miniconda/bin:$PATH
RUN curl -sLo ~/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh \
 && chmod +x ~/miniconda.sh \
 && ~/miniconda.sh -b -p ~/miniconda \
 && rm ~/miniconda.sh \
 && conda clean -ya


# install dependency
RUN conda env create  --file /build/environment.yml \
 && conda clean -ya
# hack, conda cannot be activated here, so we just manually specify the new pip with the python path
WORKDIR /build
RUN  git clone https://github.com/NVIDIA/apex \
 &&  cd apex \
 && /home/user/miniconda/envs/bert_pytorch/bin/python -m pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./ \
 && /home/user/miniconda/envs/bert_pytorch/bin/python -m pip install 'git+https://github.com/NVIDIA/dllogger'


# finalize shell
RUN echo "source activate bert_pytorch" > ~/.bashrc
ENV PATH /opt/conda/envs/bert_pytorch/bin:$PATH
ENV BERT_PREP_WORKING_DIR /workspace/bert/data

USER root
RUN apt-get update && apt-get install -y cuda-nsight-compute-10-1

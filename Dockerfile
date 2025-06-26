FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04
ENV DEBIAN_FRONTEND=noninteractive

# Set CUDA path (optional but recommended)
ENV PATH=/usr/local/cuda/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/lib/python3.10/dist-packages/torch/lib:/usr/local/cuda/lib64:$LD_LIBRARY_PATH


# Install basic system packages and Python environment
RUN apt-get update && apt-get install -y \
    gcc-10 g++-10 \
    python3.10 python3.10-dev python3-pip git wget cmake ninja-build build-essential ffmpeg \
    libjpeg-dev libgl1-mesa-glx libglib2.0-0 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 100 && \
    ln -sf python3.10 /usr/bin/python3 && \
    ln -sf python3.10 /usr/bin/python && \
    python3 -m pip install --upgrade pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Explicitly set GCC 10 for C/C++ builds
ENV CC=gcc-10
ENV CXX=g++-10

# Install PyTorch
RUN pip install torch==2.1.1+cu118 torchvision==0.16.1+cu118 torchaudio==2.1.1 \
    --extra-index-url https://download.pytorch.org/whl/cu118

# Install Python libraries
COPY requirements.txt .
RUN pip install -r requirements.txt
ENV LD_LIBRARY_PATH=/usr/local/lib/python3.10/dist-packages/torch/lib:$LD_LIBRARY_PATH
RUN sed -i "s/from numpy import bool, int, float, complex, object, unicode, str, nan, inf/bool = bool\\nint = int\\nfloat = float\\ncomplex = complex\\nobject = object\\nunicode = str\\nstr = str\\nfrom numpy import nan, inf/" /usr/local/lib/python3.10/dist-packages/chumpy/__init__.py

# Install PyTorch3D
ENV MAX_JOBS=2
ARG TORCH_CUDA_ARCH_LIST="8.6"
ENV TORCH_CUDA_ARCH_LIST=${TORCH_CUDA_ARCH_LIST}
ENV FORCE_CUDA=1
RUN git clone https://github.com/facebookresearch/pytorch3d.git && \
    cd pytorch3d && \
    git checkout V0.7.8 -b build && \
    python setup.py clean && \
    python setup.py build_ext --inplace && \
    pip install -e .
ENV MAX_JOBS=""

# Install Kaolin
RUN pip install kaolin==0.15.0 -f https://nvidia-kaolin.s3.us-east-2.amazonaws.com/torch-2.1.1_cu118.html

# Working directory
WORKDIR /MultiPly

# Set Git safe.directory
RUN git config --global --add safe.directory /MultiPly

COPY . .
RUN cd code && python setup.py develop
CMD ["bash"]
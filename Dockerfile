# CUDA: 11.8.0, Ubuntu: 20.04
FROM nvidia/cuda:11.8.0-base-ubuntu20.04

# Python 3.10
RUN apt-get update && apt-get install -y python3.10 python3.10-distutils python3-pip
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

WORKDIR /MultiPly

# Install PyTorch
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Install PyTorch3D
RUN pip install pytorch3d -f https://dl.fbaipublicfiles.com/pytorch3d/packaging/wheels/py3.10_cu118_pyt1110/download.html

# Install Kaolin
RUN git clone https://github.com/NVIDIAGameWorks/kaolin.git
RUN cd kaolin
RUN python setup.py install
RUN cd ..

# Install Python libraries
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt



COPY . .
CMD ["bash"]
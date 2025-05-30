# MultiPly: Reconstruction of Multiple People from Monocular Video in the Wild

## [Paper](https://arxiv.org/pdf/2406.01595) | [Video Youtube](https://youtu.be/r9giQPUp1Gw) | [Project Page](https://eth-ait.github.io/MultiPly/) | [MMM Dataset](https://multiply.ait.ethz.ch/)


Official Repository for CVPR 2024 paper [*MultiPly: Reconstruction of Multiple People from Monocular Video in the Wild*](). 
<p align="center">
<img src="resources/teaser.png" width="800" height="223"/> 
</p>

## Getting Started (for Ubuntu)

### 0-1. Git のインストール (初回のみ)
```bash
sudo apt update
sudo apt install git
```

### 0-2 Docker のインストール (初回のみ)
```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### 1. プログラムのクローン (初回のみ)
```bash
git clone 
cd MultiPly
```
#!/bin/bash

sudo apt-get update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes install software-properties-common
sudo apt-get --assume-yes install jq
sudo apt-get --assume-yes install build-essential
sudo apt-get --assume-yes install linux-headers-$(uname -r)
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ./miniconda.sh
chmod +x miniconda.sh
./miniconda.sh -b -p $HOME/miniconda3
~/miniconda3/bin/conda config --set auto_activate true
~/miniconda3/bin/conda init bash
source .bashrc
# confirm GPU is attached
lspci | grep -i nvidia
# confirm GPU not recognized
nvidia-smi
# install nvidia drivers and CUDA
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-ubuntu2404.pin
sudo mv cuda-ubuntu2404.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.9.1/local_installers/cuda-repo-ubuntu2404-12-9-local_12.9.1-575.57.08-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2404-12-9-local_12.9.1-575.57.08-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2404-12-9-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda


source .bashrc
source .bashrc
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu128
echo -e "import torch\nprint(torch.cuda.is_available())\nprint(torch.cuda.get_device_name(0))" > test_cuda.py
python test_cuda.py
sudo apt install git

## run these lines in the vm to make sure port 8188 is open for external access
#sudo ufw allow 8188/tcp
#sudo ufw reload
#sudo firewall-cmd --zone=public --add-port=8188/tcp --permanent
#sudo firewall-cmd --reload
#sudo apt-get install iptables
#sudo iptables -A INPUT -p tcp --dport 8188 -j ACCEPT

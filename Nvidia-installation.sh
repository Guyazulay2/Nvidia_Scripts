#!/bin/bash


if [ "$(dpkg -l | awk '/docker-ce/ {print }'|wc -l)" -ge 1 ]; then

        echo "--- Docker-ce exists ---!"

else

        echo "** Install Docker **"
        sudo apt update
        sudo apt install apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
        sudo apt update
        sudo apt upgrade -y 
        apt-cache policy docker-ce
        sudo apt install docker-ce -y 
        sleep 2
        echo "** Docker installed Successfully **"

fi

if [ "$(dpkg -l | awk '/gstreamer/ {print }'|wc -l)" -ge 1 ]; then

        echo "--- Gstreamer Are installed ---!"

else

        echo -e "Gstreamer Not installed !\n Installing now ..."
        sudo apt-get update
        sudo apt-get install -y gstreamer1.0-tools gstreamer1.0-nice gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-pl$
        echp "Done !"
fi



if [ "$(dpkg -l | awk '/cuda-10-2/ {print }'|wc -l)" -ge 1 ]; then

        echo "--- Cuda exists ---!"
        sleep 1
else

        echo -e "Cuda Not installed !\n installing now cuda 10.2 >>"
        wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
        sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
        wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
        sudo dpkg -i cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
        sudo apt-key add /var/cuda-repo-10-2-local-10.2.89-440.33.01/7fa2af80.pub
        sudo apt-get update
        sudo apt-get -y install cuda-10-2
        echo "Done !"
        sleep 2

fi

if [ "$(dpkg -l | awk '/nvidia-docker2/ {print }'|wc -l)" -ge 1 ]; then

        echo "--- Nvidia-Docker2 exists ---!"
        sleep 1
else

        echo -e "Nvidia-Docker-2 not exsist ! installing now ... >>"
        sleep 2
        distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
        curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
        curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
        sudo apt-get update && sudo apt-get install -y nvidia-docker2
        sudo systemctl restart docker
        sleep 2; nvidia-smi
        
       echo "******* Reboot Now *********"
       reboot

fi


### EOF ###

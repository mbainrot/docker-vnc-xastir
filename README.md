# docker-vnc-xastir
Ubuntu/LXDE/VNC desktop with Xastir pre-installed.

This is a low effort hack-together cobbling on holiday so will be janky and support is non-existant.

Credits to:
* Xastir - https://github.com/Xastir/Xastir
* KC0TFB/K5DAT for their neat script which gave me a decent list of depend packages to work off - http://www.175moonlight.com/xastir/ubuntu-xastir-git-build.sh (found on https://xastir.org/index.php/HowTo:Ubuntu_14.04-16.04#Install_Xastir)
* Docker Ubuntu VNC Desktop - https://github.com/fcwu/docker-ubuntu-vnc-desktop

# Building
Due to docker hub's recent policy change the container may not be available on the docker hub, if this is the case, perform the following
```
git clone https://github.com/mbainrot/docker-vnc-xastir.git
cd docker-vnc-xastir
docker build -t mbainrot/docker-vnc-xastir ./
```

# Preparation
To be able to retain settings due to the switches used (which makes the environment non-persistent) create the following directies
```
mkdir ~/Desktop/shared_writable
mkdir -p ~/Desktop/shared_user_profile/.xastir
```
You don't have to strictly use those directories, they are just what I use.

# Usage
```
docker run -it --rm -v ~/Desktop/shared_writable/:/root/Desktop -v ~/Desktop/shared_user_profile/.xastir:/root/.xastir -p 6091:80 -d -v /dev/shm:/dev/shm mbainrot/docker-vnc-xastir
```

# Alt-usage
This exposes the VNC port rather than the no-vnc server allowing you to use a proper vnc client 
```
docker run -it --rm -v ~/Desktop/shared_writable/:/root/Desktop -v ~/Desktop/shared_user_profile/.xastir:/root/.xastir -p 6090:80 -p 5900:5900 -d -v /dev/shm:/dev/shm mbainrot/docker-vnc-xastir
```

# Alt-usage no. 2
This exposes the VNC port rather than the no-vnc server allowing you to use a proper vnc client and also sets the resolution to 1080p (as VNC clients do not always direct the container to use a given resolution)
```
docker run -it --rm -v ~/Desktop/shared_writable/:/root/Desktop -v ~/Desktop/shared_user_profile/.xastir:/root/.xastir -p 6090:80 -p 5900:5900 -d -v /dev/shm:/dev/shm -e RESOLUTION=1920x1080 mbainrot/docker-vnc-xastir
```

# Connecting
For all of the examples above you can navigate your web browser to http://localhost:6090

For the alternative usage options you can either navigate your web browser to http://localhost:6090 or connect your VNC client to localhost:5900

For further usage information please see: https://github.com/fcwu/docker-ubuntu-vnc-desktop as this container is a remix of that container.


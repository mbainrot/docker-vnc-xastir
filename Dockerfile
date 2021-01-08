FROM dorowu/ubuntu-desktop-lxde-vnc
LABEL maintainer="mbainrot@github.com"

# Retrieve prerequisits
RUN apt-get update && apt-get install -y git  build-essential git autoconf automake xorg-dev graphicsmagick gv gpsman gpsmanshp libpcre3-dev libdb5.3-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libwebp-dev libgraphicsmagick1-dev libmotif-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev xfonts-100dpi xfonts-75dpi

# Next we retrieve xastir from github
RUN git clone https://github.com/Xastir/xastir.git

# Now we kick off the build
RUN cd xastir && ./bootstrap.sh && mkdir -p build && cd build && ../configure && make && make install

# Next we build an application shortcut and link it to /root
#RUN echo "[Desktop Entry]\nName=FlatCAM 8.99\nExec=python3 /usr/flatcam/FlatCAM.py\n\
#	Type=Application\nIcon=/usr/flatcam/share/flatcam_icon128.png" \
#    > /usr/share/applications/FlatCAM.desktop

# Create desktop shortcut for root
#RUN mkdir -p /root/Desktop && \
#    echo "[Desktop Entry]\nType=Link\nName=FlatCAM 8.99\n\
#    Icon=/usr/flatcam/share/flatcam_icon128.png\n\
#	URL=/usr/share/applications/FlatCAM.desktop" > /root/Desktop/flatcam.desktop

# We reuse this stuff from dorowu/ubuntu-desktop-lxde-vnc so the container starts as it should
#EXPOSE 80
#WORKDIR /root
#ENV HOME=/home/ubuntu SHELL=/bin/bash
#HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://127.0.0.1:6079/api/health
#ENTRYPOINT ["/startup.sh"]
# ENTRYPOINT ["/bin/sh"]
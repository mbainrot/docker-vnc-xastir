FROM dorowu/ubuntu-desktop-lxde-vnc
LABEL maintainer="mbainrot@github.com"

# Retrieve prerequisits
RUN apt-get update && apt-get install -y git  build-essential git autoconf automake xorg-dev graphicsmagick gv gpsman gpsmanshp libpcre3-dev libdb5.3-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libwebp-dev libgraphicsmagick1-dev libmotif-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev xfonts-100dpi xfonts-75dpi

# Next we retrieve xastir from github
RUN git clone https://github.com/Xastir/xastir.git

# Now we kick off the build
RUN cd xastir && ./bootstrap.sh && mkdir -p build && cd build && ../configure && make && make install

# Change the name of the page so the tab makes sense
RUN cat /usr/local/lib/web/frontend/index.html | sed -E 's/novnc2/novnc2 - Xastir/' > /usr/local/lib/web/frontend/index.html.temp && \
    mv /usr/local/lib/web/frontend/index.html.temp /usr/local/lib/web/frontend/index.html

# Next we build an application shortcut and link it to /root
RUN echo "[Desktop Entry]\nName=Xastir\nExec=xastir\n\
	Type=Application\nIcon=/usr/local/share/xastir/symbols/icon.png" \
    > /usr/share/applications/Xastir.desktop && \
    chmod a+x /usr/share/applications/Xastir.desktop

# Create desktop shortcut for root
RUN mkdir -p /root/Desktop && \
    echo "[Desktop Entry]\nName=Xastir\nExec=xastir\n\
	Type=Application\nIcon=/usr/local/share/xastir/symbols/icon.png" \
    > /root/Desktop/Xastir.desktop && \
    chmod a+x /root/Desktop/Xastir.desktop

# We reuse this stuff from dorowu/ubuntu-desktop-lxde-vnc so the container starts as it should
EXPOSE 80
WORKDIR /root
ENV HOME=/home/ubuntu SHELL=/bin/bash
HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://127.0.0.1:6079/api/health
ENTRYPOINT ["/startup.sh"]
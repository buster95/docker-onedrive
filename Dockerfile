
FROM archlinux/base

RUN pacman --noconfirm -Sy curl sqlite dmd make git
RUN cd /opt && git clone https://github.com/skilion/onedrive.git && cd onedrive && make && make install && mkdir /config && cp -rf ./config /config

COPY files/start.sh /opt/start.sh
RUN chmod 755 /opt/*.sh

ENTRYPOINT /opt/start.sh

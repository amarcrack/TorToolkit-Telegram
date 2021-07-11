FROM ubuntu:20.04
WORKDIR /
RUN chmod -R 777 /
RUN apt-get -qq update
ENV TZ Asia/Kolkata
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq install -y curl git wget \
    python3 python3-pip \
    aria2 \
    ffmpeg mediainfo  unzip p7zip-full p7zip-rar
RUN apt-get install -y python3-venv
RUN curl https://rclone.org/install.sh | bash
RUN apt-get install -y software-properties-common && apt-get -y update
RUN add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable && apt-get install -y qbittorrent-nox

COPY . .
COPY start.sh /TorToolkit-Telegram
COPY alive.sh /TorToolkit-Telegram
RUN chmod 777 start.sh
RUN chmod 777 alive.sh

RUN useradd -ms /bin/bash  myuser
USER myuser

CMD bash start.sh && bash alive.sh

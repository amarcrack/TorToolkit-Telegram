FROM ubuntu:20.04
WORKDIR /tortoolkit
RUN chmod -R 777 /tortoolkit
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

RUN git clone https://github.com/amarcrack/TorToolkit-Telegram.git && cd TorToolkit-Telegram && pip install -r requirements.txt
RUN python3 -m venv venv

COPY . .
COPY start.sh /tortoolkit/TorToolkit-Telegram
COPY alive.sh /tortoolkit/TorToolkit-Telegram
RUN chmod 777 start.sh
RUN chmod 777 alive.sh

RUN useradd -ms /bin/bash  myuser
USER myuser

CMD ./start.sh && ./alive.sh

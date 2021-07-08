FROM ubuntu:20.04
WORKDIR /tortoolkit
RUN chmod -R 777 /tortoolkit
RUN apt-get -qq update
ENV TZ Asia/Kolkata
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq install -y curl git wget \
    python3 python3-pip \
    aria2 \
    ffmpeg mediainfo unzip p7zip-full p7zip-rar

RUN curl https://rclone.org/install.sh | bash
RUN apt-get install -y software-properties-common && apt-get -y update
RUN add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable && apt-get install -y qbittorrent-nox

RUN pip3 install --no-cache-dir tortoolkit

COPY . .
COPY start.sh /tortoolkit
COPY alive.sh /tortoolkit
RUN chmod 777 start.sh
RUN chmod 777 alive.sh

RUN useradd -ms /bin/bash  myuser
USER myuser

CMD ./start.sh && ./alive.sh

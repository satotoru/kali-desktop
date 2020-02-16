FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
      kali-linux-full \
      xfonts-base \
      kali-desktop-xfce \
      dbus-x11

RUN apt-get install -y \
      task-japanese \
      task-japanese-desktop \
      fonts-vlgothic

RUN apt-get install -y \
      xfce4-terminal \
      x11-xserver-utils \
      fcitx \
      fcitx-mozc \
      fcitx-config-gtk \
      fcitx-frontend-gtk3

RUN apt-get autoremove && apt-get clean

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=ja_JP.UTF-8

ENV LC_ALL ja_JP.UTF-8

ENV DEBIAN_FRONTEND dialog

ENV USER kali
ENV HOME /home/${USER}
RUN useradd -m ${USER}
RUN gpasswd -a ${USER} sudo
RUN echo "${USER}:${USER}" | chpasswd

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER kali
WORKDIR /home/kali

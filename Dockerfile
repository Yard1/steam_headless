FROM ubuntu:18.04
LABEL author="Antoni Baum (Yard1) <antoni.baum@protonmail.com>"

RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
	ca-certificates \
	fontconfig-config \
	lib32gcc1 \
	lib32stdc++6 \
	libasound2 \
	libatk1.0-0 \
	libatomic1 \
	libdbus-1-3 \
	libfontconfig1 \
	libglib2.0-0 \
	libglu1-mesa \
	libnss3 \
	libpangocairo-1.0-0 \
	libx11-6 \
	libxcomposite1 \
	libxcursor1 \
	libxi6 \
	libxrandr2 \
	libxss1 \
	libxtst6 \
	locales \
    sudo \
	&& apt-get install -y \
	xauth \
	xvfb \
	libgl1-mesa-dri:i386 \
	libgl1-mesa-glx:i386 \
	libc6:i386 \
	steam \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
	&& useradd -m steam \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

ADD asound.conf /etc/asound.conf
ADD xvfb_init /etc/init.d/xvfb
ADD xvfb_daemon_run /usr/bin/xvfb-daemon-run

RUN set -x \
	&& mkdir /var/run/xvfb \
	&& chown steam:steam /var/run/xvfb/

RUN echo "steam     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ADD lib/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh && sed -i 's/\r$//' /entrypoint.sh

USER steam
ENV HOME /home/steam
WORKDIR "/home/steam"

# Run Steam once to let it update, and cache the update
ADD --chown=steam:steam lib/update_steam.sh /home/steam/
RUN /home/steam/update_steam.sh

ENV LANG en_US.utf8

ENTRYPOINT [ "/entrypoint.sh" ]

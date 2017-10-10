FROM java:8
MAINTAINER Kenny Williams <kenny@provisdom.com>
ENV LEIN_DIR /usr/local/bin/lein
ENV LEIN_ROOT true

RUN wget -O $LEIN_DIR https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && chmod a+x $LEIN_DIR && lein
RUN wget -O /usr/bin/boot https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh && chmod +x /usr/bin/boot

ENV BOOT_HOME /.boot
ENV BOOT_LOCAL_REPO /m2
ENV BOOT_AS_ROOT yes
ENV BOOT_VERSION 2.7.2
ENV BOOT_EMIT_TARGET no

# download & install deps, cache REPL and web deps
RUN /usr/bin/boot web -s doesnt/exist repl -e '(System/exit 0)' && rm -rf target
RUN /usr/bin/boot -v
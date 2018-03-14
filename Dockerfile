FROM ubuntu:16.04

ARG QT=5.10.1
ARG QTM=5.10
ARG QTSHA=d89ceb235e46a41240ffddd1fed558d32a27e8d10b4efa7c9b2541cc5bdb4ee6
ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.name="qt-build" \
      org.label-schema.description="A headless Qt $QTM build environment for Ubuntu" \
      org.label-schema.url="e.g. https://github.com/TeamWertarbyte/qt-build" \
      org.label-schema.vcs-ref="$VCS_REF" \
      org.label-schema.vcs-url="https://github.com/TeamWertarbyte/qt-build.git" \
      org.label-schema.version="$QT" \
      org.label-schema.schema-version="1.0"

RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
        ant \
        build-essential \
        ca-certificates \
        default-jdk \
        git \
        libfontconfig1 \
        libice6 \
        libsm6 \
        libxext6 \
        libxrender1 \
        openssh-client \
        p7zip \
        xvfb \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        locales \
        wget \
    && apt-get clean

ADD qt-installer-noninteractive.qs /tmp/qt/script.qs
RUN wget -q http://download.qt.io/official_releases/qt/${QTM}/${QT}/qt-opensource-linux-x64-${QT}.run -O /tmp/qt/installer.run \
    && echo "${QTSHA}  /tmp/qt/installer.run" | shasum -a 256 -c \
    && chmod +x /tmp/qt/installer.run \
    && xvfb-run /tmp/qt/installer.run --script /tmp/qt/script.qs \
     | egrep -v '\[[0-9]+\] Warning: (Unsupported screen format)|((QPainter|QWidget))' \
    && rm -rf /tmp/qt

RUN echo /opt/qt/${QTM}/gcc_64/lib > /etc/ld.so.conf.d/qt-${QTM}.conf
RUN locale-gen en_US.UTF-8 && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/qt/${QT}/gcc_64/bin

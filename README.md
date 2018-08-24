# qt-build

A headless [Qt] 5.10.1 build environment for Ubuntu, based on
[16.04 LTS (Xenial Xerus)][xenial].

[![](https://images.microbadger.com/badges/image/wertarbyte/qt-build:xenial-5.10.1.svg)](https://microbadger.com/images/wertarbyte/qt-build:xenial-5.10.1 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/wertarbyte/qt-build:xenial-5.10.1.svg)](https://microbadger.com/images/wertarbyte/qt-build:xenial-5.10.1 "Get your own version badge on microbadger.com")

## Usage

* `docker pull wertarbyte/qt-build:xenial-5.10.1`
* `docker run -t -i --rm -v $PWD:$PWD wertarbyte/qt-build:xenial-5.10.1 bash`
* `qmake` in the container

## Selected Components

* `qt.qt5.5101.gcc_64`

Edit `qt-installer-noninteractive.qs` and build your own image to add more.

## Building

* `make`

Or:

* `docker pull ubuntu:16.04`
* `docker build .`

Use `docker-build --build-arg` to override `QT`, `QTM`, and `QTSHA` to build
with a different version of Qt.

## Credits

* [Xian Nox][xiannox] for the Qt 5.7-beta image

[Qt]: https://www.qt.io
[xenial]: http://releases.ubuntu.com/16.04/
[xiannox]: https://hub.docker.com/u/xiannox

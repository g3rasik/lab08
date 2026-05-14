FROM ubuntu:18.04

RUN apt update && apt install -yy gcc g++ cmake libgtest-dev

# Сборка и установка GTest в систему контейнера
RUN cd /usr/src/gtest && cmake . && cmake --build . && cp *.a /usr/lib

COPY . print/
WORKDIR print

RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install -DHUNTER_ENABLED=OFF -DGTest_DIR=/print/cmake
RUN cmake --build _build
RUN cmake --build _build --target install

ENV LOG_PATH /home/logs/log.txt
VOLUME /home/logs
WORKDIR _install/bin
ENTRYPOINT ./demo

# base image
FROM debian:buster-slim

# setting to temp dir
WORKDIR /tmp

# getting all dependencies (dynamic linking)
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    build-essential \
    cmake \
    git \
    libass-dev \
    libbz2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libjansson-dev \
    liblzma-dev \
    libmp3lame-dev \
    libnuma-dev \
    libogg-dev \
    libopus-dev \
    libsamplerate-dev \
    libspeex-dev \
    libtheora-dev \
    libtool \
    libtool-bin \
    libvorbis-dev \
    libx264-dev \
    libxml2-dev \
    libvpx-dev \
    m4 \
    make \
    meson \
    nasm \
    ninja-build \
    patch \
    pkg-config \
    python \
    tar \
    zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# separate run for building from source version
ARG HBVERS=1.3.1
RUN git clone https://github.com/HandBrake/HandBrake.git && \
    cd HandBrake && \
    git checkout "${HBVERS}" && \
    ./configure --disable-gtk --launch-jobs=$(nproc) --launch && \
    mv build/HandBrakeCLI /usr/local/bin && \
    rm -rf /tmp/*

# setting command
CMD ["HandBrakeCLI","--help"]

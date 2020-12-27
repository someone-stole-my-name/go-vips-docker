FROM golang:1.15.5

ENV DEBIAN_FRONTEND noninteractive
ENV VIPS_VERSION=8.10.2

RUN apt-get update && \
    apt-get install -y \
        wget \
        automake \
        build-essential \
        pkg-config \
        gobject-introspection \
        --no-install-recommends

RUN apt-get -q -y install \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libglib2.0-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    gtk-doc-tools \
    libgif-dev \
    libx11-dev \
    libexpat1-dev \
    libwebp-dev \
    liborc-0.4-dev \
    liborc-0.4-0 \
    --no-install-recommends

RUN cd && \
	wget --no-check-certificate https://github.com/libvips/libvips/releases/download/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz && \
	tar xvzf vips-${VIPS_VERSION}.tar.gz && \
	cd vips* && \
    ./configure \
        --enable-debug=no \
        --without-python \
        --without-fftw \
        --without-libgf \
        --without-little-cms \
        --without-pango \
        --prefix=/usr  && \
	make -j$(nproc) && make install && \
	ldconfig /usr/local/lib

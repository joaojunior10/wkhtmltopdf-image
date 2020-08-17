FROM ubuntu:20.04
LABEL maintainer="jfjunior10@gmail.com"

RUN DEBIAN_FRONTEND='noninteractive' apt update

# Install OpenJDK-8
RUN DEBIAN_FRONTEND='noninteractive' apt install -y openjdk-8-jre-headless

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# Download and install dependences
ARG  jpeg=libjpeg-dev
ARG  ssl=libssl-dev
ENV  CFLAGS=-w CXXFLAGS=-w

RUN DEBIAN_FRONTEND='noninteractive' apt install -y -q --no-install-recommends \
    build-essential \
    libfontconfig1-dev \
    libfreetype6-dev \
    fontconfig \
    xfonts-75dpi \
    xfonts-base \
    $jpeg \
    libpng-dev \
    $ssl \
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    python \
    zlib1g-dev \
    wget \
    ttf-ubuntu-font-family \
    ttf-mscorefonts-installer \
    && rm -rf /var/lib/apt/lists/*

#Instal Microsoft fonts
RUN wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb
RUN dpkg -i ttf-mscorefonts-installer_3.6_all.deb
RUN rm ttf-mscorefonts-installer_3.6_all.deb

#Clean fonts cache
RUN fc-cache -f -v

# Download and install wkhtmltopdf
RUN wget --no-check-certificate https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb
RUN dpkg -i wkhtmltox_0.12.6-1.focal_amd64.deb
RUN rm wkhtmltox_0.12.6-1.focal_amd64.deb
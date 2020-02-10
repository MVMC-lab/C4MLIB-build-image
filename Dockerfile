FROM ubuntu:18.04


# Install package
RUN apt-get update -q
RUN apt-get install -y -q wget make git
RUN apt-get install -y -q python3 python3-pip

COPY pip-install-list.txt .

# Download build avr-gcc
RUN wget -nv https://blog.zakkemble.net/download/avr-gcc-9.2.0-x64-linux.tar.bz2
RUN wget -nv https://blog.zakkemble.net/download/avr-gcc-8.3.0-x64-linux.tar.bz2

# Install python modules
RUN pip3 install -r pip-install-list.txt

# Tar
RUN tar -xf avr-gcc-9.2.0-x64-linux.tar.bz2
RUN tar -xf avr-gcc-8.3.0-x64-linux.tar.bz2

# Move files
RUN mkdir /usr/local/bin/avr-gcc-9.2.0
RUN mkdir /usr/local/bin/avr-gcc-8.3.0
RUN mv avr-gcc-9.2.0-x64-linux/* /usr/local/bin/avr-gcc-9.2.0
RUN mv avr-gcc-8.3.0-x64-linux/* /usr/local/bin/avr-gcc-8.3.0

# Remove files
RUN rm avr-gcc-9.2.0-x64-linux.tar.bz2
RUN rm avr-gcc-8.3.0-x64-linux.tar.bz2
RUN rm avr-gcc-9.2.0-x64-linux -r
RUN rm avr-gcc-8.3.0-x64-linux -r
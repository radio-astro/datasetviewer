FROM ubuntu:14.04
MAINTAINER gijs@pythonic.nl

ENV DEBIAN_FRONTEND noninteractive

ADD apt.sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common python-software-properties


## add radioastro PPA
RUN add-apt-repository -y ppa:radio-astro/main
RUN apt-get update


ADD debian_packages /
ADD python_packages /
ADD dev_packages /


# install debian packages
RUN cat /dev_packages /debian_packages | xargs apt-get -qy install


# install all python modules
RUN pip install -r /python_packages


# cleanup
#RUN apt-get -qy clean
#RUN rm -rf \
#    /var/lib/apt/lists/* \
#    /tmp/* \
#    /var/tmp/*

# remove package only used for compiling
#RUN cat /dev_packages | xargs apt-get purge -yq


## Expose the ipython notebook port
EXPOSE 8888


## location of the Ipython notebooks.
VOLUME /notebooks
VOLUME /data


## Run ipython notebook
CMD /usr/bin/python /usr/local/bin/ipython notebook --ip=*



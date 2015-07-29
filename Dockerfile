FROM fedora:21

MAINTAINER fabric8.io <fabric8@googlegroups.com>

ADD builder.sh builder.sh
CMD bash '~/builder.sh';
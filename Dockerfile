FROM alpine:edge
MAINTAINER Hearst Automation Team <atat@hearst.com>

ENV DOKU_HOME /opt/dokuwiki

# Update & install packages
RUN apk --update add \
    bash \
    wget \
    tar \
    lighttpd \
    php-cgi \
    php-gd \
    php-xml \
    php-openssl \
    && rm -rf /var/cache/apk/*

RUN mkdir -p $DOKU_HOME

WORKDIR $DOKU_HOME

# Download dokuwiki
RUN wget -O $DOKU_HOME/dokuwiki.tgz \
	"http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz"

# Ignore internal folder name, just extract the good bits
RUN tar -zxf dokuwiki.tgz --strip-components=1

# Set ownership and access
RUN chmod -R 755 $DOKU_HOME /var/log/lighttpd
RUN chown -R lighttpd:lighttpd $DOKU_HOME /var/log/lighttpd /var/run/lighttpd

# Run cgi fix
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/php.ini

# Configure lighttpd
ADD lighttpd.conf /etc/lighttpd/lighttpd.conf

# Cleanup
RUN rm dokuwiki.tgz

EXPOSE 80
VOLUME $DOKU_HOME/data
VOLUME $DOKU_HOME/lib/plugins
VOLUME $DOKU_HOME/conf
VOLUME $DOKU_HOME/lib/tpl

ENTRYPOINT ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

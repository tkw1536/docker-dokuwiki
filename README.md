# tkw01536/alpine-dokuwiki
Uses the Alpine image and sets up a container with [dokuwiki](https://www.dokuwiki.org/) installed. Follows build instructions similar to the [Alpine Wiki](http://wiki.alpinelinux.org/wiki/DokuWiki) with directory modifications. 

This is a fork of [the original project](https://github.com/HearstAT/docker-alpinedokuwiki) to incoperate changes needed for recent DokuWiki versions. 

# Build Info
## Images
- [alpine:edge](https://hub.docker.com/_/alpine/)

## Ports
- Dokuwiki/Lighttpd: 80 Container Side

## Volumes
- /opt/dokuwiki/data/
- /opt/dokuwiki/lib/plugins/
- /opt/dokuwiki/conf/
- /opt/dokuwiki/lib/tpl/

# Usage

```
docker run -p 80:80 tkw01536/alpine-dokuwiki
```

This will store the workspace in /opt/dokuwiki/data. You will probably want to make that a persistent volume (recommended):

```
docker run -p 80:80 -v /you/path:/opt/dokuwiki/data tkw01536/alpine-dokuwiki
```

or only mount the plugins folder

```
docker run -p 80:80 -v /you/path:/opt/dokuwiki/lib/plugins tkw01536/alpine-dokuwiki
```

# Building
To build the image, do the following:

```
% docker build github.com/tkw01536/docker-alpinedokuwiki
```

A prebuilt container is available in the docker index.

```
% docker pull tkw01536/alpine-dokuwiki
```

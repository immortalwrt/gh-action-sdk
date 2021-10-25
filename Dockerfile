ARG CONTAINER=immortalwrt/opde
ARG ARCH=sdk-x86_64
FROM $CONTAINER:$ARCH

LABEL "com.github.actions.name"="ImmortalWrt SDK"

ADD entrypoint.sh /

USER root

ENTRYPOINT ["/entrypoint.sh"]

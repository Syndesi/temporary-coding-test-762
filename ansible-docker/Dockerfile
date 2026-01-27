# inspired by https://github.com/mini-containers/docker-ansible/blob/master/2.5/Dockerfile

FROM python:3.14.2-alpine3.23
LABEL org.opencontainers.image.title="Ansible" \
    org.opencontainers.image.description="SENEC coding example." \
    org.opencontainers.image.authors="Sören Klein"

ENV ANSIBLE_VERSION=13.2.0

RUN apk add --no-cache \
        bash \
        git \
        openssh-client \
        openssl \
    && \
    pip3 install --upgrade --no-cache-dir \
        ansible==$ANSIBLE_VERSION \
        docker && \
    mkdir /ansible

#RUN set -ex && \
#    apk add --no-cache \
#        openssh-client \
#        openssl \
#        sshpass \
#        apache2-utils \
#        git \
#        bash && \
#    mkdir -p /srv/ansible
#
#RUN set -ex && \
#    apk add --no-cache --virtual .build-deps \
#        gcc \
#        libffi-dev \
#        libressl-dev \
#        linux-headers \
#        make \
#        musl-dev && \
#    pip3 install --upgrade --no-cache-dir \
#        ansible==$ANSIBLE_VERSION \
#        docker \
#        passlib && \
#    apk del .build-deps

WORKDIR /ansible

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

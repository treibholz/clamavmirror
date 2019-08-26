FROM debian:buster-slim

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get --no-install-recommends install -y clamav python3-dnspython python3-urllib3 python3-certifi tini \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY clamavmirror/__init__.py /bin/clamavmirror
COPY entrypoint.sh /bin/entrypoint.sh

RUN sed -i -e 's!#\!/usr/bin/env\ python!#\!/usr/bin/env\ python3!' /bin/clamavmirror
RUN mkdir /mirror && chown clamav /mirror

USER clamav
WORKDIR /mirror

ENTRYPOINT ["tini", "entrypoint.sh"]

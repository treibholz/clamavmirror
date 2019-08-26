FROM alpine:3.10

RUN apk add --no-cache py3-dnspython py3-urllib3 py3-certifi tini clamav

COPY clamavmirror/__init__.py /bin/clamavmirror
COPY entrypoint.sh /bin/entrypoint.sh

RUN sed -i -e 's!#\!/usr/bin/env\ python!#\!/usr/bin/env\ python3!' /bin/clamavmirror
RUN mkdir /mirror && chown clamav /mirror

USER clamav
WORKDIR /mirror

ENTRYPOINT ["tini", "entrypoint.sh"]

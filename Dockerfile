FROM python:3-slim

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --no-install-suggests -y ffmpeg

RUN python -m pip install --no-cache-dir --upgrade pip
RUN python -m pip install --no-cache-dir --upgrade streamlink requests

COPY ./twitch-recorder.py /opt

ARG UNAME=user
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
RUN chown -R $UID:$GID /opt
USER $UNAME

CMD ["python", "/opt/twitch-recorder.py"]

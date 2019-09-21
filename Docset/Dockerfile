FROM python:latest

MAINTAINER redbeard28 <https://github.com/redbeard28/docker_mkdocs>

# Install dependencies
COPY * /
RUN mkdir /work \
    && chmod 755 /generate_doc.sh \
    && chmod 755 /html2dash.py
RUN pip install --upgrade pip


RUN \
  pip install -r requirements.txt && \
  rm requirements.txt


WORKDIR /work

VOLUME /work

ENTRYPOINT ["/generate_doc.sh"]
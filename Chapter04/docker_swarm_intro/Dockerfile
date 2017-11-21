FROM python:3

ENV SRV_PATH=/srv/www/html

EXPOSE 8000

RUN mkdir -p $SRV_PATH && \
    groupadd -r -g 350 pythonsrv && \
    useradd -r -m -u 350 -g 350 pythonsrv && \
    echo "Test file content" > $SRV_PATH/test.txt && \
    chown -R pythonsrv:pythonsrv $SRV_PATH

WORKDIR $SRV_PATH

CMD [ "python3", "-m", "http.server" ]

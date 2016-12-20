FROM alpine:latest

RUN apk add --no-cache bash tinyproxy

RUN chown nobody /var/run/tinyproxy

RUN touch /var/log/tinyproxy/tinyproxy.log && \
    chown nobody /var/log/tinyproxy/tinyproxy.log

ADD start.sh /
ADD tinyproxy.conf /etc
RUN chown nobody /start.sh && chmod +x /start.sh

EXPOSE 8888

ENTRYPOINT [ "/start.sh" ]

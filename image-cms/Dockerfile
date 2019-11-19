FROM alpine:latest
MAINTAINER Niccolò Izzo <izzo.niccolo@gmail.com>

RUN apk add --no-cache python3 git postgresql-dev bash alpine-sdk libffi-dev python3-dev cups-dev
RUN mkdir -p /cms
WORKDIR /cms
EXPOSE 8888 8889 8890
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["cms"]

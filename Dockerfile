FROM alpine:latest
MAINTAINER Niccolò Izzo <izzo.niccolo@gmail.com>

RUN apk add --no-cache python3 git
RUN python3 -m ensurepip
RUN git clone --recursive https://github.com/cms-dev/cms /cms || true
EXPOSE 8888 8889 8890
ADD entrypoint.sh ./
ENTRYPOINT ["./entrypoint.sh"]
CMD ["cms"]

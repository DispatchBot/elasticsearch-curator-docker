FROM alpine:3.4

RUN apk --update add python py-setuptools py-pip && \
    pip install elasticsearch-curator==4.2.6 && \
    apk del py-pip && \
    rm -rf /var/cache/apk/*

RUN apk update && \
  apk add ca-certificates wget && \
  wget https://s3.amazonaws.com/dispatchbot-devops/ca-chain.cert.pem && \
  mv ca-chain.cert.pem /usr/local/share/ca-certificates/dispatchbot-ca-chain.cert.crt && \
  update-ca-certificates && \
  apk del wget && \
  rm -rf /var/cache/apk/*

COPY actions.yml actions.yml
COPY curator.yml curator.yml


CMD ["/usr/bin/curator", "--config", "./curator.yml", "./actions.yml"]

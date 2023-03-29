FROM alpine:3.17.2 as downloader

RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.14.0/pocketbase_0.14.0_linux_amd64_cgo.zip \
    && unzip pocketbase_pocketbase_0.14.0_linux_amd64_cgo.zip \
    && chmod +x /pocketbase

FROM alpine:3.17.2
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

EXPOSE 2331

COPY --from=downloader /pocketbase /usr/local/bin/pocketbase
ENTRYPOINT ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:2331", "--dir=/pb_data", "--publicDir=/pb_public"]

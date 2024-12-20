# stage one
FROM docker.io/library/golang:1.23 AS builder
WORKDIR /build
ENV GOPROXY=https://goproxy.cn,direct
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app .


# stage two
FROM docker.io/library/debian:12
WORKDIR /app
COPY --from=builder /build/app .
ENTRYPOINT ["/app/app"]

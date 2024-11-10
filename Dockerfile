FROM golang:1.18-alpine AS builder
COPY hello.go /
WORKDIR /
RUN ["go","build","hello.go"]

FROM alpine:3.19.1
COPY --from=builder /hello /hello
CMD ["/hello"]

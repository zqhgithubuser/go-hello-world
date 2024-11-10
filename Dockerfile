FROM golang:1.18-alpine AS builder
COPY hello-world.go /
WORKDIR /
RUN go build hello-world.go

FROM alpine:3.19.1
COPY --from=builder /hello-world /hello-world
CMD ["/hello-world"]

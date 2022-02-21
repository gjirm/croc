FROM golang:1.17-alpine as builder
RUN apk add --no-cache git
WORKDIR /go/croc
COPY . .
RUN go build -v -ldflags="-s -w"

FROM alpine:latest
EXPOSE 10009
EXPOSE 10010
EXPOSE 10011
EXPOSE 10012
EXPOSE 10013
COPY --from=builder /go/croc/croc /croc
USER nobody
CMD ["sh", "-c", "/croc --pass $CROC_PASS relay --ports 10009,10010,10011,10012,10013"]

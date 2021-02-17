FROM golang:1-buster as builder

WORKDIR /go/src/cliapp-f2cm
COPY go.mod go.sum ./
RUN go mod download

COPY cmd/main.go ./
RUN go test ./...
RUN CGO_ENABLED=0 go build -o f2cm .

FROM scratch
WORKDIR /
COPY --from=builder /go/src/cliapp-f2cm/f2cm ./
ENTRYPOINT ["/f2cm"]

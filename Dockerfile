FROM golang:1.21 as builder
RUN go install github.com/playwright-community/playwright-go/cmd/playwright@v0.4201.1

FROM ubuntu:jammy
COPY --from=builder /go/bin/playwright /
RUN apt-get update && apt-get install -y ca-certificates tzdata \
    && /playwright install --with-deps chromium \
    && rm -rf /var/lib/apt/lists/*

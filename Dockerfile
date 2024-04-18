FROM golang:1.21 as builder
RUN PLAYWRIGHT_GO_VERSION="0.4201.1" \
    && go install github.com/playwright-community/playwright-go/cmd/playwright@${PLAYWRIGHT_GO_VERSION}

FROM ubuntu:jammy
COPY --from=builder /go/bin/playwright /
RUN apt-get update && apt-get install -y ca-certificates tzdata \
    && /playwright install --with-deps chromium \
    && rm -rf /var/lib/apt/lists/*

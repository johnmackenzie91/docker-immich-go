# ---- Build stage ----
FROM golang:1.25-alpine AS builder

# Install git (needed for go install from GitHub)
RUN apk add --no-cache git

# Download and build immich-go
RUN go install github.com/simulot/immich-go@v0.28.0

# ---- Runtime stage ----
FROM alpine:latest
RUN apk add --no-cache ca-certificates

# Copy binary from build stage
COPY --from=builder /go/bin/immich-go /usr/local/bin/immich-go

# Default working directory
WORKDIR /data

# Set immich-go as the entrypoint
ENTRYPOINT ["immich-go"]

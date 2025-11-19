# Use the official Alpine base image
FROM alpine:latest

# Set the PocketBase version as a build argument
ARG PB_VERSION=0.33.0

# Install necessary packages
RUN apk add --no-cache \
    unzip \
    ca-certificates

# Download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

# Uncomment to copy the local pb_migrations dir into the container
# COPY ./pb_migrations /pb/pb_migrations

# Uncomment to copy the local pb_hooks dir into the container
# COPY ./pb_hooks /pb/pb_hooks

# Expose the PocketBase server port
EXPOSE 8080

# Set the entry point to start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]

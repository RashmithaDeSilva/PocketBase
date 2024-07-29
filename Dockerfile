# Use the official Alpine base image
FROM alpine:latest

# Set the PocketBase version as a build argument
ARG PB_VERSION=0.19.0

# Install necessary packages
RUN apk add --no-cache \
    unzip \
    ca-certificates \
    curl \
    # this is needed only if you want to use scp to copy later your pb_data locally
    openssh

# Download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

# Uncomment to copy the local pb_migrations dir into the container
# COPY ./pb_migrations /pb/pb_migrations

# Uncomment to copy the local pb_hooks dir into the container
# COPY ./pb_hooks /pb/pb_hooks

# Expose the PocketBase server port
EXPOSE 8080

# Copy the pb-test script into the container
COPY pb-test.sh /pb/pb-test.sh

# Ensure the pb-test script is executable
RUN chmod +x /pb/pb-test.sh

# Set the entry point to start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]

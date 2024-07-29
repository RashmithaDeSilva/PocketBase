#!/bin/sh

# Start PocketBase in the background
/pb/pocketbase serve --http=0.0.0.0:8080 &

# Wait for PocketBase to start
sleep 5

# Test if PocketBase is responding
if curl -s http://localhost:8080/ > /dev/null; then
    echo "PocketBase is running and responding to HTTP requests."
    exit 0
else
    echo "PocketBase failed to start or respond to HTTP requests."
    exit 1
fi

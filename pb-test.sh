#!/bin/sh

# Wait for PocketBase to start
sleep 10

# Test if PocketBase is responding
if curl -s http://localhost:8910/ > /dev/null; then
    echo "PocketBase is running and responding to HTTP requests."
    exit 0
else
    echo "PocketBase failed to start or respond to HTTP requests."
    exit 1
fi

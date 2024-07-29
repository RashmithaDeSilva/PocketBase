# PocketBase Docker Setup

This repository contains the Docker setup and CI/CD configuration for running PocketBase.

## Overview

The project includes:
- A `Dockerfile` to build a Docker image for PocketBase.
- A test script to ensure PocketBase is running correctly.
- A GitHub Actions workflow for CI/CD.

## Dockerfile

The `Dockerfile` uses the official Alpine base image and sets up PocketBase as follows:

1. **Base Image**: Uses the latest Alpine image.
2. **Build Argument**: Sets the PocketBase version.
3. **Install Packages**: Installs necessary packages (`unzip`, `ca-certificates`, `curl`, and optionally `openssh`).
4. **Download PocketBase**: Fetches and unzips PocketBase.
5. **Expose Port**: Exposes port `8080` for PocketBase.
6. **Copy Test Script**: Copies a test script into the container.
7. **Set Entry Point**: Configures the container to start PocketBase.

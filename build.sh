#!/bin/bash

FLUTTER_VERSION="3.22.1"
FLUTTER_DIR="flutter"

# Download fixed Flutter version if not already installed
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "Downloading Flutter $FLUTTER_VERSION (Linux)..."
  curl -o flutter_sdk.tar.xz "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz"
  tar -xf flutter_sdk.tar.xz
  rm flutter_sdk.tar.xz
else
  echo "Using existing Flutter SDK"
fi

# Enable web
$FLUTTER_DIR/bin/flutter config --enable-web

# Install dependencies
$FLUTTER_DIR/bin/flutter pub get

# Build
$FLUTTER_DIR/bin/flutter clean
$FLUTTER_DIR/bin/flutter build web --release

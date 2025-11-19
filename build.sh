#!/bin/bash

# Install Flutter if missing
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git
else
  cd flutter
  git pull
  cd ..
fi

# Enable Flutter Web
flutter/bin/flutter config --enable-web

# Install packages
flutter/bin/flutter pub get

# Build web release
flutter/bin/flutter build web --release

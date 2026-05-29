#!/bin/sh

BASE_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
WRAPPER_PROPERTIES="$BASE_DIR/.mvn/wrapper/maven-wrapper.properties"

if [ ! -f "$WRAPPER_PROPERTIES" ]; then
  echo "Maven Wrapper properties not found: $WRAPPER_PROPERTIES" >&2
  exit 1
fi

DISTRIBUTION_URL="$(sed -n 's/^distributionUrl=//p' "$WRAPPER_PROPERTIES" | head -n 1)"

if [ -z "$DISTRIBUTION_URL" ]; then
  echo "distributionUrl not found in $WRAPPER_PROPERTIES" >&2
  exit 1
fi

ARCHIVE_NAME="${DISTRIBUTION_URL##*/}"
MAVEN_DIR="${ARCHIVE_NAME%-bin.zip}"
WRAPPER_DIR="$HOME/.m2/wrapper/dists/$MAVEN_DIR"
ARCHIVE_PATH="$WRAPPER_DIR/$ARCHIVE_NAME"
MAVEN_HOME="$WRAPPER_DIR/$MAVEN_DIR"
MAVEN_CMD="$MAVEN_HOME/bin/mvn"

if [ ! -x "$MAVEN_CMD" ]; then
  mkdir -p "$WRAPPER_DIR"

  echo "Downloading Maven from $DISTRIBUTION_URL"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$DISTRIBUTION_URL" -o "$ARCHIVE_PATH"
  elif command -v wget >/dev/null 2>&1; then
    wget -q "$DISTRIBUTION_URL" -O "$ARCHIVE_PATH"
  else
    echo "curl or wget is required to download Maven." >&2
    exit 1
  fi

  echo "Extracting Maven to $WRAPPER_DIR"
  unzip -q -o "$ARCHIVE_PATH" -d "$WRAPPER_DIR"
fi

exec "$MAVEN_CMD" "$@"

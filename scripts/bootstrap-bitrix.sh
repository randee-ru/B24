#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WWW_DIR="$ROOT_DIR/www"
ARCHIVE_URL="https://www.1c-bitrix.ru/download/files/portal/bitrix24_encode.tar.gz"
ARCHIVE_PATH="$WWW_DIR/bitrix24_encode.tar.gz"

if [ -f "$WWW_DIR/bitrix/modules/main/install/wizard/wizard.php" ] || [ -f "$WWW_DIR/index.php" ]; then
  echo "Bitrix24 already looks unpacked in $WWW_DIR"
  exit 0
fi

mkdir -p "$WWW_DIR"

echo "Downloading Bitrix24 archive..."
curl -L "$ARCHIVE_URL" -o "$ARCHIVE_PATH"

echo "Unpacking archive into $WWW_DIR..."
tar -xzf "$ARCHIVE_PATH" -C "$WWW_DIR"

echo "Done."

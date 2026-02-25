#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
PYTHON_BIN="${PYTHON_BIN:-$ROOT_DIR/.venv/bin/python}"
DIST_DIR="$ROOT_DIR/bin"
WORK_DIR="$ROOT_DIR/build"

if [ ! -x "$PYTHON_BIN" ]; then
  printf "Python not found at %s\n" "$PYTHON_BIN" >&2
  printf "Set PYTHON_BIN or create .venv first.\n" >&2
  exit 1
fi

os=$(uname -s 2>/dev/null || printf '%s' "unknown")
arch=$(uname -m 2>/dev/null || printf '%s' "unknown")

case "$os" in
  Linux) os_id="linux" ;;
  Darwin) os_id="darwin" ;;
  MINGW*|MSYS*|CYGWIN*|Windows_NT) os_id="windows" ;;
  *)
    printf "Unsupported OS for local build: %s\n" "$os" >&2
    exit 1
    ;;
esac

case "$arch" in
  x86_64|amd64) arch_id="x86_64" ;;
  arm64|aarch64) arch_id="arm64" ;;
  *)
    printf "Unsupported architecture for local build: %s\n" "$arch" >&2
    exit 1
    ;;
esac

binary_name="cri-${os_id}-${arch_id}"
if [ "$os_id" = "windows" ]; then
  binary_name="${binary_name}.exe"
fi

mkdir -p "$DIST_DIR" "$WORK_DIR"
"$PYTHON_BIN" -m pip install --quiet pyinstaller
"$PYTHON_BIN" -m PyInstaller \
  --onefile \
  --name "$binary_name" \
  --distpath "$DIST_DIR" \
  --workpath "$WORK_DIR" \
  --specpath "$WORK_DIR" \
  "$ROOT_DIR/cri"

printf "Built binary: %s/%s\n" "$DIST_DIR" "$binary_name"

#!/bin/sh
#
# Offline install script for Castrel Proxy
# Usage: cd <directory containing this script and packages/> && sh install.sh
#
# User install (no sudo): CASTREL_INSTALL_DIR=~/.local/bin sh install.sh
# Ensure ~/.local/bin is in your PATH.
#
# Supports: Ubuntu 20+, Debian 10+, CentOS 7+, macOS
# Compatible with: bash 3.x+, dash, ash, busybox sh, zsh
#

set -e

# Hardcoded version (tag includes "v" prefix)
VERSION="v1.0.6"

INSTALL_DIR="${CASTREL_INSTALL_DIR:-/usr/local/bin}"
# Expand ~ to $HOME for user install (e.g. CASTREL_INSTALL_DIR="~/.local/bin")
case "$INSTALL_DIR" in
  "~"/*)  INSTALL_DIR="$HOME/${INSTALL_DIR#\~/}" ;;
  "~")    INSTALL_DIR="$HOME" ;;
esac
BINARY_NAME="castrel-proxy"

# Script directory (where the packages are located)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ── Platform-to-package lookup (POSIX compatible) ───────────────────────────

get_package_path() {
  case "$1" in
    macos-arm64)  echo "packages/castrel-proxy-macos-arm64" ;;
    macos-x86_64) echo "packages/castrel-proxy-macos-x86_64" ;;
    linux-x86_64) echo "packages/castrel-proxy-linux-x86_64" ;;
    linux-arm64)  echo "packages/castrel-proxy-linux-arm64" ;;
    *)            echo "" ;;
  esac
}

get_checksum_path() {
  case "$1" in
    macos-arm64)  echo "packages/castrel-proxy-macos-arm64.sha256" ;;
    macos-x86_64) echo "packages/castrel-proxy-macos-x86_64.sha256" ;;
    linux-x86_64) echo "packages/castrel-proxy-linux-x86_64.sha256" ;;
    linux-arm64)  echo "packages/castrel-proxy-linux-arm64.sha256" ;;
    *)            echo "" ;;
  esac
}

# ── Colored output helpers (use printf for portability) ──────────────────────

if [ -t 1 ]; then
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  NC='\033[0m'
else
  RED='' GREEN='' YELLOW='' NC=''
fi

die() {
  printf "${RED}Error: %s${NC}\n" "$1" >&2
  exit 1
}

log() {
  printf "${GREEN}%s${NC}\n" "$1"
}

warn() {
  printf "${YELLOW}%s${NC}\n" "$1"
}

# ── SHA256 checksum (try multiple tools) ─────────────────────────────────────

compute_sha256() {
  _file="$1"
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$_file" | awk '{print $1}'
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$_file" | awk '{print $1}'
  elif command -v openssl >/dev/null 2>&1; then
    openssl dgst -sha256 "$_file" | awk '{print $NF}'
  else
    die "No SHA256 tool found (sha256sum, shasum, or openssl required)."
  fi
}

# ── Detect OS and architecture ───────────────────────────────────────────────

detect_platform() {
  _os=""
  _arch=""

  case "$(uname -s)" in
    Darwin) _os="macos" ;;
    Linux)  _os="linux" ;;
    *)      die "Unsupported OS: $(uname -s)" ;;
  esac

  case "$(uname -m)" in
    x86_64|amd64)   _arch="x86_64" ;;
    aarch64|arm64)   _arch="arm64" ;;
    *)               die "Unsupported architecture: $(uname -m)" ;;
  esac

  echo "${_os}-${_arch}"
}

# ── Main ─────────────────────────────────────────────────────────────────────

main() {
  log "Castrel Proxy - Offline installer"
  echo ""

  # Hardcoded version
  tag="${VERSION}"
  log "Version: $tag"

  platform=$(detect_platform)
  log "Detected platform: $platform"

  # Resolve local package path
  pkg_relative=$(get_package_path "$platform")
  sha_relative=$(get_checksum_path "$platform")

  [ -z "$pkg_relative" ] && die "No package configured for platform: $platform"

  pkg_path="${SCRIPT_DIR}/${pkg_relative}"
  sha_path="${SCRIPT_DIR}/${sha_relative}"

  [ -f "$pkg_path" ] || die "Package file not found: $pkg_path"
  [ -f "$sha_path" ] || die "Checksum file not found: $sha_path"

  pkg_name=$(basename "$pkg_path")
  log "Installing ${pkg_name} from local packages..."

  # Verify checksum
  expected_hash=$(awk '{print $1}' "$sha_path")
  actual_hash=$(compute_sha256 "$pkg_path")

  if [ "$expected_hash" != "$actual_hash" ]; then
    die "SHA256 verification failed. Expected: $expected_hash, got: $actual_hash"
  fi
  log "SHA256 checksum verified."

  # Install to target directory (create if needed for user install)
  target_path="${INSTALL_DIR}/${BINARY_NAME}"
  if [ ! -d "$INSTALL_DIR" ]; then
    if mkdir -p "$INSTALL_DIR" 2>/dev/null; then
      :
    elif command -v sudo >/dev/null 2>&1; then
      sudo mkdir -p "$INSTALL_DIR" || die "Cannot create ${INSTALL_DIR}"
    else
      die "Directory ${INSTALL_DIR} does not exist and cannot be created."
    fi
  fi

  if [ -w "$INSTALL_DIR" ]; then
    cp "$pkg_path" "$target_path"
  else
    warn "Need sudo to install to ${INSTALL_DIR}"
    if command -v sudo >/dev/null 2>&1; then
      sudo cp "$pkg_path" "$target_path"
    else
      die "Cannot write to ${INSTALL_DIR} and sudo is not available."
    fi
  fi

  chmod +x "$target_path" 2>/dev/null || sudo chmod +x "$target_path"

  log "Installed successfully to $target_path"
  echo ""
  echo "Run: castrel-proxy --help"
  echo ""
}

main "$@"

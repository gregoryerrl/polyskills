#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOK_NAME="${1:?Usage: run-hook.cmd <hook-name>}"
HOOK_FILE="${SCRIPT_DIR}/${HOOK_NAME}"

if [ -f "${HOOK_FILE}" ]; then
  exec bash "${HOOK_FILE}"
else
  echo "Hook not found: ${HOOK_FILE}" >&2
  exit 1
fi

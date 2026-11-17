#!/usr/bin/env bash
set -euo pipefail
cat_project_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$cat_project_root/exports"
"$cat_project_root/tools/run.sh" --headless --export-debug "Android ARM64"
"$cat_project_root/tools/run.sh" --headless --export-debug "Android Universel"

#!/usr/bin/env bash
set -euo pipefail
cat_project_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cat_runtime_dir="${CAT_RUNTIME_DIR:-$cat_project_root/.local-runtime}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$cat_runtime_dir/cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$cat_runtime_dir/config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$cat_runtime_dir/data}"
mkdir -p "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME"
exec godot --path "$cat_project_root" "$@"

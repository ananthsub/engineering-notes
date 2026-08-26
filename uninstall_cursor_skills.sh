#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source_dir="$repo_dir/.cursor/skills"
target_dir="$HOME/.cursor/skills"
skills=(
  upload-public-html
  pr-html-concise-public
  pr-html-public
)

for skill in "${skills[@]}"; do
  source_path="$source_dir/$skill"
  target_path="$target_dir/$skill"

  if [[ ! -L "$target_path" ]]; then
    echo "Skipped: $skill is not an installed symlink"
    continue
  fi

  if [[ "$(readlink -f "$target_path")" != "$(readlink -f "$source_path")" ]]; then
    echo "Skipped: $target_path belongs to another installation" >&2
    continue
  fi

  rm "$target_path"
  echo "Removed: $skill"
done

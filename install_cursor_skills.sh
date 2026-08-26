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

mkdir -p "$target_dir"

for skill in "${skills[@]}"; do
  source_path="$source_dir/$skill"
  target_path="$target_dir/$skill"

  if [[ -L "$target_path" ]]; then
    if [[ "$(readlink -f "$target_path")" == "$(readlink -f "$source_path")" ]]; then
      echo "Already installed: $skill"
      continue
    fi
    echo "Refusing to replace a symlink owned by another installation: $target_path" >&2
    exit 1
  fi

  if [[ -e "$target_path" ]]; then
    echo "Refusing to replace an existing skill: $target_path" >&2
    exit 1
  fi

  ln -s "$source_path" "$target_path"
  echo "Installed: $skill"
done

echo "Restart Cursor or reload the window to discover the skills."

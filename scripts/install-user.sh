#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
home_dir="${HOME:?HOME must be set}"
targets=("$home_dir/.agents/skills/floop")

if [[ $# -gt 1 ]]; then
    printf 'Usage: %s [--claude]\n' "$0" >&2
    exit 64
fi
if [[ $# -eq 1 && "$1" != "--claude" ]]; then
    printf 'Usage: %s [--claude]\n' "$0" >&2
    exit 64
fi
if [[ ! -f "$repo_root/skills/floop/SKILL.md" ]]; then
    printf 'Skill source not found: %s\n' "$repo_root/skills/floop" >&2
    exit 1
fi
if [[ $# -eq 1 ]]; then
    targets+=("$home_dir/.claude/skills/floop")
fi

preflight_target() {
    local target="$1"
    local parent
    parent="$(dirname "$target")"

    if [[ -e "$parent" && ! -d "$parent" ]]; then
        printf 'Refusing to use a non-directory parent path: %s\n' "$parent" >&2
        exit 1
    fi
    if [[ -L "$target" ]]; then
        if [[ "$(readlink "$target")" == "$repo_root/skills/floop" ]]; then
            return
        fi
        printf 'Refusing to replace an existing symlink: %s\n' "$target" >&2
        exit 1
    fi
    if [[ -e "$target" ]]; then
        printf 'Refusing to replace an existing file or directory: %s\n' "$target" >&2
        exit 1
    fi
}

link_once() {
    local source="$1"
    local target="$2"
    mkdir -p "$(dirname "$target")"

    if [[ -L "$target" ]]; then
        if [[ "$(readlink "$target")" == "$source" ]]; then
            printf 'Already linked: %s\n' "$target"
            return
        fi
        printf 'Refusing to replace an existing symlink: %s\n' "$target" >&2
        exit 1
    fi
    if [[ -e "$target" ]]; then
        printf 'Refusing to replace an existing file or directory: %s\n' "$target" >&2
        exit 1
    fi

    ln -s "$source" "$target"
    printf 'Linked %s -> %s\n' "$target" "$source"
}

for target in "${targets[@]}"; do
    preflight_target "$target"
done

for target in "${targets[@]}"; do
    link_once "$repo_root/skills/floop" "$target"
done

printf 'Start a new agent session to load the floop skill.\n'

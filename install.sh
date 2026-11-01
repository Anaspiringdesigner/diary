#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bin_dir="${HOME}/.local/bin"

chmod +x "${project_dir}/diary"
mkdir -p "${bin_dir}"
ln -sfn "${project_dir}/diary" "${bin_dir}/diary"

printf 'Linked %s -> %s\n' "${bin_dir}/diary" "${project_dir}/diary"

if [[ ":${PATH}:" != *":${bin_dir}:"* ]]; then
  printf '\nNote: %s is not on your PATH. Add this to your shell profile:\n' "${bin_dir}"
  printf '  export PATH="%s:$PATH"\n' "${bin_dir}"
fi

if ! command -v tectonic >/dev/null 2>&1 && [[ ! -x "${bin_dir}/tectonic" ]]; then
  cat <<'EOF'

Tectonic is not installed. The diary needs it to make PDFs.
Install it with `paru -S tectonic`, or see README.md for a direct download.
EOF
fi

printf '\nTry: diary "The first line."\n'

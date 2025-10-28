#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../ansible"

if grep -q "^\[lb\]" inventory.ini; then
  ansible-playbook app.yml
  ansible-playbook lb.yml
elif grep -q "^\[app\]" inventory.ini; then
  ansible-playbook app.yml
else
  ansible-playbook site.yml
fi

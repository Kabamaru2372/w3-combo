#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

pushd "$ROOT_DIR/terraform" >/dev/null
terraform destroy -auto-approve
popd >/dev/null

rm -f "$ROOT_DIR/ansible/inventory.ini"
echo "[i] Teardown complete and inventory removed."

# file: ~/bin/run-with-port

#!/usr/bin/env bash
# Usage: sudo run-with-port <port> <cmd> <args...>

# sourced from https://discourse.nixos.org/t/how-to-temporarily-open-a-tcp-port-in-nixos/12306/2

set -ueo pipefail

openport() {
  local port=$1
  iptables -A INPUT -p tcp --dport $port -j ACCEPT
}

closeport() {
  local port=${1:-0}
  iptables -D INPUT -p tcp --dport $port -j ACCEPT
}


if [[ -z "$1" ]]; then
  echo "Port not given" >&2
  exit 1
fi

PORT=$1
shift;  # Drop port argument

if [[ 0 -eq $# ]]; then
  echo "No command given" >&2
  exit 1
fi

openport $PORT

# Ensure port closes if error occurs.
trap "closeport $PORT" EXIT

# Run the command as user, not root.
runuser -u $SUDO_USER -- "$@"

# Trap will close port.

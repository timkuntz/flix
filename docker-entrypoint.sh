#!/bin/sh
set -e

# cleanup when rails doesn't
if test -f tmp/pids/server.pid; then
  rm tmp/pids/server.pid
fi

exec "$@"


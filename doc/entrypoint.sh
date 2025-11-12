#!/usr/bin/env bash
set -euo pipefail

# Get user UID, name, and group GID from env vars or defaults
USER_ID=${USER_ID:-1000}
USER_GID=${USER_GID:-1000}
USER_NAME=${USER_NAME:-builder}

# Get the existing group GID by name if it exists, else create it
if getent group "${USER_GID}" >/dev/null; then
  GROUP_NAME=$(getent group "${USER_GID}" | cut -d: -f1)
else
  groupadd -g "${USER_GID}" "${USER_NAME}"
  GROUP_NAME="${USER_NAME}"
fi

# Get the existing user name based on the UID, else create a new user
if id -u "${USER_ID}" >/dev/null 2>&1; then
  EXISTING_NAME=$(getent passwd "${USER_ID}" | cut -d: -f1)
  USER_NAME="${EXISTING_NAME}"
else
  useradd -u "${USER_ID}" -g "${USER_GID}" -m -s /bin/bash "${USER_NAME}"
fi

# Ensure home and workspace directories exist (simplified)
HOME_DIR=$(getent passwd "${USER_NAME}" | cut -d: -f6)
: "${HOME_DIR:=/home/${USER_NAME}}"

mkdir -p "${HOME_DIR}" /workspace "${HOME_DIR}/workspace"

# Set directory ownership (non-recursive for speed)
chown "${USER_ID}:${USER_GID}" "${HOME_DIR}" || true
chown "${USER_ID}:${USER_GID}" "${HOME_DIR}/workspace" || true
chown "${USER_ID}:${USER_GID}" /workspace || true

# Set environment for the user
export HOME="${HOME_DIR}"
export USER="${USER_NAME}"

# Configure git identity if none exists
# This has to be done after the home directory is created because git stores data there
if [ ! -f "${HOME}/.gitconfig" ]; then
  GIT_NAME=${GIT_NAME:-Isolated Builder}
  GIT_EMAIL=${GIT_EMAIL:-builder@example.com}
  gosu "${USER_NAME}" git config --global user.name "${GIT_NAME}"
  gosu "${USER_NAME}" git config --global user.email "${GIT_EMAIL}"
fi

cd "${HOME}/workspace"

# Drop privileges and execute the command
exec gosu "${USER_NAME}" "$@"

#!/bin/bash

TRASH_DIRECTORY="${BLOCK_INSTANCE}"

if [[ "${TRASH_DIRECTORY}" = "" ]]; then
  TRASH_DIRECTORY="${XDG_DATA_HOME:-${HOME}/.local/share}/Trash"
fi

TRASH_COUNT=$(ls -U -1 "${TRASH_DIRECTORY}/files" | wc -l)

URGENT_VALUE=30

echo "${TRASH_COUNT}"
echo "${TRASH_COUNT}"
echo ""

if [[ "${TRASH_COUNT}" -ge "${URGENT_VALUE}" ]]; then
  exit 31
fi

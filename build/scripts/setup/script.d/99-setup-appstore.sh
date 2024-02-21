#!/bin/bash

set -e 

DEFAULT_APPSTORE_PATH="/var/lib/casaos/appstore/default"

if [ -d "${DEFAULT_APPSTORE_PATH}" ]; then
    echo "🟩 Backup existing default appstore..."
    mv -f "${DEFAULT_APPSTORE_PATH}" "${DEFAULT_APPSTORE_PATH}.old" || {
        echo "🟥 Failed to backup existing default appstore"
        exit 1
    }
fi

echo "🟩 Updating default appstore..."

if [ -d "${DEFAULT_APPSTORE_PATH}.new" ]; then
    mv -vf "${DEFAULT_APPSTORE_PATH}.new" "${DEFAULT_APPSTORE_PATH}" || {
        echo "🟥 Failed to update default appstore... restoring backup..."
        rm -vf "${DEFAULT_APPSTORE_PATH}"
        mv -vf "${DEFAULT_APPSTORE_PATH}.old" "${DEFAULT_APPSTORE_PATH}"
        rm -rvf "${DEFAULT_APPSTORE_PATH}.new"
        exit 1
    }
    rm -rvf "${DEFAULT_APPSTORE_PATH}.old" || {
        echo "🟨 Failed to remove old default appstore backup"
    }
else
    echo "🟨 New default appstore does not exist"
fi

echo "✅ setup-appstore.sh finished."
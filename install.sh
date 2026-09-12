#!/bin/sh
# install.sh — instala os scripts do dumpkg no sistema

SCRIPTS_DIR="./scripts"

if [ "$(id -u)" -ne 0 ]; then
    echo "error: you need to be root to install dumpkg."
    exit 1
fi

echo "installing dumpkg..."

# cria o diretório do dumpkg-common
mkdir -p /usr/share/dumpkg

# instala os comandos em /usr/bin
for cmd in dumpkg dumpkg-init dumpkg-install dumpkg-remove dumpkg-update; do
    src="$SCRIPTS_DIR/$cmd"
    if [ ! -f "$src" ]; then
        echo "error: '$src' not found. are you running this from the project root?"
        exit 1
    fi
    cp "$src" "/usr/bin/$cmd"
    chmod 755 "/usr/bin/$cmd"
done

# instala o dumpkg-common em /usr/share/dumpkg
cp "$SCRIPTS_DIR/dumpkg-common" /usr/share/dumpkg/dumpkg-common
chmod 644 /usr/share/dumpkg/dumpkg-common

echo "done. run 'dumpkg-init' to set things up."

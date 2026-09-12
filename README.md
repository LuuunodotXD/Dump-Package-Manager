# dumpkg

A minimal binary package manager for musl + busybox systems, written in POSIX shell.  
Works through recipes (`.binfile`), with no dependency resolution — deps are listed for reference only.

## dependencies

- `sh`, `tar`, `grep`, `cut`, `sed`, `sort`, `awk`, `mkdir`, `rm`, `cp`, `date`, `id`, `kill` — all standard busybox
- `wget` or `curl` — for downloading
- `md5sum` / `sha256sum` — if checksum is enabled (busybox includes both)

## installation

```sh
git clone https://github.com/LuuunodotXD/Dump-Package-Manager.git
cd Dump-Package-Manager
sh install.sh
dumpkg-init
```

## configuration

`/etc/dumpkg/dumpkg.conf`:

```sh
recipes_url=https://example.com/recipes.tar.gz
checksum=md5        # none, md5, sha256
downloader=wget     # wget, curl
```

## commands

```sh
dumpkg list                      # list installed packages
dumpkg list --upgradable         # list packages with updates available
dumpkg search <pkg>              # search recipes by name (substring)
dumpkg info <pkg>                # show local info for an installed package
dumpkg deps <pkg>                # list dependencies of a package
dumpkg files <pkg>               # list files owned by a package
dumpkg verify <pkg>              # check if all package files are present
dumpkg clean                     # remove leftover temp files and stale locks

dumpkg-install <pkg> [pkg...]    # install one or more packages
dumpkg-install -r <pkg> [pkg...] # reinstall (--reinstall)

dumpkg-remove <pkg> [pkg...]     # remove one or more packages

dumpkg-update                    # sync recipes and upgrade all packages
dumpkg-update <pkg>              # sync recipes and upgrade a specific package
dumpkg-update -u                 # sync recipes only (--up-to-date)
dumpkg-update -U                 # upgrade all packages without syncing (--upgrade)
dumpkg-update -U <pkg>           # upgrade a specific package without syncing

dumpkg-init                      # set up or reset dumpkg's directory structure
```

## binfile format

Recipes live in `/usr/dumpkg/recipes/` as `<name>.binfile`:

```sh
name=curl
version=8.11.0
description=A command-line tool for transferring data with URLs
url=https://example.com/packages/curl-8.11.0.tar.gz
compression=gzip        # gzip, bzip2, xz — default is gzip
md5=d41d8cd98f00b204e9800998ecf8427e
sha256=e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
deps=zlib openssl ca-certificates
postinstall=ldconfig
conffiles=/etc/curl/curlrc
```

The package tarball should extract directly to `/` (e.g., `usr/bin/curl`, not `/usr/bin/curl`).

## file structure

```
/usr/bin/dumpkg
/usr/bin/dumpkg-init
/usr/bin/dumpkg-install
/usr/bin/dumpkg-remove
/usr/bin/dumpkg-update
/usr/share/dumpkg/dumpkg-common

/usr/dumpkg/recipes/<name>.binfile
/usr/dumpkg/installed/<name>.manifest
/usr/dumpkg/files/<name>.files

/etc/dumpkg/dumpkg.conf
/etc/dumpkg/info-dumpkg
/var/log/dumpkg.log
```
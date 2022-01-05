#!/usr/bin/env bash
SSHFS_PATH="$(command -v sshfs)"

if ! [ "$SSHFS_PATH" ]; then
  echo "ERROR: Can't install rsshfs, sshfs is not installed" >&2
  exit 1
fi

# install to the same dir as sshfs, /usr/loca/bin typically
install_destination="$(dirname "$SSHFS_PATH")"

# download latest version from github
tmpfile="$(mktemp)"
curl -Lo "$tmpfile" https://github.com/rikhoffbauer/rsshfs/archive/refs/heads/master.zip
unzip -: -j "$tmpfile" rsshfs-master/rsshfs -d "/usr/local/bin"

# make executable
chmod +x "$install_destination/rsshfs"

# clean up
rm -f "$tmpfile"

echo "rsshfs installed to $install_destination" >&2

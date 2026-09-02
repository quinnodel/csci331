#!/bin/sh
# deploy.sh — publish the current assignment on csci331vm.
#
# Run this ON THE SERVER (or from home over ssh, see SETUP.md):
#
#     ~/csci331/bin/deploy.sh                 # deploys whatever CURRENT names
#     ~/csci331/bin/deploy.sh assignments/03-styling-images
#
# What it does:
#   1. git pull --ff-only in the repo clone (fails loudly if the server copy
#      was edited by hand — that is the point; never edit on the server).
#   2. Empties ~/public_html and copies the chosen assignment directory into
#      it, so the work is live at http://csci331vm.cs.montana.edu/<netid>/
#   3. Fixes permissions (and SELinux context, if the box has it) so Apache
#      can read the files.
#
# The repo clone itself stays OUTSIDE public_html so .git is never served
# over HTTP. BRIEF.md is skipped — it is a course note, not part of the site.
#
# Env overrides: DOCROOT=... (default ~/public_html), SKIP_PULL=1

set -eu

main() {
    repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
    docroot=${DOCROOT:-$HOME/public_html}
    marker=.deployed-by-csci331

    # --- pull first, so a pushed CURRENT/assignment is what gets deployed ---
    if [ "${SKIP_PULL:-0}" != "1" ]; then
        echo "==> git pull --ff-only ($repo)"
        git -C "$repo" pull --ff-only
    fi

    # --- which assignment ------------------------------------------------
    if [ $# -ge 1 ]; then
        current=$1
    elif [ -f "$repo/CURRENT" ]; then
        current=$(sed -e 's/#.*//' -e 's/[[:space:]]//g' "$repo/CURRENT" | grep -v '^$' | head -n 1)
    else
        echo "deploy: no CURRENT file in $repo and no path given" >&2
        exit 1
    fi
    current=${current%/}
    src=$repo/$current
    if [ ! -d "$src" ]; then
        echo "deploy: not a directory: $src" >&2
        exit 1
    fi

    # --- refuse to wipe a docroot we did not create -----------------------
    if [ -d "$docroot" ] && [ ! -f "$docroot/$marker" ]; then
        if [ -n "$(ls -A "$docroot" 2>/dev/null)" ]; then
            echo "deploy: $docroot has files this script did not put there." >&2
            echo "        Move them aside, or run:  touch $docroot/$marker  to hand it over." >&2
            exit 1
        fi
    fi
    mkdir -p "$docroot"

    # --- publish ----------------------------------------------------------
    echo "==> publishing $current -> $docroot"
    find "$docroot" -mindepth 1 -maxdepth 1 ! -name "$marker" -exec rm -rf -- {} +
    cp -R "$src/." "$docroot/"
    rm -f "$docroot/BRIEF.md"
    touch "$docroot/$marker"

    # --- make it readable by Apache ---------------------------------------
    # UserDir needs: home traversable (711 keeps it unlistable), docroot 755,
    # files world-readable.
    chmod 711 "$HOME"
    chmod 755 "$docroot"
    chmod -R a+rX "$docroot"
    if command -v restorecon >/dev/null 2>&1; then
        restorecon -R "$docroot" >/dev/null 2>&1 || true
    fi

    echo "==> done. Check: http://csci331vm.cs.montana.edu/$(id -un)/"
}

# Single line on purpose: if the pull above replaces this very file, the
# shell must not read any further bytes from it.
main "$@"; exit

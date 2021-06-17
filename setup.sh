#!/bin/bash

echo "=> Checking ddev project"
if [ ! -d ".ddev" ]; then
  echo "[!] This does not appear to be a ddev project."
  echo "    Please run 'ddev config' and then re-run this script."
  exit 1
fi

echo "=> Checking to make sure mutagen is installed"
if ! type "mutagen" > /dev/null 2>&1; then
  echo "  => mutagen is not installed. running 'brew install mutagen-io/mutagen/mutagen'"
  echo "     If you do not want to do this, press Ctrl+C in the next 5 seconds"
  sleep 5
  brew install mutagen-io/mutagen/mutagen
fi

echo "=> Setting up mutagen sync script in the current ddev project"
echo "  => Downloading mutagen hook script from:"
echo "     https://raw.githubusercontent.com/williamengbjerg/ddev-mutagen/master/mutagen"
[ -d ".ddev/commands/host" ] || mkdir -p .ddev/commands/host

if [ -f ".ddev/commands/host/mutagen" ]; then
    rm -rf .ddev/commands/host/mutagen
fi
if [ -f ".ddev/config.mutagen.yaml" ]; then
    rm -rf .ddev/config.mutagen.yaml
fi

curl -s https://raw.githubusercontent.com/williamengbjerg/ddev-mutagen/master/config.mutagen.yaml > .ddev/config.mutagen.yaml
curl -s https://raw.githubusercontent.com/williamengbjerg/ddev-mutagen/master/mutagen > .ddev/commands/host/mutagen
mkdir -p .ddev/project-stopped
chmod +x .ddev/commands/host/mutagen

echo
echo "All set! Run 'ddev start' to start using mutagen."
echo

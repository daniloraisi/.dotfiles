#!/usr/bin/env bash

TMPDIR=$(mktemp -d)

CURRENT=$PWD

cd $TMPDIR

for script in ~/.dotfiles/scripts/*; do
	bash "$script" & disown
done

cd $CURRENT

rm -rf $TMPDIr

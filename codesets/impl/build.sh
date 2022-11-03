#!/bin/sh
set -eu
cd "$(dirname "$0")"
echo "Entering directory '$PWD'"
set -x
rm -f codesets.o*
gsi-script generate.scm
gsc-script codesets.sld
gsi-script . demo.scm

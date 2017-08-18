#!/bin/bash

set -e
set -o pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd $script_dir

if [ "$(uname)" == "Darwin" ]
then
  # MacOS
  $script_dir/../Build-qt.sh \
  -c \
  -j 2 \
  -y \
  -s macosx10.11 \
  -a x86_64 \
  -d 10.9
else
  $script_dir/../Build-qt.sh \
  -c \
  -j 2 \
  -y
fi

die() {
  echo "Error: $@" 1>&2
  exit 1;
}

expected_qt_version="5.9.1"

./qt-everywhere-opensource-build-$expected_qt_version/bin/qmake --version | grep "Using Qt version $expected_qt_version" || die "Could not run Qt $expected_qt_version"

popd


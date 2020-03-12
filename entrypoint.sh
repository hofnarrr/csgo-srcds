#!/bin/bash -xe

if [[ -d /srcds-overlay ]]; then
  cp -vfr /srcds-overlay/* $SRCDS
fi

exec $SRCDS/srcds_run $@

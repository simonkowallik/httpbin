#!/usr/bin/env bash
set +ev

# only run when TRAVIS_EVENT_TYPE == cron
if [[ "$TRAVIS_EVENT_TYPE" != "cron" ]]
then
  exit 0
fi

# jobs
cat ./dh_tgb | bash
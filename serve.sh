#!/usr/bin/env sh
(bundle exec jekyll serve) | while read line; do
  echo $line
  [[ $line =~ "Server running" ]] && start chrome 127.0.0.1:4000
done

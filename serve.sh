#!/usr/bin/env sh
(jekyll serve) | while read line; do
  echo $line
  [[ $line =~ "Server running" ]] && start chrome 127.0.0.1:4000
done

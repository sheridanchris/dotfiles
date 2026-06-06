#!/usr/bin/env bash
input="$*"

if [ -z "$input" ]; then
  echo "Usage: open-url <url or search terms>"
  exit 1
fi

if [[ "$input" =~ ^www\. ]]; then
  url="https://$input"
elif [[ "$input" =~ ^https?:// ]]; then
  url="$input"
else
  url="https://duckduckgo.com/?q=$input"
fi

xdg-open "$url"
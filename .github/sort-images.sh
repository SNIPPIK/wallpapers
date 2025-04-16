#!/bin/bash
declare -A unique_images
output=""
count=0

function fixLinks() {
  echo "https://github.com/SNIPPIK/wallpapers/blob/main/$1?raw=true" | sed 's/ /%20/g' | sed 's/\[/%5B/g' | sed 's/\]/%5D/g'
}

function foo() {
  while IFS= read -r file; do
      if [[ -n "$file" && -f "$file" ]]; then
          if [[ -z "${unique_images[$file]}" ]]; then
              unique_images["$file"]=1
              output+="| ![image]($(fixLinks "$file")) "
              ((count++))

              if (( count == 4 )); then
                  output+="|"
                  echo "$output"
                  output=""
                  count=0
              fi
          fi
      else
          echo "$file"
      fi
  done
  if [[ -n "$output" ]]; then
      output+="|"
      echo "$output"
  fi
}

find -L . -type f \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' -o -name '*.gif' -o -name '*.webp' -o -name '*.tiff' \) -printf "%P\n" | sort | foo
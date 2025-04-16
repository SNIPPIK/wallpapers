#!/bin/bash

cd ..

declare -A unique_images
output=""
count=0

function fixLinks() {
  echo "https://github.com/SNIPPIK/wallpapers/blob/main/$1?raw=true" | sed 's/ /%20/g' | sed 's/\[/%5B/g' | sed 's/\]/%5D/g'
}

function foo() {
  # \u0427\u0438\u0442\u0430\u0435\u043c \u0441\u043f\u0438\u0441\u043e\u043a \u0444\u0430\u0439\u043b\u043e\u0432 \u0438\u0437\u043e\u0431\u0440\u0430\u0436\u0435\u043d\u0438\u0439 \u0438\u0437 \u0441\u0442\u0430\u043d\u0434\u0430\u0440\u0442\u043d\u043e\u0433\u043e \u0432\u0432\u043e\u0434\u0430
  while IFS= read -r file; do
      # \u0412\u044b\u0432\u043e\u0434\u0438\u043c \u043e\u0442\u043b\u0430\u0434\u043e\u0447\u043d\u0443\u044e \u0438\u043d\u0444\u043e\u0440\u043c\u0430\u0446\u0438\u044e
      #echo "$file"  # \u041e\u0442\u043b\u0430\u0434\u043e\u0447\u043d\u0430\u044f \u0441\u0442\u0440\u043e\u043a\u0430

      # \u041f\u0440\u043e\u0432\u0435\u0440\u044f\u0435\u043c, \u0447\u0442\u043e \u0441\u0442\u0440\u043e\u043a\u0430 \u043d\u0435 \u043f\u0443\u0441\u0442\u0430\u044f \u0438 \u0444\u0430\u0439\u043b \u0441\u0443\u0449\u0435\u0441\u0442\u0432\u0443\u0435\u0442
      if [[ -n "$file" && -f "$file" ]]; then
          # \u041f\u0440\u043e\u0432\u0435\u0440\u044f\u0435\u043c, \u0443\u043d\u0438\u043a\u0430\u043b\u0435\u043d \u043b\u0438 \u0444\u0430\u0439\u043b
          if [[ -z "${unique_images[$file]}" ]]; then
              unique_images["$file"]=1
              output+="| ![image]($(fixLinks "$file")) "
              ((count++))

              # \u0415\u0441\u043b\u0438 \u0434\u043e\u0431\u0430\u0432\u043b\u0435\u043d\u043e 4 \u0438\u0437\u043e\u0431\u0440\u0430\u0436\u0435\u043d\u0438\u044f, \u0432\u044b\u0432\u043e\u0434\u0438\u043c \u0441\u0442\u0440\u043e\u043a\u0443 \u0438 \u0441\u0431\u0440\u0430\u0441\u044b\u0432\u0430\u0435\u043c \u0441\u0447\u0435\u0442\u0447\u0438\u043a
              if (( count == 4 )); then
                  output+="|"
                  echo "$output"
                  output=""
                  count=0
              fi
          fi
      else
          echo "$file"  # \u041e\u0442\u043b\u0430\u0434\u043e\u0447\u043d\u0430\u044f \u0441\u0442\u0440\u043e\u043a\u0430
      fi
  done

  # \u0412\u044b\u0432\u043e\u0434\u0438\u043c \u043e\u0441\u0442\u0430\u0432\u0448\u0438\u0435\u0441\u044f \u0438\u0437\u043e\u0431\u0440\u0430\u0436\u0435\u043d\u0438\u044f, \u0435\u0441\u043b\u0438 \u043e\u043d\u0438 \u0435\u0441\u0442\u044c
  if [[ -n "$output" ]]; then
      output+="|"
      echo "$output"
  fi
}

find -L . -type f \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' -o -name '*.gif' -o -name '*.webp' -o -name '*.tiff' \) -printf "%P\n" | sort | foo
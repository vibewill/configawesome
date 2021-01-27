#!/bin/bash


for f in $(find -name "*.svg"); do
  sed -i 's/#dfdfdf/#f57900/g' "$f"
done

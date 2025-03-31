#!/bin/bash

main() {
  local out_file
  out_file=source.zip

  zip -9 -r -v "$out_file" './source/'

  sha512sum "$out_file"
}

main || exit 1

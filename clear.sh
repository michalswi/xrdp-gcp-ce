#!/usr/bin/env bash

set -e

list=".terraform* terraform* ./id_rsa*"

for i in $list; do
  echo $i
  rm -rf $i
done 

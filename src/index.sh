#!/usr/bin/env bash
echo Indexing...
ruby init_index.rb
echo Start indexing!!

for file in ../dump/*; do
	echo Index $file
	ruby index.rb $file
done
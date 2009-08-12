#!/usr/bin/env bash
for dir in ../data/*; do
	for file in $dir/*; do
		echo Serialize $file
		ruby serialize.rb $file
	done
done
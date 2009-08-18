#!/usr/bin/env bash
echo Initialize db...
ruby init_db.rb
echo Start statistic!!

for file in ../dump/*; do
	echo Statistics $file
	ruby statistics.rb $file
done
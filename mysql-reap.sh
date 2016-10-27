#!/bin/bash

EXPECTED_ARGS=3
if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: ./`basename $0` host user pass"
  echo "Redirect this output somewhere, its goina be YUUUUUUUGE"
  exit 1
fi


host=$1
user=$2
pass=$3

for d in $(mysql -B -h $host -u $user --password=$pass -e "show databases" 2> /dev/null | grep -Ev '^Database|^information_schema|^mysql|^performance_schema|^sys'); 
do echo "[*] Database: $d";
	for t in $(mysql -B -h $host -u $user --password=$pass -e "show tables in $d" 2> /dev/null);
	do echo "[*] Database: $d - Table: $t"; 
	mysql -h $host -u $user --password=$pass -e "use $d; select * from $t limit 10" 2> /dev/null;
	done
done

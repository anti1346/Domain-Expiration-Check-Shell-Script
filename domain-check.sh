#!/bin/bash

domainchk(){
	echo "---------------------------------------------------------------------"
	printf "| %10s | %20s | %-13s | %-10s |\n" "Condition" "Domain" "Expire (days)"  "Expire (date)"
	echo "====================================================================="
	while read DOMAIN_LIST
		do
		./check-domain-expiration.py $DOMAIN_LIST
		echo "---------------------------------------------------------------------"
	done < domain_list.txt
}

### call function
#domainchk

### html
echo "<html>" > result.html
echo "<head>" > result.html
echo "<meta http-equiv="Content-Type" content="text/html\; charset=utf-8" />" > result.html
echo "</head>" > result.html
echo "<body>" >> result.html
echo "<pre>" >> result.html
echo "<font face="Monaco">" >> result.html
domainchk >> result.html
echo "</font>" >> result.html
echo "</pre>" >> result.html
echo "</body>" >> result.html
echo "</html>" >> result.html

### mail sender
cat .mail_header result.html | sendmail -t

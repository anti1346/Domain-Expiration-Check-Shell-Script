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
echo "<body>" >> result.html
echo "<pre>" >> result.html
echo "<font face="Monaco">" >> result.html
domainchk >> result.html
echo "</font>" >> result.html
echo "</pre>" >> result.html
echo "</body>" >> result.html
echo "</html>" >> result.html

cat <<EOF > .mailheader
From: 1234@abc.com
To: 1234@abc.com
Subject: 도메인 만료일 안내
Content-Type: text/html
EOF

### mail sender
cat .mailheader result.html | sendmail -t
#cat result.html | mail -v -s "도메인 만료일 안내" 1234@abc.com


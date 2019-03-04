#!/bin/bash

_execute_directory='/app/script/Domain-Expiration-Check-Shell-Script'
cd $_execute_directory

domainchk(){
	while read DOMAIN_LIST
		do
		./check-domain-expiration.py $DOMAIN_LIST
	done < domain_list.txt
}

### call function
#domainchk

### html
cat <<EOF > result.html
<html>
<head>
<meta http-equiv="Content-Type" content="text/html\; charset=utf-8" />
<style>
  table {
    width: 80%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    font-family: Monaco;
    font-size:90%;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
    text-align: center;
  }
  th {
    background-color: #e3f2fd;
  }
  td {
    background-color: #FFFFFF;
  }
</style>
</head>
<body>
<font face="Monaco">
<table border="1px">
        <thead>
                <tr><th>Condition</th><th>Domain</th><th>Expired Days</th><th>Expiration Date</th></tr>
        </thead>
        <tbody>
EOF

domainchk >> result.html

cat <<EOF >> result.html
        </tbody>
</table>
</font>
</body>
</html>
EOF

### mail sender
_Day=`date +%a`

if [ "$_Day" = "Mon" ] ; then
	cat .mail_header result.html | sudo sendmail -t
fi

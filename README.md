아래 python 스크립트로 재작성하였습니다.

https://github.com/averi/python-scripts/blob/master/check-domain-expiration.py

<br>
#### required package


```
yum install python-pip
pip install python-whois
pip install --upgrade pip
```


<br>
#### 메일 정보 파일 생성

vim .mail_header

```
From: mail1234@mailserver.com
To: mail1234@mailserver.com
Subject: 도메인 만료일 안내
Content-Type: text/html
```

<br>
#### 도메인 리스트 파일 생성

vim domain_list.txt

```
abc.com
google.com
```

<br>
#### 크론탭 설정

crontab -e

```
### domain check
00 10 1-7 * *   [ "`date '+\%a'`" == Mon ] && /bin/bash /app/script/Domain-Expiration-Check-Shell-Script/domain-check.sh > /dev/null 2>&1
```

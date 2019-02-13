#!/usr/bin/python

import whois
from datetime import datetime
from sys import argv,exit

now = datetime.now()

if len(argv) < 2:
    print 'No domain specified on the command line, usage:  '
    print ''
    print '    ./check-domain.py example.net'
    exit(1)

domain = argv[1]
try:
    w = whois.whois(domain)
except whois.parser.PywhoisError as e:
    print e
    exit(1)

if type(w.expiration_date) == list:
    w.expiration_date = w.expiration_date[0]
else:
    w.expiration_date = w.expiration_date

domain_expiration_date = str(w.expiration_date.day) + '/' + str(w.expiration_date.month) + '/' + str(w.expiration_date.year)

timedelta = w.expiration_date - now
days_to_expire = timedelta.days

if timedelta.days <= 60 and timedelta.days > 30:
    condition = "INFORMATION"
elif timedelta.days <= 30:
    condition = "WARNING"
else:
    condition = "OK"

print '| %10s | %20s | %13s | %13s |' % (condition, domain, days_to_expire, domain_expiration_date)

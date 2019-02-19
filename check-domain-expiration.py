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

domain_expiration_date = str(w.expiration_date.year) + '-' + str(w.expiration_date.month) + '-' + str(w.expiration_date.day)

timedelta = w.expiration_date - now
days_to_expire = timedelta.days

if timedelta.days <= 90 and timedelta.days > 30:
    print '<tr><td>Must update 30 to 90 days ago</td><td>%s</td><td>%s</td><td>%s</td></tr>' % (domain, days_to_expire, domain_expiration_date)
    exit(1)
elif timedelta.days <= 30:
    print '<tr><td>Must update 30 days ago</td><td>%s</td><td>%s</td><td>%s</td></tr>' % (domain, days_to_expire, domain_expiration_date)
    exit(2)
else:
    print '<tr><td>OK</td><td>%s</td><td>%s</td><td>%s</td></tr>' % (domain, days_to_expire, domain_expiration_date)
    exit(0)


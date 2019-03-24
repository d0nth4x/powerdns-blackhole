import urllib2
import xmltodict
from subprocess import call


def getDomains():
    file = urllib2.urlopen('https://hazard.mf.gov.pl/api/Register')
    data = file.read()
    file.close()

    return xmltodict.parse(data)


response = getDomains()
file = open('forward.txt', 'w')

for row in response['Rejestr']['PozycjaRejestru']:
    file.write(row['AdresDomeny'] + '\n')

call(['systemctl', 'restart', 'pdns-recursor'])

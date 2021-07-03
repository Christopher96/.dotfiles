#!/bin/python

import requests, sys, os

def main(argv):
    FG = os.popen("xrdb -query | awk '/polybar.foreground_alt:/ {print $2}'").read().strip()
    if(len(sys.argv) > 1):
        output = ''
        for arg in sys.argv:
            r = requests.get('https://api.coinmarketcap.com/v1/ticker/'+arg)

            if(r.status_code == 200):
                try:
                    ticker = r.json()

                    if "error" not in ticker:
                        output += "%{F"+FG+"}"
                        output += ticker[0]['symbol'].upper()
                        output += "%{F-}"
                        output += ' $' + '%.2f' % float(ticker[0]['price_usd']) + ' '
                        
                        change = float(ticker[0]['percent_change_24h']);
                        color  = '#23dd55'
                        if change < 0:
                            color = '#dd2c23'

                        output += '%{F'+color+'}('+str(change)+'%)%{F-} '
                except Exception as e:
                   print(e) 
                
        print(output)

if __name__ == "__main__":
    main(sys.argv[1:])

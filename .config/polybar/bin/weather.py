#!/bin/python

import urllib.request, json

city = "Stockholm"
api_key = "54f4fc9fede4b1855dd8169099bc43db"

weather = eval(str(urllib.request.urlopen("http://api.openweathermap.org/data/2.5/weather?q={}&APPID={}".format(city, api_key)).read())[2:-1])

info = weather["weather"][0]["description"].capitalize()
temp = int(float(weather["main"]["temp"]) - 272.15)

print("%s, %i °C" % (info, temp))

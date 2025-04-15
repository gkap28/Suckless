#!/bin/bash

API_KEY="d33a7b45f9f1d17e76a20c6a6818d207"
LAT="39.3683"
LON="21.9219"

weather_info=$(curl -s "http://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&appid=$API_KEY&units=metric")
weather=$(echo "$weather_info" | jq -r '.weather[0].description' | awk '{print $1}')
temp=$(echo "$weather_info" | jq -r '.main.temp')
echo " $weather $temp°C"

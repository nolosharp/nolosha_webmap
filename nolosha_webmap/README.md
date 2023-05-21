# Nolosha webmap

## Description
Resource that provide endpoint for the nolosha_webmap_web interface.

## Installation 
add folder nolosha_webmap_lua on u resources.cfg : ensure nolosha_webmap
Host the folder nolosha_http_file on ur web host


## Config.lua
The updateInterval is the delay between two refresh of players data. Low values can make your server laggy. Default to 5000, for 5 seconds.
The AccessControlAllowOrigin allow you to restrict the url that can use the endpoint. See https://developer.mozilla.org/fr/docs/Web/HTTP/Headers/Access-Control-Allow-Origin

## Credits
Inspired by https://github.com/kibook/webmap
Use vorp framework

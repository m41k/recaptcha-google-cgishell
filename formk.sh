#!/bin/bash

#----------------------------------------------------------#
# Project: recaptha-google-cgishell		 	                   #
# CREATED BY: maik.alberto@hotmail.com		                 #
# Soure: https://github.com/m41k/recaptha-google-cgishell  #
#----------------------------------------------------------#

echo -e "Content-type: text/html\n\n"

ACTIN=`echo $0 | rev | cut -d / -f1 | rev`

############################################################
#           Insira suas chaves/Insert your keys            #
############################################################

PUBLIC_KEY="XXXXXXXXXXXXXXXXXXXXyyyyyyyyyyyyyyyyyyyyy"
PRIVATE_KEY="XXXXXXXXXXXXXXXXXXXzzzzzzzzzzzzzzzzzzzzz"

CAPTCHA="$(sed 's/recaptcha_//g;s/_field//g')"

RESP=`echo $CAPTCHA | cut -d "&" -f1 | cut -d"=" -f2`
PK=$PRIVATE_KEY

END="https://www.google.com/recaptcha/api/siteverify?secret=$PK&response=$RESP"

RESULT=`curl $END`


CHECK=$(echo $RESULT | cut -d ":" -f2 | cut -d "," -f1)
if [ $CHECK = "true" ]; then
  echo "Use sua criatividade humana aqui. Use your human creativity here"
  exit 0
fi

#======================> HTML FORM <=======================#

cat <<EOF

<html>
 <head>
       <title>M41k Captcha CGI/SHELL</title>
       <meta http-equiv="content-type" content="text/html;charset=utf-8" />
       <script src='https://www.google.com/recaptcha/api.js'></script>
  </head>
  <body>
        <form method='post' action='$ACTIN'>
        <div class="g-recaptcha" data-sitekey="$PUBLIC_KEY"></div>
        <input type='submit' name='top' value='OK'>
  </form>
 </body>
</html>

EOF

# Peggo-Notificator
## Install mail service.

While installation please choose **Internet Site** option.
```shell
sudo apt-get update && sudo apt-get upgrade \
&& sudo apt-get install postfix
```
### Create Gmail App password
```
1. Login into your Gmail, at the top right click on your acc icon an choose
"Manage your Google Account" 
2. On the left navigation panel, choose Security.
3. Setup 2-step Verification if it not active.
4. On the 'Signing in to Google' panel, choose App passwords. ... 
5. At the bottom, choose Select app and choose the app that you're using - Our case MAIL
6. Choose Select device --> Other(Custom name) --> Add "External account".
7. Choose Generate.
```
### Configure mail service
Add file "sasl_passwd" to the direcoty /etc/postfix/sasl/ and set your Gmail credentials
```
echo "[smtp.gmail.com]:587 <USERNAME>@gmail.com:<GMAIL APP PASS>" > /etc/postfix/sasl/sasl_passwd
```

>_Should be looking something like this_:  [smtp.gmail.com]:587 mr.neo@gmail.com:rfhgrtllsgrersae


Create hash databse file with following command
```
sudo postmap /etc/postfix/sasl/sasl_passwd
```

> _After that U have to see new file_ /etc/postfix/sasl/**sadl_passwd.db**


Open file /etc/postfix/main.cf find **relayhost** value and add: [smtp.gmail.com]:587
```
relayhost = [smtp.gmail.com]:587
```
Add some more settings to the end of main.cf file to enable SASL authentication.
```
echo " 
smtp_sasl_auth_enable = yes
smtp_sasl_security_options = noanonymous
smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
smtp_tls_security_level = encrypt
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt" >> /etc/postfix/main.cf
```


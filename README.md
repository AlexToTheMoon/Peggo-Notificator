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
Create file "sasl_passwd" to the direcoty /etc/postfix/sasl/ and set your Gmail credentials
```
sudo echo "[smtp.gmail.com]:587 <USERNAME>@gmail.com:<GMAIL APP PASS>" > /etc/postfix/sasl/sasl_passwd
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
sudo echo " 
smtp_sasl_auth_enable = yes
smtp_sasl_security_options = noanonymous
smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
smtp_tls_security_level = encrypt
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt" >> /etc/postfix/main.cf
```
Restart Postfix to aply all changes
```
sudo systemctl restart postfix
```
Send test email (It can be any email, not only Gmail.) 
```
echo "Subject: TEST
Test message" > test.txt \
&& sendmail <YOUR-EMAIL>@gmail.com < test.txt 2> /dev/null
```
## Install and setup Peggo-Notificator.
```
cd $HOME; wget https://github.com/AlexToTheMoon/Peggo-Notificator/raw/main/peggo-checker.tar \
&& tar xvf peggo-checker.tar \
&& cd peggo-checker; rm $HOME/peggo-checker.tar
```
Open file **peggo_health_check.go** with any fvorite editor
Change value at **"var orchAddress ="** variable, to your Orchestrator key,
which U use at peggod.service file for "--cosmos-from=" parameter.
> Example : var orchAddress = "umee1jdz5s07v9afbmjy0djsvvyldjnesfzlpdj0r6q"
Save changes.


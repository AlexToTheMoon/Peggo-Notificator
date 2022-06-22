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

#!/bin/bash
#Peggo Notificator

while true
do
        date

heighestEventNonce=$(go run $HOME/peggo_health_check.go | jq ."heighestEventNonce")

echo  "Heighest EventNonce $heighestEventNonce"

ownEventNonce=$(go run $HOME/peggo_health_check.go | jq ."ownEventNonce")

echo "Your EventNonce is $ownEventNonce"

                if [ $heighestEventNonce -ne $ownEventNonce ]; then
        sendmail -F Peggo -t USERNAME@gmail.com  < $HOME/email.txt 2> "/dev/null"

                echo  ">>> Notification Email was sent! <<<"

                else
                        echo  "*** ALL GOOD ***"

                fi
        sleep 3h

done

#!/bin/bash
#Peggo Notificator

while true
do
        date

heighestEventNonce=$(go run $HOME/peggo-checker/peggo_health_check.go | jq ."heighestEventNonce")

echo  "Heighest EventNonce $heighestEventNonce"

ownEventNonce=$(go run $HOME/peggo-checker/peggo_health_check.go | jq ."ownEventNonce")

echo "Your EventNonce is $ownEventNonce"
                                        sleep 1s

                if [ -z "$heighestEventNonce" ]; then
                        #SET YOUR EMAIL BELOW
        sendmail -F Peggo -t EMAIL@gmail.com  < $HOME/peggo-checker/get-error.txt 2> "/dev/null"
                elif [ $heighestEventNonce -ne $ownEventNonce ]; then
                        #SET YOUR EMAIL BELOW
        sendmail -F Peggo -t EMAIL@gmail.com  < $HOME/peggo-checker/sync-error.txt 2> "/dev/null"

                echo  ">>> Notification Email was sent! <<<"

                else
                        echo  "*** ALL GOOD ***"
                        echo Next check in 3 hours.
                fi
        sleep 3h

done



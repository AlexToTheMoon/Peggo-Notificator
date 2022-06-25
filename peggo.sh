#!/bin/bash
#Peggo Notificator

while true
do
        date

heighestEventNonce=$(go run $HOME/peggo-checker/peggo_health_check.go | jq ."heighestEventNonce")

echo  "Heighest EventNonce $heighestEventNonce"

ownEventNonce=$(go run $HOME/peggo-checker/peggo_health_check.go | jq ."ownEventNonce")

echo "Your EventNonce is $ownEventNonce"
                                        sleep 2s

                if [ -z "$heighestEventNonce" ]; then
        sendmail -F Peggo -t latflat@gmail.com  < $HOME/peggo-checker/get-error.txt 2> "/dev/null"
                        echo  ">>> Can`t get Event Nonce! Alert was sent. <<<"
                        
                elif [ $heighestEventNonce -ne $ownEventNonce ]; then
        sendmail -F Peggo -t latflat@gmail.com  < $HOME/peggo-checker/sync-error.txt 2> "/dev/null"

                echo  ">>> Peggo not synced! Alert was sent! <<<"

                else
                        echo  "*** ALL GOOD ***"
                        echo Next check in 3 hours.
                fi
        sleep 3h

done


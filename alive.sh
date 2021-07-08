while true
do
    sleep 5 #sleep NUMBER[SUFFIX]. SUFFIX= seconds (s), minutes (m), hours (h) and days (d). Given value 5 is 5 seconds.
    echo "Preventing site from idling..."
    wget -q -O/dev/null $BASE_URL_OF_BOT
done

command="xvfb-run -a /usr/games/steam"
log="steam.log"
match="Verification complete"
shutdown_match="Shutdown"
pkill Xvfb
$command > "$log" 2>&1 &
pid=$!

while sleep 5
do
    echo " "
    cat $log
    
    if fgrep --quiet "$match" "$log"
    then
        echo "pkill steam"
        sleep 10
        pkill "steam"
        echo " "
        cat $log
        sleep 1
        exit 0
    fi
done
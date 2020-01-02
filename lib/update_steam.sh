command="xvfb-run -a /usr/games/steam"
log="steam.log"
match="STEAM_RUNTIME_HEAVY:"
pkill Xvfb
$command > "$log" 2>&1 &
pid=$!

while sleep 10
do
    tail -n 2 $log
    if fgrep --quiet "$match" "$log"
    then
        echo "pkill steam"
        pkill "steam"
        cat $log
        sleep 1
        exit 0
    fi
done
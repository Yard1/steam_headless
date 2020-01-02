command="xvfb-run /usr/games/steam"
log="steam.log"
match="STEAM_RUNTIME_HEAVY:"
$command > "$log" 2>&1 &
pid=$!

while sleep 10
do
    tail -n 2 $log
    if fgrep --quiet "$match" "$log"
    then
        echo "pkill $command"
        pkill "$command"
        cat $log
        exit 0
    fi
done
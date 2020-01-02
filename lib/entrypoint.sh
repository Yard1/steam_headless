#!/bin/bash
export DISPLAY=:98
sudo Xvfb :98 -screen 0 1280x720x24 -ac +extension RANDR +render -noreset &
/usr/games/steam &
wait
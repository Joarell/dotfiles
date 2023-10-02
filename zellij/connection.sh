#!/bin/bash


function placeConnection()
{
	CHECK=1
	TEST=www.google.com

	while true ; do
		sleep 10
		AGENT=$(curl -Is "$TEST" | sed -n '1p' | awk '{print $2}')

		if [[ "$AGENT" != 20* ]] && [[ "$CHECK" == 1 ]]; then
			CHECK=0
			tmatrix -g 0,80 -C white -t "WORNING: Connection Lost!" &
		elif [[ "$AGENT" == 20* ]] && [[ "$CHECK" == 0 ]]; then
			CHECK=1
			PID="$(pgrep tmatrix | tail -n 1)"
			kill "$PID"
		fi
	done
}

placeConnection &
tmatrix -g 0,100 -t "The Matrix has you."

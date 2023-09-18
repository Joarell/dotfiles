#!/bin/bash


function placeConnection()
{
	CHECK=1
	TEST=www.google.com

	while true ; do
		AGENT=$(curl -Is "$TEST" | sed -n '1p' | awk '{print $2}')

		if [[ "$AGENT" -ne "200" ]] && [[ "$CHECK" -eq 1 ]]; then
			CHECK=0
			tmatrix -C white &
		elif [[ "$AGENT" -eq "200" ]] && [[ "$CHECK" -eq 0 ]]; then
			CHECK=1
			PID="$(pgrep tmatrix | tail -n 1)"
			kill "$PID"
		fi
	done
};

placeConnection &
tmatrix

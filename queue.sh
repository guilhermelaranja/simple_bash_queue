#!/bin/bash -e

BASEDIR="$(dirname $0)/queue_data"

qlist() {
	QUEUE_NAME=$1

	mkdir -p "$BASEDIR/$QUEUE_NAME"

	ls -1 "$BASEDIR/$QUEUE_NAME" | sort
}

qadd() {
	QUEUE_NAME=$1
	DATA=$2
	RETRY_COUNT=$3

	mkdir -p "$BASEDIR/$QUEUE_NAME"

	echo "$RETRY_COUNT" > "$BASEDIR/$QUEUE_NAME/$DATA"

	echo "Added $DATA to $QUEUE_NAME"
}

qremove() {
	QUEUE_NAME=$1
        DATA=$2

	rm -f "$BASEDIR/$QUEUE_NAME/$DATA"

	echo "Removed $DATA from $QUEUE_NAME"
}

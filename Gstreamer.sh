#!/bin/sh

clear
echo "--- Checks which plugins are installed in Gstreamer ---" ; sleep 2

while read line; do

    for plugin in $line; do

        sleep 0.1
        if 'gst-inspect-1.0' | grep -q $plugin
        then

        echo "$plugin = Exists!"

        else
        echo "$plugin = Not installed !"

        fi

        done

done <"list.txt"
echo "Done"

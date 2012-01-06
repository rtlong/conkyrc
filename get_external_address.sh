#!/bin/bash

# This is supposed to be used as a dispatcher.d hook for NetworkManager. As such, you should install it in /etc/NetworkManager/dispacter.d/ with a name like `80-external-address`, for example. Make sure it's executable!

IF=$1
STATUS=$2

wait_for_process() {
  PNAME=$1
  PID=`/usr/bin/pgrep $PNAME`
  while [ -z "$PID" ]; do
     sleep 3;
     PID=`/usr/bin/pgrep $PNAME`
  done
}

# This only has the status of one interface, so since I am being lazy about this, try to get out, regardless of the $STATUS. Even if this interface just went down, the other may be up, still.

# Wait for the applet to bring the connection up fully
wait_for_process NetworkManager

# Then get the IP
ip="$(curl www.findmyip.com/ | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')"

if [ -z "$IP" ]; then
  IP="disconnected"
else
  # If the result wasn't empty, check to make sure it looks like an IP address, otherwise, there is a problem with tho connection (my request was redirected to a login page at a public WiFi hotspot, etc.)
  [[ ! $IP =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]] && IP="problem with connection"
fi

echo $IP > /tmp/external-ip
chmod a+r /tmp/external-ip

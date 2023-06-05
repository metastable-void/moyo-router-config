#!/bin/sh

IP=/sbin/ip
"$IP" route del 10.194.1.1 dev eth0 table docomo-route >/dev/null 2>&1 || true
"$IP" rule del to 10.194.1.1 lookup docomo-route >/dev/null 2>&1 || true

"$IP" route add 10.194.1.1 dev eth0 table docomo-route
"$IP" rule add to 10.194.1.1 lookup docomo-route

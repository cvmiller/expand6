#!/bin/bash
set -uo pipefail

##################################################################################
#
#  Copyright (C) 2017 Craig Miller
#
#  See the file "LICENSE" for information on usage and redistribution
#  of this file, and for a DISCLAIMER OF ALL WARRANTIES.
#  Distributed under GPLv2 License
#
##################################################################################


#	IPv6 Address Expansion example code
#
#	by Craig Miller		19 Feb 2017

VERSION=0.96

# two IPv6 addresses which are represented differently, but should be the same
addr1=2001:db8:123::5
addr2=2001:0db8:123:0::0:5


source expand6.sh

if [[ $(expand $addr1) == $(expand $addr2) ]]; then
	echo "Addresses $addr1 == $addr2 are the same"
else
	echo "Addresss $addr1 != $addr2  are different"
fi

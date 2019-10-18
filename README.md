## Synopsis

A shell script to quickly expand IPv6 addresses to the full width, in order to make programmatic comparisons of addresses easier or just see the fully expanded address.


## Motivation

There are a few shell script implementations of expanding IPv6 addresses on the internet, and most are a challenge to use at best. My goal was to create a cleaner implementation, which can be called as a library function, thus making it easy to integrate into your shell scripts.


### IPv6 Addressing
IPv6 introduces the concept of *compressing* an address by representing a long string of zeros with a double colon `::`. Although very useful for humans, the compressed format is more challenging for comparing addresses (e.g. should this address be added to my cache?) in a script. 

#### Run as a CLI

`expand6.sh` can be run as a CLI script to immediately see the result of address expansion (see examples).

#### Script as a Library

Source the script into your bash script, and call the expand function.

```
source expand6.sh
expanded_addr = $(expand $compressed_addr)
```

In the example above the library creates a fully expanded address where `$comprssed_addr` such as `2001:db8:123::10` becomes `$expanded_addr` `2001:0db8:0123:0000:0000:0000:0000:0010`. The output of the fully expanded address will always be 39 characters.


#### Why Bash?
Bash is terrible at string handling, why write this script in bash? Because I wanted it to run on my router (OpenWRT), and just about every where else, with the minimal amount of dependencies. It is possible to run Python on OpenWRT, but Python requires more storage (more packages) than just bash.

## Examples

#### As a CLI:

**Help**

```
$ ./expand6.sh  -h
	./expand6.sh - expand compressed IPv6 addresss 
	e.g. ./expand6.sh 2001:db8:1:12:123::456 
	
	-t  self test
	
 By Craig Miller - Version: 0.93
```

**Expanding an address on the command line:**

```
$ ./expand6.sh 2001:db8:1:12:123::456 
2001:0db8:0001:0012:0123:0000:0000:0456
```

#### As a Library
There is an example script, `expand6_example.sh`, included, which does a comparison of two IPv6 addresses, calling the expand function.
```
# two IPv6 addresses which are represented differently, but should be the same
addr1=2001:db8:123::5
addr2=2001:0db8:123:0::0:5

source expand6.sh

if [[ $(expand $addr1) == $(expand $addr2) ]]; then
	echo "Addresses $addr1 == $addr2 are the same"
else
	echo "Addresss $addr1 != $addr2  are different"
fi
```
When run, the example script produces the following:
```
$ ./expand6_example.sh 
Addresses 2001:db8:123::5 == 2001:0db8:123:0::0:5 are the same
```


## Dependencies
The script is dependent on `bash` for array support, and `sed`, both of which should be readily available on any linux distro.

## Contributors

All code by Craig Miller cvmiller at gmail dot com. But ideas, and ports to other languages are welcome. 


## License

This project is open source, under the GPLv2 license (see [LICENSE](LICENSE))

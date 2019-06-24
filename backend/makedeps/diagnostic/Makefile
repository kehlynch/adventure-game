.PHONY: diagnostic-run-deps
diagnostic-run-deps:
	$(MAKE) -s apt-install packages="iotop strace gdb htop iptraf ngrep nmon iftop atop mtr tree ntp dhcping dhcpdump tcpdump"

CURFILE := $(shell dirname $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
ifeq ($(CURFILE), $(CURDIR))
include ../shared/*.mk
endif

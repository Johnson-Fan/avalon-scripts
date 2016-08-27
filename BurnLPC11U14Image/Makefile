#
# Author: Minux
# Author: Xiangfu Liu <xiangfu@openmobilefree.net>
# Author: Mikeqin <Fengling.Qin@gmail.com>
# Author: Fanzixiao <fanzixiao@canaan-creative.com>
#
# This is free and unencumbered software released into the public domain.
# For details see the UNLICENSE file at the root of the source tree.
#
# ----- Customer ----------------------------------------------------------
FIRMWARE_NAME = pmu

NXP_PARAMETERS = -g -2 -vendor=NXP -pLPC11U14/201 -wire=winUSB -s50 -flash-driver=LPC11_12_13_32K_4K.cfx
LPCXPRESSODIR ?= /usr/local/lpcxpresso_7.9.2_493/lpcxpresso/bin
LPCLINK_FIRM ?= $(LPCXPRESSODIR)/LPCXpressoWIN.enc

.PHONY: download

download:
	wget http://build.canaan-creative.com:8080/~buildbot/avalon7/pmu/2016-08-27/pmu.axf -O ./$(FIRMWARE_NAME).axf

reflash_ulink2: $(FIRMWARE_NAME).axf erase_ulink2
	(while ! (sleep 0.5 && $(LPCXPRESSODIR)/crt_emu_cm_redlink -flash-load-exec $< $(NXP_PARAMETERS)); do : ; done;)

erase_ulink2:
	-(killall -s 9 redlinkserv && sleep 1)
	(while ! (sleep 0.5 && $(LPCXPRESSODIR)/crt_emu_cm_redlink -flash-erase $(NXP_PARAMETERS)); do : ; done;)

reflash_lpclink: $(FIRMWARE_NAME).axf erase_lpclink
	(while !(sleep 0.5 && $(LPCXPRESSODIR)/crt_emu_lpc11_13_nxp -flash-load-exec $< $(NXP_PARAMETERS)) do : ; done;)

erase_lpclink:
	-(dfu-util -d 0x0471:0xdf55 -c 0 -t 2048 -R -D $(LPCLINK_FIRM) &&  sleep 1)
	(while ! (sleep 0.5 && $(LPCXPRESSODIR)/crt_emu_lpc11_13_nxp -flash-erase $(NXP_PARAMETERS)); do : ; done;)


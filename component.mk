MCUFONT = mcufont/encoder/mcufont

MF_FONTS_DIR = $(COMPONENT_PATH)/mcufont/fonts

MF_FONTS = DejaVuSans12 DejaVuSans12bw DejaVuSerif16 DejaVuSerif32 \
	fixed_5x8 fixed_7x14 fixed_10x20 DejaVuSans12bw_bwfont


MFDIR = mcufont/decoder

include $(COMPONENT_PATH)/$(MFDIR)/mcufont.mk

COMPONENT_OBJS = $(patsubst %.c,%.o,$(MFSRC))

COMPONENT_ADD_INCLUDEDIRS = $(MFDIR)
COMPONENT_SRCDIRS = $(MFDIR) mcufont
COMPONENT_EXTRA_INCLUDES = $(MF_FONTS_DIR)


$(MFDIR)/mf_font.o:	$(BUILD_DIR_BASE)/include/fonts.h

MF_FONTS_SRC = $(patsubst %,$(MF_FONTS_DIR)/%.c,$(MF_FONTS))

$(BUILD_DIR_BASE)/include/fonts.h:	$(MF_FONTS_SRC)
	/bin/echo -e $(foreach font,$(MF_FONTS),'\n#include "'$(font)'.c"') > $@

$(MF_FONTS_SRC):	$(MCUFONT)
	make -C $(COMPONENT_PATH)/mcufont/fonts

$(MCUFONT):
	make -C $(COMPONENT_PATH)/mcufont/encoder

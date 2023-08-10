################################################################################
#
# partclone
#
################################################################################

PARTCLONE_VERSION = 0.3.20
PARTCLONE_SOURCE = partclone-$(PARTCLONE_VERSION).tar.gz
PARTCLONE_SITE = $(call github,Thomas-Tsai,partclone,$(PARTCLONE_VERSION))
PARTCLONE_INSTALL_STAGING = YES
PARTCLONE_AUTORECONF = YES
PARTCLONE_DEPENDENCIES += attr e2fsprogs libgcrypt lzo xz zlib xfsprogs ncurses host-pkgconf
PARTCLONE_CONF_OPTS = --enable-static --enable-xfs --enable-btrfs --enable-ntfs --enable-extfs --enable-fat --enable-hfsp --enable-apfs --enable-ncursesw --enable-f2fs
PARTCLONE_EXTRA_LIBS = -ldl
PARTCLONE_CONF_ENV += LIBS="$(PARTCLONE_EXTRA_LIBS)"

# define PARTCLONE_AUTORECONF_CMDS
#     $(AUTORECONF) $(AUTORECONF_OPTS)
#     $(SED) -i -e 's/Partclone/UPP/g' /workspace/fos/fssourcex64/output/build/partclone-0.3.20/src/partclone.c
#     $(SED) -i -e 's/http:\/\/partclone.org/https:\/\/upp.ltd/g' /workspace/fos/fssourcex64/output/build/partclone-0.3.20/src/partclone.c
# 	$(EACH) $(BUILD_DIR)
# endef

# PARTCLONE_POST_PATCH_HOOKS += PARTCLONE_AUTORECONF_CMDS

define PARTCLONE_LINK_LIBRARIES_TOOL
	ln -f -s $(BUILD_DIR)/xfsprogs-*/include/xfs $(STAGING_DIR)/usr/include/
	ln -f -s $(BUILD_DIR)/xfsprogs-*/libxfs/.libs/libxfs.* $(STAGING_DIR)/usr/lib/
	ln -f -s $(@D)/fail-mbr/fail-mbr.bin $(@D)/fail-mbr/fail-mbr.bin.orig
endef

PARTCLONE_POST_PATCH_HOOKS += PARTCLONE_LINK_LIBRARIES_TOOL

$(eval $(autotools-package))

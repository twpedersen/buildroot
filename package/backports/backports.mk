###############################################################################
#
# backports, backported linux kernel modules
#
###############################################################################

BACKPORTS_VERSION = 3.13-rc2
BACKPORTS_SOURCE = backports-$(BACKPORTS_VERSION)-1.tar.bz2
BACKPORTS_SITE = http://www.kernel.org/pub/linux/kernel/projects/backports/stable/v$(BACKPORTS_VERSION)/
BACKPORTS_LICENSE = GPLv2

BACKPORTS_DEPENDENCIES = linux

BACKPORTS_KLIB_VARS = KLIB=$(STAGING_DIR)/usr/include/linux KLIB_BUILD=$(LINUX_DIR)
# KLIB here is INSTALL_MOD_PATH
BACKPORTS_KLIB_VARS_INSTALL = KLIB=$(TARGET_DIR) KLIB_BUILD=$(LINUX_DIR)

# TODO: defconfig?
define BACKPORTS_BUILD_CMDS
	$(MAKE) -C $(@D) $(BACKPORTS_KLIB_VARS) menuconfig
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) $(BACKPORTS_KLIB_VARS)
endef

define BACKPORTS_INSTALL_TARGET_CMDS
	 $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) $(BACKPORTS_KLIB_VARS_INSTALL) install
endef

$(eval $(generic-package))

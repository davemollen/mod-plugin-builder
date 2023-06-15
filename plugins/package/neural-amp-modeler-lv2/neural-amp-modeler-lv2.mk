######################################
#
# neural-amp-modeler-lv2
#
######################################

NEURAL_AMP_MODELER_LV2_VERSION = 87a121d35124204dd401e56ecef0c76bfb4458c3
NEURAL_AMP_MODELER_LV2_SITE = https://github.com/moddevices/neural-amp-modeler-lv2.git
NEURAL_AMP_MODELER_LV2_SITE_METHOD = git
NEURAL_AMP_MODELER_LV2_BUNDLES = neural_amp_modeler.lv2

# custom optimization flags
NEURAL_AMP_MODELER_LV2_TARGET_OPT  = $(subst ",,$(BR2_TARGET_OPTIMIZATION))
NEURAL_AMP_MODELER_LV2_TARGET_OPT += -fsingle-precision-constant
NEURAL_AMP_MODELER_LV2_TARGET_OPT += -flto -ffat-lto-objects

# pass options into cmake
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(NEURAL_AMP_MODELER_LV2_TARGET_OPT)"
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(NEURAL_AMP_MODELER_LV2_TARGET_OPT)"
NEURAL_AMP_MODELER_LV2_CONF_OPTS += -DCMAKE_SHARED_LINKER_FLAGS="$(TARGET_LDFLAGS) $(NEURAL_AMP_MODELER_LV2_TARGET_OPT)"

# needed for submodules support
NEURAL_AMP_MODELER_LV2_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define NEURAL_AMP_MODELER_LV2_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/modgui
	install -m 644 $(@D)/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/*.so $(TARGET_DIR)/usr/lib/lv2/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/
	install -m 644 $($(PKG)_PKGDIR)/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/*.* $(TARGET_DIR)/usr/lib/lv2/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/
	install -m 644 $($(PKG)_PKGDIR)/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/modgui/*.* $(TARGET_DIR)/usr/lib/lv2/$(NEURAL_AMP_MODELER_LV2_BUNDLES)/modgui/
endef

$(eval $(cmake-package))

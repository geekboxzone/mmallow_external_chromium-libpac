LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk

LOCAL_CPP_EXTENSION := .cc

# Set up the target identity
LOCAL_MODULE := libpac
LOCAL_MODULE_CLASS := SHARED_LIBRARIES

LOCAL_SRC_FILES := \
  src/proxy_resolver_v8.cc \
  src/proxy_resolver_js_bindings.cc \
  src/net_util.cc

LOCAL_CFLAGS += \
  -Wno-endif-labels \
  -Wno-import \
  -Wno-format \
  -Wno-unused-parameter \

LOCAL_C_INCLUDES += $(LOCAL_PATH)/src \
                    external/chromium_org/v8 \
                    external/chromium_org/src/v8 \

# Depend on V8 from WebView
# DO NOT COPY without permission from WebView Owners
LOCAL_STATIC_LIBRARIES := v8_tools_gyp_v8_base_gyp \
			  v8_tools_gyp_v8_libbase_gyp \
                          v8_tools_gyp_v8_snapshot_gyp \
                          third_party_icu_icui18n_gyp \
                          third_party_icu_icuuc_gyp \
                          third_party_icu_icudata_gyp

LOCAL_SHARED_LIBRARIES := libutils liblog libgabi++

include external/stlport/libstlport.mk

include $(BUILD_SHARED_LIBRARY)

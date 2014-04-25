LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

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

LOCAL_C_INCLUDES += $(LOCAL_PATH)/src external/chromium_org/v8

# Temporarily disable arm64 as WebView isn't being built there yet.
LOCAL_MODULE_UNSUPPORTED_TARGET_ARCH := arm64

# Depend on V8 from WebView
# DO NOT COPY without permission from WebView Owners
LOCAL_STATIC_LIBRARIES_x86_64 := v8_tools_gyp_v8_base_x64_gyp
LOCAL_STATIC_LIBRARIES_x86 := v8_tools_gyp_v8_base_ia32_gyp
LOCAL_STATIC_LIBRARIES_arm64 := v8_tools_gyp_v8_base_arm64_gyp
LOCAL_STATIC_LIBRARIES_arm := v8_tools_gyp_v8_base_arm_gyp
LOCAL_STATIC_LIBRARIES_mips := v8_tools_gyp_v8_base_mipsel_gyp
LOCAL_STATIC_LIBRARIES := v8_tools_gyp_v8_snapshot_gyp

LOCAL_SHARED_LIBRARIES := libutils libstlport liblog libicui18n libicuuc

include external/stlport/libstlport.mk

include $(BUILD_SHARED_LIBRARY)

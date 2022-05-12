# Based on https://github.com/TeamWin/android_external_zip
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := uwufetch
LOCAL_MODULE_TAGS := eng
LOCAL_SRC_FILES := \
	uwufetch.c

LOCAL_CFLAGS := -O3 -Wall -DUNIX -D__BIONIC__ -DNO_LARGE_FILE_SUPPORT \
                -DHAVE_DIRENT_H -DHAVE_TERMIOS_H -DUWUFETCH_VERSION="\"1.7-113-twrp\"" 

LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin

ifneq ($(TARGET_ARCH), arm64)
    ifneq ($(TARGET_ARCH), x86_64)
        LOCAL_LDFLAGS += -Wl,-dynamic-linker,/sbin/linker
    else
        LOCAL_LDFLAGS += -Wl,-dynamic-linker,/sbin/linker64
    endif
else
    LOCAL_LDFLAGS += -Wl,-dynamic-linker,/sbin/linker64
endif

include $(BUILD_EXECUTABLE)

# Copy prebuilt

## Create dirs
$(shell mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/sbin/etc/uwufetch/)
$(shell mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/sbin/uwufetch/lib)

## Copy files
$(shell cp $(LOCAL_PATH)/default.config $(TARGET_RECOVERY_ROOT_OUT)/sbin/etc/uwufetch/config)
$(shell cp -r $(LOCAL_PATH)/res/* $(TARGET_RECOVERY_ROOT_OUT)/sbin/uwufetch/lib)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := shm
LOCAL_C_INCLUDES := $(LOCAL_PATH)/android-shmem
LOCAL_CFLAGS := -O3 -I$(LOCAL_PATH)/android-shmem/libancillary -D_LINUX_IPC_H
LOCAL_CPP_EXTENSION := .cpp
LOCAL_SRC_FILES := $(wildcard $(LOCAL_PATH)/android-shmem/*.c)
LOCAL_LDFLAGS := -Wl,--version-script=$(LOCAL_PATH)/android-shmem/exports.txt
LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog
include $(BUILD_STATIC_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE := trinity
LOCAL_SRC_FILES := $(wildcard *.c) \
               $(wildcard mm/*.c) \
               $(wildcard fds/*.c) \
               $(wildcard rand/*.c) \
	           $(wildcard childops/*.c) \
	           $(wildcard ioctls/*.c) \
	           $(wildcard net/*.c) \
	           $(wildcard syscalls/*.c) \


LOCAL_ARM_MODE := arm
CFLAGS += -Wall -W -g -O2 -Wimplicit -D_FORTIFY_SOURCE=2 -D__linux__ -Wdeclaration-after-statement 
CFLAGS += -Wformat=2 -Winit-self -Wnested-externs -Wpacked -Wshadow -Wswitch-enum -Wundef
CFLAGS += -Wwrite-strings -Wno-format-nonliteral -Wstrict-prototypes -Wmissing-prototypes
CFLAGS += -Iinclude -fPIE
LOCAL_LDLIBS:= -llog
LOCAL_LDFLAGS += -fPIE -pie
LDFLAGS += -rdynamic
LOCAL_C_INCLUDES += include
LOCAL_C_INCLUDES += syscalls
LOCAL_STATIC_LIBRARIES += libshm
include $(BUILD_EXECUTABLE)

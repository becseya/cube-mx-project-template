include Makefile

CFLAGS += ${OVERLAY_CFLAGS}
LDFLAGS += ${OVERLAY_LDFLAGS}
C_INCLUDES += ${OVERLAY_C_INCUDES}
OBJECTS += ${OVERLAY_OBJECTS}

build/main.o: ../app/build/lib_app.a

FW_PATH_GENERATED := $(shell echo "${C_SOURCES}" | grep -Po '[^ ]+cube-mx-fw' | grep -Poz '^[^\s]+')

C_INCLUDES := $(subst ${FW_PATH_GENERATED},${DIR_CUBE_MX_FW},${C_INCLUDES})
C_SOURCES := $(subst ${FW_PATH_GENERATED},${DIR_CUBE_MX_FW},${C_SOURCES})
vpath %.c $(sort $(dir $(C_SOURCES)))

print-%  : ; @echo $($*)

include Makefile

CFLAGS += ${OVERLAY_CFLAGS}
LDFLAGS += ${OVERLAY_LDFLAGS}
C_INCLUDES += ${OVERLAY_C_INCUDES}
OBJECTS += ${OVERLAY_OBJECTS}

build/main.o: ../app/build/lib_app.a

print-%  : ; @echo $($*)

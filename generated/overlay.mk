include Makefile

CFLAGS += -DENABLE_APP_OVERLAY
LDFLAGS += ${EXTRA_LDFLAGS}
C_INCLUDES += ${EXTRA_C_INCUDES}
OBJECTS += ${EXTRA_OBJECTS}

build/main.o: ../app/build/lib_app.a

print-%  : ; @echo $($*)

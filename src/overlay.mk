include Makefile

LDFLAGS += ${EXTRA_LDFLAGS}
C_INCLUDES += ${EXTRA_C_INCUDES}

print-%  : ; @echo $($*)

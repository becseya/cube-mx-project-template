include Makefile

LDFLAGS += -static -L./build -l_app --specs=nosys.specs
C_INCLUDES += -Iapp

# User application makefile

all: build/lib_app.a

MCU = $(shell make -f overlay-print.mk --no-print-directory print-MCU)
C_DEFS = $(shell make -f overlay-print.mk --no-print-directory print-C_DEFS)
C_INCLUDES = $(shell make -f overlay-print.mk --no-print-directory print-C_INCLUDES)

CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) -Og -Wall -fdata-sections -ffunction-sections

build/lib_app.a: Makefile
	mkdir -p build
	arm-none-eabi-gcc -c ${CFLAGS} -MMD -MP -MF"build/lib_app.d" -o build/lib_app.a app/app.cpp
#re-trigger incremental build
	touch Src/main.c

clean:
	rm -rf build

-include build/lib_app.d

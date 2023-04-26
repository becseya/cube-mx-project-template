# User application makefile

DIR_GENERATED = ../generated

all: build/lib_app.a

MCU = $(shell make -C ${DIR_GENERATED} -f overlay.mk --no-print-directory print-MCU)
C_DEFS = $(shell make -C ${DIR_GENERATED} -f overlay.mk --no-print-directory print-C_DEFS)

C_INCLUDES =  \
-I${DIR_GENERATED}/Inc \
-I../cube-mx-fw/Drivers/STM32F1xx_HAL_Driver/Inc \
-I../cube-mx-fw/Drivers/CMSIS/Device/ST/STM32F1xx/Include \
-I../cube-mx-fw/Drivers/CMSIS/Include

CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) -Og -Wall -fdata-sections -ffunction-sections

build/lib_app.a: Makefile
	mkdir -p build
	arm-none-eabi-gcc -c ${CFLAGS} -MMD -MP -MF"build/lib_app.d" -o build/lib_app.a app.cpp

clean:
	rm -rf build

-include build/lib_app.d

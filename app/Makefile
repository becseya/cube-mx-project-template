# User application makefile

all: build/lib_app.a

MCU = $(shell make -C ../src -f overlay.mk --no-print-directory print-MCU)
C_DEFS = $(shell make -C ../src -f overlay.mk --no-print-directory print-C_DEFS)

C_INCLUDES =  \
-I../src/Inc \
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

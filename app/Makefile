# User application makefile

DIR_SRC = .
DIR_BUILD = build
DIR_GENERATED = ../generated
DIR_CUBE_FW = ../cube-mx-fw

# Not a real lib, rather a blob of all objects
APP_LIB = ${DIR_BUILD}/lib_app.a

PP = arm-none-eabi-g++
LD = arm-none-eabi-ld

MCU = $(shell make -C ${DIR_GENERATED} -f overlay.mk --no-print-directory print-MCU)
C_DEFS = $(shell make -C ${DIR_GENERATED} -f overlay.mk --no-print-directory print-C_DEFS)

C_INCLUDES =  \
-I${DIR_GENERATED}/Inc \
-I../cube-mx-fw/Drivers/STM32F1xx_HAL_Driver/Inc \
-I../cube-mx-fw/Drivers/CMSIS/Device/ST/STM32F1xx/Include \
-I../cube-mx-fw/Drivers/CMSIS/Include

CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) -Og -Wall -fdata-sections -ffunction-sections -fno-exceptions -fno-rtti

all: ${APP_LIB}

# -------------------------------------------------------------------------------------------------

SOURCES = $(shell find ${DIR_SRC} -name "*.cpp")
OBJECTS += $(subst ${DIR_SRC}/,${DIR_BUILD}/,${SOURCES:.cpp=.cpp.o})

${DIR_BUILD}/%.cpp.o: ${DIR_SRC}/%.cpp Makefile
	mkdir -p $(@D)
	${PP} -c ${CFLAGS} -MMD -MP -MF"$@.d" -Wa,-a,-ad,-alms="$@.lst" $< -o $@

${APP_LIB}: ${OBJECTS} Makefile
	@which ${LD}
	@${LD} --version | head -n 1
	${LD} -relocatable ${OBJECTS} -o ${APP_LIB}

# -------------------------------------------------------------------------------------------------

clean:
	rm -rf ${DIR_BUILD}

print-%  : ; @echo $($*)

-include $(wildcard $(DIR_BUILD)/*.d)

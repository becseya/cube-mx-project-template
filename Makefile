# Makefile for Cube MX project with externally linked user application

PROJECT_NAME ?= project

DIR_ABS = $(shell realpath "$$PWD")
DIR_GENERATED = generated
DIR_APP = app
DIR_FW = cube-mx-fw

MCU_FAMILY ?= $(shell cat ${DIR_GENERATED}/${PROJECT_NAME}.ioc | grep -Po '(?<=Family=STM32).+')

FINAL_ELF = ${DIR_GENERATED}/build/${PROJECT_NAME}.elf
FINAL_BIN = ${DIR_GENERATED}/build/${PROJECT_NAME}.bin

OVARLAY_ARGS = \
	"OVERLAY_CFLAGS=-DENABLE_APP_OVERLAY" \
	"OVERLAY_LDFLAGS=--specs=nosys.specs" \
	"OVERLAY_C_INCUDES=-I${DIR_ABS}/${DIR_APP}" \
	"OVERLAY_OBJECTS=${DIR_ABS}/${DIR_APP}/build/lib_app.a"

all: app-and-generated

# Build utilities -----------------------------------------------------------------------------------------------------

FLAG_FW_DOWNLOADED = ${DIR_FW}/.flag-fw-${MCU_FAMILY}-downloaded

${FLAG_FW_DOWNLOADED}:
	@rm -rf "${DIR_FW}" && mkdir -p "${DIR_FW}"
	git clone git@github.com:STMicroelectronics/STM32Cube${MCU_FAMILY}.git --depth=1 ${DIR_FW}
	rm -rf "${DIR_FW}/Projects"
	rm -rf "${DIR_FW}/.git"
	touch "${FLAG_FW_DOWNLOADED}"

download-firmware: ${FLAG_FW_DOWNLOADED}

check-generation:
	@test -f "${DIR_GENERATED}/Makefile" || (echo "Cube MX generation must be run first" && false)

# Final linking -------------------------------------------------------------------------------------------------------

app-and-generated: ${FLAG_FW_DOWNLOADED} check-generation
	make -C "${DIR_APP}"
	make -C "${DIR_GENERATED}" -f overlay.mk ${OVARLAY_ARGS}

${FINAL_ELF}: app-and-generated
${FINAL_BIN}: app-and-generated

clean:
	make -C "${DIR_APP}" clean
	test -f "${DIR_GENERATED}/Makefile" && make -C "${DIR_GENERATED}" -f overlay.mk clean

# Flasher utility -----------------------------------------------------------------------------------------------------

ifneq (${DIR_CUBE_PROGRAMMER},)
export PATH := ${DIR_CUBE_PROGRAMMER}/bin:${PATH}
endif

FLASH_ADDR ?= 0x8000000

check-programmer:
	@STM32_Programmer_CLI --version >/dev/null 2>&1 || (echo "Flasher utility not found. Please add it to your PATH or set 'DIR_CUBE_PROGRAMMER' environmental variable" && false)

flash-file: check-programmer
	test -f ${FLASH_FILE}
	STM32_Programmer_CLI -c port=SWD mode=UR -w ${FLASH_FILE} ${FLASH_ADDR} -v -rst

flash-rst: check-programmer
	STM32_Programmer_CLI -c port=SWD mode=UR -rst > /dev/null

flash: ${FINAL_ELF}
	@make flash-file FLASH_FILE=${FINAL_ELF} --no-print-directory

# debug ---------------------------------------------------------------------------------------------------------------

print-%  : ; @echo $($*)

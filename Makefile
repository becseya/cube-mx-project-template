# Top level Makefile

PROJECT_NAME ?= project

DIR_SRC = ./src
DIR_APP = ./app
DIR_BUILD = ${DIR_SRC}/build

MCU_FAMILY ?= $(shell cat ${DIR_SRC}/${PROJECT_NAME}.ioc | grep -Po '(?<=Family=STM32).+')

DIR_FW = ./cube-mx-fw

FLAG_FW_DOWNLOADED = ${DIR_FW}/.flag-fw-${MCU_FAMILY}-downloaded

ELF_FILE = ${DIR_BUILD}/${PROJECT_NAME}.elf
BIN_FILE = ${DIR_BUILD}/${PROJECT_NAME}.bin

OVARLAY_ARGS = "EXTRA_C_INCUDES=-I../app" "EXTRA_LDFLAGS=--specs=nosys.specs" "EXTRA_OBJECTS=../app/build/lib_app.a"

all: src-make

# ---------------------------------------------------------------------------------------------------------------------

ifneq (${DIR_CUBE_PROGRAMMER},)
export PATH := ${DIR_CUBE_PROGRAMMER}/bin:${PATH}
endif

check-programmer:
	@STM32_Programmer_CLI --version >/dev/null 2>&1 || (echo "Flasher utility not found. Please add it to your PATH or set 'DIR_CUBE_PROGRAMMER' environmental variable" && false)

${FLAG_FW_DOWNLOADED}:
	@rm -rf "${DIR_FW}" && mkdir -p "${DIR_FW}"
	git clone git@github.com:STMicroelectronics/STM32Cube${MCU_FAMILY}.git --depth=1 ${DIR_FW}
	rm -rf "${DIR_FW}/Projects"
	rm -rf "${DIR_FW}/.git"
	touch "${FLAG_FW_DOWNLOADED}"

download-firmware: ${FLAG_FW_DOWNLOADED}

# ---------------------------------------------------------------------------------------------------------------------

src-make: ${FLAG_FW_DOWNLOADED}
	test -f "${DIR_SRC}/Makefile" || (echo "Cube MX generation must be run first" && false)
	make -C "${DIR_APP}"
	make -C "${DIR_SRC}" -f overlay.mk ${OVARLAY_ARGS}

${ELF_FILE}: src-make
${BIN_FILE}: src-make

clean:
	make -C "${DIR_APP}" clean
	make -C "${DIR_SRC}" -f overlay.mk clean

# ---------------------------------------------------------------------------------------------------------------------

flash: check-programmer ${ELF_FILE}
	STM32_Programmer_CLI -c port=SWD mode=UR -w ${ELF_FILE} 0x8000000 -v -rst

flash-rst: check-programmer
	STM32_Programmer_CLI -c port=SWD mode=UR -rst > /dev/null

print-%  : ; @echo $($*)

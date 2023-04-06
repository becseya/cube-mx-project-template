# Top level Makefile

PROJECT_NAME ?= project

DIR_SRC = ./src
DIR_BUILD = ${DIR_SRC}/build

MCU_FAMILY ?= $(shell cat ${DIR_SRC}/${PROJECT_NAME}.ioc | grep -Po '(?<=Family=STM32).+')

DIR_FW = ./cube-mx-fw

FLAG_FW_DOWNLOADED = ${DIR_FW}/.flag-fw-${MCU_FAMILY}-downloaded

ELF_FILE = ${DIR_BUILD}/${PROJECT_NAME}.elf
BIN_FILE = ${DIR_BUILD}/${PROJECT_NAME}.bin

all: src-make

# ---------------------------------------------------------------------------------------------------------------------

${FLAG_FW_DOWNLOADED}:
	@rm -rf "${DIR_FW}" && mkdir -p "${DIR_FW}"
	git clone git@github.com:STMicroelectronics/STM32Cube${MCU_FAMILY}.git --depth=1 ${DIR_FW}
	rm -rf "${DIR_FW}/Projects"
	rm -rf "${DIR_FW}/.git"
	touch "${FLAG_FW_DOWNLOADED}"

download-firmware: ${FLAG_FW_DOWNLOADED}

src-make: ${FLAG_FW_DOWNLOADED}
	make -C "${DIR_SRC}"

${ELF_FILE}: src-make
${BIN_FILE}: src-make

clean:
	make -C "${DIR_SRC}" clean

print-%  : ; @echo $($*)

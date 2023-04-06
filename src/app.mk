# User application makefile

all: build/lib_app.a

CFLAGS = $(shell make -f overlay-print.mk --no-print-directory print-CFLAGS)

build/lib_app.a: Makefile
	mkdir -p build
	arm-none-eabi-gcc -c ${CFLAGS} -o build/lib_app.a app/app.cpp
	rm print-CFLAGS

clean:
	rm -rf build

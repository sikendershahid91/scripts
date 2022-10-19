#
# Sikender Shahid
# - general purpose makefile for building c, c++, fortran
# - cross language linking is contained in the makefile
# - source files should be using the wildcards

PROGRAM?=test
MACRO_FILE?=include/macro.d

OPT_MACRO=$(shell echo "$(macro)" | tr a-z A-Z )

CFILES =$(wildcard ./*.c)
CCFILES=$(wildcard ./*.cc)
FFILES =$(wildcard ./*.f)
LIBS   =$(wildcard ./lib/*.a) #OBS: using -L(library path)

OBJS   =$(CFILES:.c=.o) \
	$(CCFILES:.cc=.o)\
	$(FFILES:.f=.o)

INCLUDE=-I${PWD}/include

LINKER=g++
LDFLAGS=-lm -lstdc++ -lgfortran -lrt -Llib/
POST_LDFLAGS=
FFLAGS=-Wall ${INCLUDE}
CFLAGS=-Wall ${INCLUDE}
CCFLAGS=-Wall ${INCLUDE} -std=c++11

ifeq ($(OPT_MACRO), ON)
	INCLUDE += -imacro ${MACRO_FILE}
endif


all: $(OBJS)
	@echo "building: $(PROGRAM)"
	@$(LINKER) $(LDFLAGS) $^ $(POST_LDFLAGS) -o $(PROGRAM)
	@make -s clean

%.o: %.f
	@echo "compiling : $<"
	@gfortran $(FFLAGS) -c $< -o $@

%.o: %.c
	@echo "compiling : $<"
	@gcc $(CFLAGS) -c $< -o $@

%.o: %.cc
	@echo "compiling : $<"
	@g++ $(CCFLAGS) -c $< -o $@

.PHONY: clean
clean:;
	@rm *.o

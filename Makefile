PROGRAM?=test

CFILES =$(wildcard ./*.c)
CCFILES=$(wildcard ./*.cc)
FFILES =$(wildcard ./*.f)

OBJS   =$(CFILES:.c=.o) \
	$(CCFILES:.cc=.o)\
	$(FFILES:.f=.o)

LINKER=g++
LDFLAGS=-lm -lstdc++ -lgfortran -lrt

CFLAGS=
CCFLAGS=
FFLAGS=

all: $(OBJS)
	@echo "building: $(PROGRAM)"
	@$(LINKER) $(LDFLAGS) $^ -o $(PROGRAM)
	@make -S clean

%.o: %.c
	@echo "compiling : $<"
	@gcc $(CFLAGS) -c $< -o $@

%.o: %.cc
	@echo "compuling : $<"
	@g++ $(CCFLAGS) -c $< -o $@

%.o: %.f
	@echo "compiling : $<"
	@gfortran $(FFLAGS) -c $< -o $@

.PHONY: clean
clean:;
	@rm *.o


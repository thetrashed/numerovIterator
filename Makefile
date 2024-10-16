TARGET := hf_two_electron

FC := gfortran #ifort 
LD := $(FC)

FCFLAGS := -Wall -O -g3
LDFLAGS := -Wall

SRCDIR := src
OBJDIR := obj

MAIN := $(SRCDIR)/main.f90

SRC := $(wildcard $(SRCDIR)/*.f90)
SRC := $(filter-out $(MAIN), $(SRC))
INCLUDES :=  
OBJ := $(SRC:$(SRCDIR)/%.f90=$(OBJDIR)/%.o)

.PHONY: all clean
all: $(TARGET)

$(TARGET): $(OBJ)
	@$(LD) $(LDFLAGS) -o $@ $(MAIN) $^

$(OBJ): $(OBJDIR)/%.o : $(SRCDIR)/%.f90 $(INCLUDES)
	@$(FC) $(FCFLAGS) -c $< -o $@

clean:
	rm -f $(OBJDIR)/* *.mod

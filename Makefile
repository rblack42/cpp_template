# generic Makefile for COSC2325

# set the executable name
BIN     := app
TEST    := test

LIBS    := math

SRCDIR  :=  src/
LIBDIR  :=  lib/
TSTDIR  :=  tests/
DOCDIR  :=  docs/
OBJDIR  :=  _obj/

CXX     := g++
CFLAGS  := -I include -std=c++11

RM  := rm -f

# get a list of the app sources and the library sources
MSRCS   := $(wildcard $(SRCDIR)*.cpp)
LSRCS   := $(wildcard $(LIBDIR)*.cpp)
TSRCS   := $(wildcard $(TSTDIR)*.cpp)

# generate a list of all obj files to create
MOBJS    := $(MSRCS:%.cpp=$(OBJDIR)%.o)
LOBJS    := $(LSRCS:%.cpp=$(OBJDIR)%.o)
TOBJS    := $(TSRCS:%.cpp=$(OBJDIR)%.o)

# denerate a list of all dependency files to create
LDEPS   := $(LOBJS:.o=.d)
TDEPS   := $(TOBJS:.o=.d)

# rules section -----------------------------------------------

# primary application build rule
.PHONY: all
all:    $(BIN) $(TEST)

$(BIN): $(MOBJS) $(LOBJS)
	$(CXX) -o $@ $^

$(TEST): $(TOBJS) $(LOBJS)
	$(CXX) -o $@ $^ $(CFLAGS)

# implicit rule to build any obj file and associated dependency file
$(OBJDIR)%.o: %.cpp
	$(CXX) -c -o $@ $< $(CFLAGS) -MMD -MP

# create project folders if needed
.PHONY: init
init:
	mkdir -p $(SRCDIR)
	mkdir -p $(LIBDIR)
	mkdir -p $(TSTDIR)
	mkdir -p $(DOCDIR)
	mkdir -p $(OBJDIR)$(SRCDIR)
	mkdir -p $(OBJDIR)$(LIBDIR)
	mkdir -p $(OBJDIR)$(TSTDIR)

# remove all constructed files
.PHONY: clean
clean:
	$(RM) $(BIN) $(TEST) $(MOBJS) $(LOBJS) $(TOBJS) $(MDEPS) $(LDEPS) $(TDEPS)

# show file lists
.PHONY: debug
debug:
	-@echo MSRCS = $(MSRCS)
	-@echo LSRCS = $(LSRCS)
	-@echo TSRCS = $(TSRCS)
	-@echo MOBJS = $(MOBJS)
	-@echo TOBJS = $(TOBJS)
	-@echo LDEPS = $(LDEPS)
	-@echo TDEPS = $(TDEPS)

# include compiler generated dependencies
-include $(OBJDIR)*.d


# Makefile for CPUsim (Linux/Mac only)

# project root directory
PROJDIR	:= ~/cosc2325
NAME	:= CPUsim

# what to build
USRAPP	:= $(NAME)
TSTAPP	:= $(NAME)_test
LIBAR	:= $(NAME)_lib.a

# file for run command if needed
TSTFILE	:= $(NAME).tst

SRC		:=	src
LIB		:=  lib
TST 	:=  tests
DOC		:=	docs
INC		:=	include
BLD		:=	_build

DIRS 	:=	$(SRC) $(LIB) $(TST) $(DOC) $(INC) \
		$(BLD) $(BLD)/$(SRC) $(BLD)/$(LIB) $(BLD)/$(TST)

# generate list of source files
USRCS = $(wildcard $(SRC)/*.cpp)
LSRCS = $(wildcard $(LIB)/*.cpp)
TSRCS = $(wildcard $(TST)/*.cpp)

# generate list of object files to build
UOBJS = $(USRCS:%.cpp=$(BLD)/%.o)
LOBJS = $(LSRCS:%.cpp=$(BLD)/%.o)
TOBJS = $(TSRCS:%.cpp=$(BLD)/%.o)
OBJS  = $(UOBJS) $(LOBJS) $(TOBJS)

# auto generate list of dependencies
UDEPS	:= $(UOBJS:.o=.d)
LDEPS	:= $(LOBJS:.o=.d)
TDEPS	:= $(TOBJS:.o=.d)
DEPS	:= $(UDEPS) $(LDEPS) $(TDEPS)

# build tools
CXX	:= g++
AR	:= ar
RM	:= rm -f
PIP	:= pip
PY	:= python3

# documentation tools (needs Python3)
SPHINX	:= _venv/bin/sphinx-build
VENV	:= $(PY) -m venv

# build flags
CFLAGS	:= -std=c++11 -I $(INC)
LFLAGS	:= -L $(LIB) $(LIBAR)

# targets follow ----------------------------

.PHONY: all
# target: all - build dirs, app and test-app
all:	setup $(USRAPP) $(TSTAPP)


.PHONY:	run
# target: run - run application
run:	$(USRAPP) $(TSTFILE)
	./$(USRAPP) $(TSTFILE)

.PHONY: test
# target: test - run test-app
test:	$(TSTAPP)
	./$(TSTAPP)

# build rules
$(USRAPP):	$(UOBJS) $(LIBAR)
	$(CXX) $(LFLAGS) -o $@ $^ 

$(TSTAPP):	$(TOBJS) $(LIBAR)
	$(CXX) $(LFLAGS) -o $@ $^

$(LIBAR):	$(LOBJS)
	$(AR) rcs $@ $^

# build any needed directories
.PHONY:	setup
# target: setup - create project directories
setup: $(DIRS)

$(DIRS):
	mkdir -p $@

# inplicit rule to build object files
$(BLD)/%.o:	%.cpp
	$(CXX) -c $(CFLAGS) $< -o $@ -MMD -MP

.PHONY:	clean
# target: clean - remove all unneeded files
clean:
	$(RM) $(USRAPP) $(TSTAPP) $(OBJS) $(DEPS)

# show file lists
.PHONY: debug
# target: debug - display all make variables
debug:
	-@echo USRCS = $(USRCS)
	-@echo LSRCS = $(LSRCS)
	-@echo TSRCS = $(TSRCS)
	-@echo UOBJS = $(UOBJS)
	-@echo LOBJS = $(LOBJS)
	-@echo TOBJS = $(TOBJS)
	-@echo UDEPS = $(UDEPS)
	-@echo LDEPS = $(LDEPS)
	-@echo TDEPS = $(TDEPS)
	-@echo DIRS  = $(DIRS)

# build rules for Sphinx documentation
.PHONY:	doc_setup
# target: doc_setup - build sphinx documentation project
install:	docs/_venv docs_activate
	cd docs && cp ../files/requirements.txt . && \
	cp ../files/index.rst . && \
	cp ../files/webbrowser _venv/bin && \
	mkdir -p _static && cp ../files/conf.py . && \
	_venv/bin/pip install -Ur requirements.txt

docs/_venv:
	$(VENV)	docs/_venv

.PHONY:	docs_activate
docs_activate:	docs/_venv
	bash docs/_venv/bin/activate

.PHONY: html
# target: html - build sphinx html files
html:	docs_activate
	cd docs && \
	$(SPHINX) -b html -d ../_build/doctrees . ../_build/html

.PHONY: docs_view
# target: view - view generated HTML doc pages
view:	activate html
	cd docs && \
	_venv/bin/webbrowser

.PHONY: newr_project
# target: new_project - copy template to new git project
new_project:
	@read -p "Enter your project name: " ppath; \
	mkdir -p $(PROJDIR)/$$ppath; \
	cp -R Makefile $(PROJDIR)/$$ppath; \
	cp -R files $(PROJDIR)/$$ppath; \
	echo "Files copied to $(PROJDIR)/$$ppath"

.PHONY: help
# target: help - Display all callable targets
help:
	@echo
	@egrep "^\s*#\s*target\s*:\s*" [Mm]akefile \
		| sed -E "s/^\s*#\s*target\s*:\s*//g"
	@echo

# include compiler generated dependencies
-include $(BLD)/*.d


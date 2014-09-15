# Makefile to build application and libraries
.PHONY:	all lib clean

# list application sources
SRCS 	= main.cpp
OBJS = $(SRCS:%.cpp=%.o)

LIB 	= ../../lib/libmymath.a

# things needed by applications
INCS 	= -I ../include
LIBS 	= -L lib

# library subdirectories to build
SUBDIRS = lib

# application executable
EXCS	=	cppdemo

# make targets below this point =================
all:	$(EXCS)

$(LIB):
	for dir in $(SUBDIRS); do \
        $(MAKE) -C $$dir all; \
    done

$(EXCS):	$(LIB) $(OBJS)
	$(CXX) -o $(EXCS) $(LIBS) $(OBJS) -lmymath

clean:
		rm -f *.o $(EXCS)

		for dir in $(SUBDIRS); do \
			$(MAKE) -C $$dir clean; \
		done

%.o:	%.cpp
	$(CXX) -c $< $(INCS) -o $@


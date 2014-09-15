CXX		= g++

.PHONY: all

SRCS = test_main.cpp test_factorial.cpp test_sanity.cpp
OBJS = $(SRCS:%.cpp=%.o)
INCS = -I../include

EXEC = test
CXXFLAGS = $(INCS)

all:	$(EXEC)

$(EXEC):	$(OBJS)
	$(CXX) -o $(EXEC) $(OBJS) -L../lib -lmymath

%.o:	%.cpp
	$(CXX) -c $< $(CXXFLAGS) -o $@

clean:
	rm -f $(EXEC) $(OBJS)

CXX 	= g++
SRCS 	= factorial.cpp
OBJS 	= $(SRCS:%.cpp=%.o)

LIB  	= mymath
TARGET 	= lib$(LIB).a

CXXFLAGS =

.PHONY: all

all:	$(TARGET)

$(TARGET):	$(OBJS)
	ar -rcs $(TARGET) $(OBJS)
	cp factorial.h ../../include
	cp $(TARGET) ../../lib

%.o:	%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS) $(TARGET)
	rm ../../include/factorial.h
	rm ../../lib/$(TARGET)

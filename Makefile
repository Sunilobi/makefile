TARGET = app.exe

SRCS := $(wildcard src/*.cpp) $(wildcard src/mod/*.cpp)
OBJS := $(SRCS:.cpp=.o)
DEPS := Makefile.depend

INCLUDES = -Iinclude
CXXFLAGS = -O2 -Wall $(INCLUDES)
LDFLAGS = -lm

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $(OBJS)

.PHONY: depend clean
depend: $(DEPS)

$(DEPS): $(SRCS)
	$(CXX) $(INCLUDES) -MM $^ > $@
	@sed -i -E "s/^(.+?)\.o:/\1.o \1.d:/g" $@

clean:
	del /Q $(OBJS) $(DEPS) $(TARGET)

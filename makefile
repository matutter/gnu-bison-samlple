.RECIPEPREFIX = |
.PHONY: all clean run setup generate_sources
CXX    = g++
CINCL = -Isrc 
CXXFLAGS = -DDEBUG_ON

SOURCES = $(shell find -name *.cc) 

all: setup generate_sources main.o

main.o: src/main.cc
| ${CXX} ${CXXFLAGS} ${CINCL} ${SOURCES} -o main.o

setup:

generate_sources:
| make -C src/parse/ all

clean:
| make -C src/parse/ clean
| rm -f main.o

run: all
| ./main.o -p -s test/sample.input


# GNU Bison & Flex C++ parser sample
#### Adapted from  [gnu.org](https://www.gnu.org/software/bison/manual/html_node/A-Complete-C_002b_002b-Example.html)

### Requirements    
Install the *g++*, *make*, *bison*, and *flex*.
```
sudo apt install g++ make bison flex
```

### Build The Sample    
Run `make clean run` in the repository root to clean, compile, and run the sample with parser and lexer tracing enabled. 



### Sample Input    
This input should yield `49` run `main.o test/sample.input` to try. 
```
one := 1
two := 2
three := 3
seven := one + two * three
var := seven * seven
(var + var) / 2
```

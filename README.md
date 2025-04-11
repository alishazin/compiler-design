# Compile a Lex Program 

```
lex filename.lex
```
This will create a file lex.yy.c

To compile this c file:
```
gcc lex.yy.c -o filename
```
This will create a executable file 'filename'

To run it:
```
./filename
```

# Compile Yacc and Lex Program 

```
lex filename.lex
```
This will create a file lex.yy.c

```
yacc -d filename.y
```
This will create files y.tab.c and y.tab.h

To compile this c files:
```
gcc lex.yy.c y.tab.c -o filename
```
This will create a executable file 'filename'

To run it:
```
./filename
```

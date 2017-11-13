### function arguments / stack manipulation

arguments to function call are replaced on the stack with the result. e.g. if the stack has 3 values

```
a
b
c
```

and we call a function with 2 arguments

```
call Math.multiply
```

`b` and `c` are used as arguments and are replaced with result `d` in the stack

```
a
d
```

### function declaration

```
function fn-name num-locals
```


### call

1. pass params from caller to callee
2. determine return address in caller's code
3. save caller's return address, stack, and memory segments
4. jump to execute called fn


### return

1. return to caller the value computed by called fn
2. recycle memory resources used by called fn
3. reinstate caller's stack and memory segments
4. jump to return address in caller's code


### flow

```
call fn 2
```

1. set arg pointer to stack pointer - 2
2. save caller's frame:  push return addr, LCL, ARG, THIS, THAT *pointers* onto the stack
3. jump to fn's code

4. set up local segment of fn

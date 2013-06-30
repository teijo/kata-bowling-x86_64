x86_64 assembly implementation of the bowling kata. Picked up from here:
http://www.peterprovost.org/blog/2012/05/02/kata-the-only-way-to-learn-tdd#the-bowling-game-kata

```
$ nasm -f elf64 bowling.asm && ld bowling.o -o bowling
$ ./bowling; echo $?
0
```

# Lisp::Compiler

Given file main.ll
```llvm
; ModuleID = 'hello'

@hello = private unnamed_addr constant [14 x i8] c"Hello, World!\00"

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #0

define i32 @main() {
  %1 = call i32 @puts(i8* getelementptr inbounds ([14 x i8]* @hello, i32 0, i32 0))
  ret i32 0
}

attributes #0 = { nounwind }
```

To compile to an executable:

```bash
~/lisp-compiler-ruby [master+?]
% llc --filetype=obj -o main.o main.ll

~/lisp-compiler-ruby [master+?]
% clang -o main main.o

~/lisp-compiler-ruby [master+?]
% ./main
Hello, World!
```

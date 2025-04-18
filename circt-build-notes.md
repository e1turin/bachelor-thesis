# Заметки по сборке MLIR


Собираю на Windows

```sh
git clone --config core.autocrlf=false https://github.com/llvm/llvm-project.git
```

Начну со сборки LLVM из

https://mlir.llvm.org/getting_started/

```
cmake --help
...
Generators

The following generators are available on this platform (* marks default):
* Visual Studio 17 2022        = Generates Visual Studio 2022 project files.
                                 Use -A option to specify architecture.
```

```batch
REM In shell with Visual Studio environment set up, e.g., with command such as
REM   $visual-studio-install\Auxiliary\Build\vcvarsall.bat" x64
REM invoked.
git clone https://github.com/llvm/llvm-project.git
mkdir llvm-project\build
cd llvm-project\build
cmake ..\llvm -G "Visual Studio 15 2017 Win64" -DLLVM_ENABLE_PROJECTS=mlir -DLLVM_BUILD_EXAMPLES=ON -DLLVM_TARGETS_TO_BUILD="Native" -DCMAKE_BUILD_TYPE=Release -Thost=x64 -DLLVM_ENABLE_ASSERTIONS=ON
cmake --build . --target tools/mlir/test/check-mlir
```

у меня нет "Visual Studio 15 2017 Win64"

Использую это
```
cmake ..\llvm -G "Visual Studio 17 2022" -DLLVM_ENABLE_PROJECTS=mlir -DLLVM_BUILD_EXAMPLES=ON -DLLVM_TARGETS_TO_BUILD="Native" -DCMAKE_BUILD_TYPE=Release -Thost=x64 -DLLVM_ENABLE_ASSERTIONS=ON
cmake --build . --target tools/mlir/test/check-mlir
```
- проблема с MSBuild
- remove `-A Win64`
- Вроде сборка завершилась, 
  - были какие-то проблемы с инстанциацией шаблонов и
  - не находились файлы хедеры для дебага
  - еще какая-то ошибка компиляции
  - Не понятно, если это библиотека, то можно ли как-то проверить ее работоспособность



```
cmake ..\llvm -G "Ninja" -DLLVM_ENABLE_PROJECTS=mlir -DLLVM_BUILD_EXAMPLES=ON -DLLVM_TARGETS_TO_BUILD="Native" -DCMAKE_BUILD_TYPE=Release  -DLLVM_ENABLE_ASSERTIONS=ON -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_LINKER=lld-link
```
- add `-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++` and `-DCMAKE_LINKER=lld`
- remove `-Thost=x64`
- reference lld ad lld-link.exe
- проблема с библиотеками при линковке
  - Visual Studio Install / Individual Components / Windows 10 SDK, MSBuild support for LLVM

### Сборка в Docker

Прежде всего скачать репозиторий нужно с указанием `core.autocrlf=lf`, чтобы в докере не возникало проблем с кодировкой переносов

```sh
docker run --name build-llvm -it -v D:\Projects\LLVM\:/mnt/LLVM/ ubuntu:latest /bin/bash
```

```Dockerfile
FROM ubuntu:latest

RUN apt update

# TODO: setup timezone

RUN apt install -y \
    cmake \
    ninja-build \
    clang \
    lld \
    git \
    llvm

```

Для сборки:
```
cmake ../llvm -G "Ninja" -DLLVM_ENABLE_PROJECTS=mlir -DLLVM_BUILD_EXAMPLES=ON -DLLVM_TARGETS_TO_BUILD="Native" -DCMAKE_BUILD_TYPE=Release  -DLLVM_ENABLE_ASSERTIONS=ON 
```
- `-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_LINKER=lld-link`
- `vim ../llvm/cmake/config.guess -c "set ff=unix" -c ":wq"`

```
cmake -G Ninja ../llvm -DLLVM_ENABLE_PROJECTS=mlir -DLLVM_BUILD_EXAMPLES=ON -DLLVM_TARGETS_TO_BUILD="host" -DCMAKE_BUILD_TYPE=DEBUG -DLLVM_USE_SPLIT_DWARF=ON -DLLVM_ENABLE_ASSERTIONS=ON -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DLLVM_ENABLE_LLD=ON -DLLVM_CCACHE_BUILD=ON
```
- add `-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_LINKER=lld`
- set `-DLLVM_TARGETS_TO_BUILD="X86"`
- remove `-DCMAKE_BUILD_TYPE=Release`
- set `-DLLVM_TARGETS_TO_BUILD="host" -DCMAKE_BUILD_TYPE=DEBUG -DLLVM_USE_SPLIT_DWARF=ON -DLLVM_ENABLE_LLD=ON -DLLVM_CCACHE_BUILD=ON`
- set `-DLLVM_OPTIMIZED_TABLEGEN=ON`

## Сборка CIRCT

### На Macbook M3

Собралось примерно за час вместе со скачиванием LLVM и прогоном тестов.

```sh
git clone https://github.com/circt/circt.git
cd circt
git submodule init
git submodule update

# build llvm

mkdir llvm/build

cmake -B llvm/build -G Ninja llvm/llvm -DLLVM_ENABLE_PROJECTS="mlir" -DLLVM_TARGETS_TO_BUILD="host" -DLLVM_ENABLE_ASSERTIONS=ON -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

cmake --build llvm/build
cmake --build llvm/build --target check-mlir

# build circt (with slang enabled for circt-verilog)

cmake -B build -G Ninja . -DMLIR_DIR=$PWD/llvm/build/lib/cmake/mlir -DLLVM_DIR=$PWD/llvm/build/lib/cmake/llvm -DLLVM_ENABLE_ASSERTIONS=ON -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCIRCT_SLANG_FRONTEND_ENABLED=ON
cmake --build build --target check-circt
cmake --build build --target check-circt-integration
```


- - -
references

https://ps-group.github.io/compilers/llvm_setup

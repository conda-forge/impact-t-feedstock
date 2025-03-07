mkdir build
cd build

set "LD=%FC%"

set "LDFLAGS=%LDFLAGS% /defaultlib:ucrt.lib /defaultlib:msvcrt.lib /defaultlib:pgmath.lib /defaultlib:%BUILD_PREFIX%/Library/lib/clang/19/lib/windows/clang_rt.builtins-x86_64.lib"

cmake -G "MinGW Makefiles" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DLIBPGMATH_DIR="%LIBRARY_PREFIX%" ^
    ../src
if errorlevel 1 exit 1

cmake --build . --target install
if errorlevel 1 exit 1

exit 0

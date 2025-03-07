mkdir build
cd build

set "LD=%FC%"

set "LDFLAGS=%LDFLAGS% -Wl,-defaultlib:ucrt.lib -Wl,-defaultlib:msvcrt.lib -Wl,-defaultlib:pgmath.lib"

cmake -G "MinGW Makefiles" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DLIBPGMATH_DIR="%LIBRARY_PREFIX%" ^
    ../src
if errorlevel 1 exit 1

cmake --build . --target install
if errorlevel 1 exit 1

exit 0

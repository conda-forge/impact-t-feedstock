mkdir build
cd build

@REM set "LDFLAGS=%LDFLAGS% /defaultlib:ucrt.lib"
@REM set "LDFLAGS=%LDFLAGS% /defaultlib:msvcrt.lib"

cmake -G "MinGW Makefiles" ^
    -D CMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    ../src
if errorlevel 1 exit 1

cmake --build . --target install
if errorlevel 1 exit 1

exit 0

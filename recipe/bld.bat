powershell -Command "(Get-Content 'src/Appl/Field.f90') -replace 'BESY0', 'BESSEL_Y0' -replace 'BESJ0', 'BESSEL_J0' | Set-Content 'src/Appl/Field.f90'"

mkdir build
cd build

cmake -G "MinGW Makefiles" ^
    -D CMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    ../src
if errorlevel 1 exit 1

cmake --build . --target install
if errorlevel 1 exit 1

exit 0

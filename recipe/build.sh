#!/usr/bin/env bash

# for cross compiling using openmpi
export OPAL_PREFIX=$PREFIX

if [[ "$target_platform" == osx* ]]; then
  CMAKE_FLAGS+=" -DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT}"
  CMAKE_FLAGS+=" -DCMAKE_OSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET}"
fi

if [[ -n "${BUILD_MICROARCH:-}" ]]; then
  # replace the default -march/-mtune with the microarch-level target
  FFLAGS="$(echo "$FFLAGS" | sed -E 's/-m(arch|tune)=[^ ]+//g') -march=$BUILD_MICROARCH"
fi

mkdir build
cd build

cmake \
  ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DUSE_FFTW=ON \
  -DUSE_MPI=OFF \
  ../src

cmake --install . -j${CPU_COUNT} --verbose

if [[ "$mpi" != "nompi" ]]; then
  export FFLAGS="$FFLAGS -std=legacy $LDFLAGS"
  export FC=mpifort

  cd ..
  mkdir build_mpi
  cd build_mpi
  cmake \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_FFTW=ON \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DUSE_MPI=ON \
    ../src

  cmake --install . -j${CPU_COUNT} --verbose
fi

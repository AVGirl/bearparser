#!/bin/bash
echo "Trying to autobuild bearparser..."

#QT check
QTV="version 4."
if echo `qmake-qt4 -version` | grep -q "$QTV"; then
    echo "[+] Qt4 found!"
elif echo `qmake -v` | grep -q "$QTV"; then
    echo "[+] Qt4 found!"
else
    echo "[-] Qt4 NOT found!"
    echo "Install qt-sdk first"
    exit -1
fi

CMAKE_VER=`cmake --version`
CMAKEV="cmake version"
if echo "$CMAKE_VER" | grep -q "$CMAKEV"; then
    echo "[+] CMake found!"
else
    echo "[-] CMake NOT found!"
    echo "Install cmake first"
    exit -1
fi

mkdir bearparser
cd bearparser
git clone https://github.com/hasherezade/bearparser.git
echo "[+] bearparser cloned"
cd bearparser
git checkout qt4
cd ..
echo $$
mv bearparser src
mkdir build
echo "[+] build directory created"
cd build
cmake -G "Unix Makefiles" ../src/
make
cd ..
cp build/commander/bearcommander ./
echo "[+] Success! You can check the executable here:"
pwd

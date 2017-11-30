#! /bin/bash

export IM_TOP=$(pwd)
echo $IM_TOP "[shell]"
make -f Makefile.test nop

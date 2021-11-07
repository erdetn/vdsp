// Copyright(C) 2021 Erdet Nasufi. All rights reserved. MIT License.

module vdsp

#flag -I /usr/include
#flag -I /usr/include/x86_64-linux-gnu

#flag -lc 
#flag -lm 
#flag -lliquid
#flag -lfftw3 
#flag -std=c11

#include <liquid/liquid.h>


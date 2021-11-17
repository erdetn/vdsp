// Copyright(C) 2021 Erdet Nasufi. All rights reserved. MIT License.

module main

import vldsp

fn main() {
	z1 := vldsp.float_complex(2.0, 3.0)
	z2 := vldsp.float_complex(2.2, -.5)

	z3 := z1 + z2

	println('z1 = ${z1}')
	println('z2 = ${z2}')
	println('z3 = ${z3}')
}

// Copyright(C) 2021 Erdet Nasufi. All rights reserved. MIT License.

module main

import vldsp
import math

fn sig_generator(a f32, b f32, samples int) []vldsp.ComplexF32 {
	mut sig := []vldsp.ComplexF32{}
	mut sample := f32(0)

	for i in 1 .. samples {
		sample  = f32(a*math.sin(f32(i)*10*math.pi))
		sample += f32(b*math.sin(f32(i)*math.pi/3))
		sig << vldsp.float_complex(sample, f32(0))
	}
	return sig
}


fn main() {
	mut ac := vldsp.new_auto_correlator(20, 2)

	ac.print()
	
	x := sig_generator(2.1, 1.4, 1000)
	mut y := vldsp.ComplexF32{0.0, 0.0}
	mut index := int(0)

	for ix in x {
		ac.push(ix)
		y = ac.execute()
		println('${index}: ${ix.str()} --> IIR FILTER --> ${y.str()}')	
		index += 1
	}

	ac_energy := ac.energy()
	println('energy: ${ac_energy}')

	ac.destroy()
}

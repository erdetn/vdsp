// Copyright(C) 2021 Erdet Nasufi. All rights reserved. MIT License.

module main

import vdsp
import math

fn sig_generator(a f32, b f32, samples int) []vdsp.ComplexF32 {
	mut sig := []vdsp.ComplexF32{}
	mut sample := f32(0)

	for i in 1 .. samples {
		sample  = f32(a*math.sin(f32(i)*10*math.pi))
		sample += f32(b*math.sin(f32(i)*math.pi/3))
		sig << vdsp.float_complex(sample, f32(0))
	}
	return sig
}


fn main() {
	mut iir_filter := vdsp.new_iir_differentiator()

	iir_filter.print()
	
	x := sig_generator(2.1, 1.4, 1000)
	mut y := vdsp.ComplexF32{0.0, 0.0}
	mut index := int(0)

	for ix in x {
		y = iir_filter.execute(ix)
		println('${index}: ${ix.str()} --> IIR FILTER --> ${y.str()}')	
		index += 1
	}

	iir_filter.destroy()
}

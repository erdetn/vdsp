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
	hc := [f32(0.2), 1.2, 1.0, 0.1, 0.1, 0.2, 0.3]

	mut fir_filter := vdsp.new_fir_filter(hc) or {
		println(err.msg)
		return
	}

	fir_filter.set_scale(vdsp.ComplexF32{0.5, 0.5})

	fir_filter.print()
	
	x := sig_generator(2.1, 1.4, 1000)
	mut y := vdsp.ComplexF32{0.0, 0.0}
	mut index := int(0)

	fir_filter.write(x)

	for ix in x {
		fir_filter.push(ix)
		y = fir_filter.execute()
		println('${index}: ${ix.str()} --> FIR FILTER --> ${y.str()}')	
		index += 1
	}

	fir_filter.destroy()
}

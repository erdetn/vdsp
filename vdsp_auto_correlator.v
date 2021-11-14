// Copyright(C) 2021 Erdet Nasufi. All rights reserved. MIT License.

module vdsp

pub struct AutoCorrelator {
	fobj C.autocorr_cccf
}

fn C.autocorr_cccf_create(u32, u32) C.autocorr_cccf
pub fn new_auto_correlator(window_size u32, delay u32) AutoCorrelator {
	return AutoCorrelator{
		fobj: C.autocorr_cccf_create(window_size, delay)
	}
}

fn C.autocorr_cccf_destroy(C.autocorr_cccf)
pub fn (mut this AutoCorrelator)destroy() {
	C.autocorr_cccf_destroy(this.fobj)
}

fn C.autocorr_cccf_reset(C.autocorr_cccf) 
pub fn (mut this AutoCorrelator)reset() {
	C.autocorr_cccf_reset(this.fobj)
}

fn C.autocorr_cccf_print(C.autocorr_cccf) 
pub fn (this AutoCorrelator)print() {
	C.autocorr_cccf_print(this.fobj)
}

fn C.autocorr_cccf_push(C.autocorr_cccf, C.liquid_float_complex)
pub fn (this AutoCorrelator)push(z ComplexF32) {
	z1 := C.to_liquid_float_complex(z)
	C.autocorr_cccf_push(this.fobj, z1)
}

fn C.autocorr_cccf_write(C.autocorr_cccf, &C.liquid_float_complex, u32)
pub fn (this AutoCorrelator)write(z []ComplexF32) {
	if z.len == 0 {
		return
	}

	n := z.len
	unsafe {
		zp := C.to_liquid_float_complex_ptr(&z[0])
		C.autocorr_cccf_write(this.fobj, zp, n)
	}
}

fn C.autocorr_cccf_execute(C.autocorr_cccf, &C.liquid_float_complex)
pub fn (this AutoCorrelator)execute() ComplexF32 {
	z1 := ComplexF32{f32(0), f32(0)}
	z2 := C.to_liquid_float_complex(z1)
	unsafe {
		C.autocorr_cccf_execute(this.fobj, &z2)
	} 
	z3 := C.from_liquid_float_complex(z2)
	return z3
}

fn C.autocorr_cccf_execute_block(C.autocorr_cccf, &C.liquid_float_complex, u32, &C.liquid_float_complex)
pub fn (this AutoCorrelator)execute_block(z []ComplexF32) ComplexF32 {
	if z.len == 0 {
		return ComplexF32{f32(0), f32(0)}
	}

	mut zo3 := ComplexF32{f32(0), f32(0)}
	n := z.len
	unsafe {
		zi1 := C.to_liquid_float_complex_ptr(&z[0])
		zo1 := ComplexF32{f32(0), f32(0)}
		zo2 := C.to_liquid_float_complex(zo1)
		C.autocorr_cccf_execute_block(this.fobj, zi1, n, &zo2)
		zo3 = C.from_liquid_float_complex(zo2)
	}
	return zo3
}

fn C.autocorr_cccf_get_energy(C.autocorr_cccf) f32
pub fn (this AutoCorrelator)energy() f32 {
	return C.autocorr_cccf_get_energy(this.fobj)
}

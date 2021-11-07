// Copyright(C) 2021 Erdet Nasufi. All rights reserved. MIT License.

module vdsp

// float  = f32
// double = f64

pub struct FirFilter {
mut:
	fobj C.firfilt_crcf
}

fn C.firfilt_crcf_create(&f32, int) C.firfilt_crcf
pub fn new_fir_filter(filter_coefficients []f32) ?FirFilter{
	if filter_coefficients.len == 0 {
		return error('Empty filter coefficients.')
	}
	return unsafe { FirFilter {
		fobj: C.firfilt_crcf_create(&filter_coefficients[0],
			filter_coefficients.len)
	}}
}

fn C.firfilt_crcf_recreate(C.firfilt_crcf, &f32, int) C.firfilt_crcf
pub fn (mut this FirFilter)renew(filter_coefficients []f32) ?FirFilter {
	if filter_coefficients.len == 0 {
		return error('Empty filter coefficients.')
	}
	unsafe {
	this.fobj = C.firfilt_crcf_recreate(this.fobj,
					     &filter_coefficients[0],
					     filter_coefficients.len)
	}
	return this
}

fn C.firfilt_crcf_destroy(C.firfilt_crcf)
pub fn (mut this FirFilter)destroy() {
	C.firfilt_crcf_destroy(this.fobj)
}

fn C.firfilt_crcf_print(C.firfilt_crcf)
pub fn (this FirFilter)print() {
	C.firfilt_crcf_print(this.fobj)
}

fn C.firfilt_crcf_reset(C.firfilt_crcf)
pub fn (this FirFilter)reset() {
	C.firfilt_crcf_reset(this.fobj)
}

fn C.firfilt_crcf_push(C.firfilt_crcf, C.liquid_float_complex)
pub fn (this FirFilter)push(sample FloatComplex) {
	z := C.to_liquid_float_complex(sample)
	C.firfilt_crcf_push(this.fobj, z)
}

fn C.firfilt_crcf_execute(C.firfilt_crcf, &C.liquid_float_complex)
pub fn (this FirFilter)execute() FloatComplex {
	z1 := float_complex(0.0, 0.0)
	z2 := C.to_liquid_float_complex(z1)
	unsafe {
		C.firfilt_crcf_execute(this.fobj, &z2)
	}
	z3 := C.from_liquid_float_complex(z2)
	return z3
}

fn C.firfilt_crcf_get_length(C.firfilt_crcf) int
pub fn (this FirFilter)length() int {
	return C.firfilt_crcf_get_length(this.fobj)
}

fn C.firfilt_crcf_freqresponse(q C.firfilt_crcf, fc f32, h &C.liquid_float_complex)
pub fn (this FirFilter)frequency_response(fc f32) FloatComplex {
	mut h_freq := float_complex(0.0, 0.0)
	h1 := C.to_liquid_float_complex(h_freq)
	unsafe {
		C.firfilt_crcf_freqresponse(this.fobj, fc, &h1)
	}
	h_freq = C.from_liquid_float_complex(h1)
	return h_freq
}

fn C.firfilt_crcf_groupdelay(q C.firfilt_crcf, fc f32) f32
pub fn (this FirFilter)group_delay(fc f32) f32 {
	return C.firfilt_crcf_groupdelay(this.fobj, fc)
}

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

// Create new FIR filter using Kaiser-Bessel windowed       
// n      : filter length, _n > 0                             
// fc     : filter normalized cut-off frequency, 0 < _fc < 0.5
// a_s    : filter stop-band attenuation [dB], _As > 0        
// mu     : fractional sample offset, -0.5 < _mu < 0.5
fn C.firfilt_crcf_create_kaiser(n u32, fc f32, a_s f32, mu f32) C.firfilt_crcf
pub fn new_fir_filter_kaiser(length u32, fc f32, a_s f32, mu f32) FirFilter {
	return FirFilter {
		fobj: C.firfilt_crcf_create_kaiser(length, fc, a_s, mu)
	}
}

// Create new square-root Nyquist prototype FIR filter             
// k      : nominal samples per symbol (k > 1)                     
// m      : filter delay [symbols] (m > 0)                         
// beta   : rolloff factor (0 < beta <= 1)                          
// mu     : fractional sample offset [samples] (-0.5 < _mu < 0.5)   
fn C.firfilt_crcf_create_rnyquist(@type int, k u32, m u32, beta f32, mu f32) C.firfilt_crcf
pub fn new_fir_filter_rnyquist(k u32, m u32, beta f32, mu f32) FirFilter {
	return FirFilter{
		fobj: C.firfilt_crcf_create_rnyquist(C.LIQUID_FIRFILT_RRC, k, m, beta, mu)
	}
}

// Create new rectangular filter prototype FIR filter 
fn C.firfilt_crcf_create_rect(n u32) C.firfilt_crcf 
pub fn new_fir_filter_rect(n u32) FirFilter {
	return FirFilter{
		fobj: C.firfilt_crcf_create_rect(n)
	}
}

// Create new DC blocking filter from prototype
// m   : prototype filter semi-length such that filter length is 2*m+1
// a_s : prototype filter stop-band attenuation [dB], _As > 0
fn C.firfilt_crcf_create_dc_blocker(m u32, a_s f32) C.firfilt_crcf
pub fn new_fir_filter_dc_blocker(m u32, a_s f32) FirFilter {
	return FirFilter {
		fobj: C.firfilt_crcf_create_dc_blocker(m, a_s)
	}
}

// Create new notch filter
// m   : prototype filter semi-length such that filter length is 2*m+1
// a_s : prototype filter stop-band attenuation [dB], a_s > 0
// f0  : center frequency for notch, fc in [-0.5, 0.5]
fn C.firfilt_crcf_create_notch(m u32, a_s f32, f0 f32) C.firfilt_crcf 
pub fn new_fir_filter_notch(m u32, a_s f32, f0 f32) FirFilter {
	return FirFilter {
		fobj: C.firfilt_crcf_create_notch(m, a_s, f0)
	}
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

fn C.firfilt_crcf_set_scale(q C.firfilt_crcf, scale C.liquid_float_complex)
fn C.firfilt_crcf_get_scale(q C.firfilt_crcf, scale &C.liquid_float_complex)

pub fn (this FirFilter)set_scale(scale FloatComplex) {
	s0 := C.to_liquid_float_complex(scale)
	C.firfilt_crcf_set_scale(this.fobj, s0)
}

pub fn (this FirFilter)scale() FloatComplex {
	z0 := float_complex(f32(0.0), f32(0.0))
	z1 := C.to_liquid_float_complex(z0)
	unsafe {
		C.firfilt_crcf_get_scale(this.fobj, &z1)
	}
	z2 := C.from_liquid_float_complex(z1)
	return z2
}

fn C.firfilt_crcf_write(q C.firfilt_crcf, x &C.liquid_float_complex, n u32)
pub fn (this FirFilter)write(samples []FloatComplex) {
	if samples.len == 0 {
		return
	}
	unsafe {
		sref := C.to_liquid_float_complex_ptr(samples[0])
		C.firfilt_crcf_write(this.fobj, sref, samples.len)
	}
}
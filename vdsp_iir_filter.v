// Copyright(C) 2021 Erdet Nasufi. All rights reserved. MIT License.

module vdsp

// float  = f32
// double = f64

pub struct IirFilter {
mut:
	fobj C.iirfilt_crcf
}

fn C.iirfilt_crcf_create(&f32, u32, &f32, u32) C.iirfilt_crcf
// new_iir_filter creates a new IirFilter objects.
// a feed-back coefficients (denominators)
// b feed-forward coefficients (numerators)
pub fn new_iir_filter(a []f32, b []f32) ?IirFilter {
	if a.len == 0 || b.len == 0 {
		return error('One or both coefficients are empty.')
	}

	return unsafe { 
		IirFilter{
			fobj: C.iirfilt_crcf_create(&a[0], a.len, 
						    &b[0], b.len)
		}
	}
}

fn C.iirfilt_crcf_create_lowpass(u32, f32) C.iirfilt_crcf
// new_iir_lowpass creates simplified low-pass Butterworth IIR filter.
// order:        filter order (order > 0)
// cuttoff_freq: low-pass cut off frequency
pub fn new_iir_lowpass(order u32, cutoff_freq f32) ?IirFilter{
	if order == 0 {
		return error('order of filter is zero (0)')
	}
	return IirFilter {
		fobj: C.iirfilt_crcf_create_lowpass(order, cutoff_freq)
	}
}

fn C.iirfilt_crcf_create_integrator() C.iirfilt_crcf
pub fn new_iir_integrator() IirFilter{
	return IirFilter {
		fobj: C.iirfilt_crcf_create_integrator()
	}
}

fn C.iirfilt_crcf_create_differentiator() C.iirfilt_crcf
pub fn new_iir_differentiator() IirFilter{
	return IirFilter {
		fobj: C.iirfilt_crcf_create_differentiator()
	}
}

fn C.iirfilt_crcf_create_dc_blocker(alpha f32) C.iirfilt_crcf
pub fn new_iir_dc_blocker(alpha f32) ?IirFilter {
	if alpha > 0 {
		return error('alpha is zero.')
	}
	return IirFilter {
		fobj: C.iirfilt_crcf_create_dc_blocker(alpha)
	}
}

fn C.iirfilt_crcf_create_pll(f32, f32, f32) C.iirfilt_crcf
pub fn new_iir_pll(w f32, zeta f32, k f32) ?IirFilter{
	if w < 0 || w > 1 {
		return error('k is out of the range. (0 < k < 1)')
	}

	if zeta < 0 || zeta > 0 {
		return error('zeta is out of the range. (0 < zeta < 1)')
	}

	if !(k > 0) {
		return error('loop gain K < 0.')
	} 

	return IirFilter {
		fobj: C.iirfilt_crcf_create_pll(w, zeta, k)
	}
}

fn C.iirfilt_crcf_destroy(C.iirfilt_crcf)
pub fn (mut this IirFilter)destroy() {
	C.iirfilt_crcf_destroy(this.fobj)
}

fn C.iirfilt_crcf_print(C.iirfilt_crcf)
pub fn (this IirFilter)print() {
	C.iirfilt_crcf_print(this.fobj)
}

fn C.iirfilt_crcf_reset(C.iirfilt_crcf)
pub fn (this IirFilter)reset() {
	C.iirfilt_crcf_reset(this.fobj)
}

fn C.iirfilt_crcf_execute(C.iirfilt_crcf, C.liquid_float_complex, &C.liquid_float_complex)
pub fn (this IirFilter)execute(input ComplexF32) ComplexF32 {
	z1 := float_complex(0.0, 0.0)
	zi := C.to_liquid_float_complex(input)
	z2 := C.to_liquid_float_complex(z1)
	unsafe {
		C.iirfilt_crcf_execute(this.fobj, zi, &z2)
	}
	z3 := C.from_liquid_float_complex(z2)
	return z3
}

fn C.iirfilt_crcf_execute_block(C.iirfilt_crcf, &C.liquid_float_complex, u32, &C.liquid_float_complex)
pub fn (this IirFilter)execute_block(input []ComplexF32) ComplexF32 {
	if input.len == 0 {
		return ComplexF32{f32(0.0), f32(0.0)}
	}

	z1 := float_complex(0.0, 0.0)
	z2 := C.to_liquid_float_complex(z1)

	unsafe {
		sref := C.to_liquid_float_complex_ptr(input[0])
		C.iirfilt_crcf_execute_block(this.fobj, sref, input.len, &z2)
	}
	z3 := C.from_liquid_float_complex(z2)
	return z3
}

fn C.iirfilt_crcf_get_length(C.iirfilt_crcf) u32
pub fn (this IirFilter)length() u32 {
	return C.iirfilt_crcf_get_length(this.fobj)
}

fn C.iirfilt_crcf_freqresponse(C.iirfilt_crcf, f32, &C.liquid_float_complex)
pub fn (this IirFilter)freq_response(fi f32) ComplexF32 {
	z1 := ComplexF32{f32(0), f32(0)}
	z2 := C.to_liquid_float_complex(z1)
	unsafe {
		C.iirfilt_crcf_freqresponse(this.fobj, fi, &z2)
	}
	z3 := C.from_liquid_float_complex(z2)
	return z3
}

fn C.iirfilt_crcf_groupdelay(C.iirfilt_crcf, f32) f32
pub fn (this IirFilter)group_delay(fc f32) f32 {
	return C.iirfilt_crcf_groupdelay(this.fobj, fc)
}


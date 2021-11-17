// Copyright(C) 2021 Erdet Nasufi. All rights reserved. MIT License.

module vldsp

// float  = f32
// double = f64

#define to_liquid_float_complex(x) (liquid_float_complex)(*(liquid_float_complex *)&x)
#define to_liquid_float_complex_ptr(x) ((liquid_float_complex *)&x)
#define from_liquid_float_complex(x) (vldsp__ComplexF32)(*(vldsp__ComplexF32 *)&x)

#define to_liquid_double_complex(x) (liquid_double_complex)(*(liquid_double_complex *)&x)
#define from_liquid_double_complex(x) (vldsp__ComplexF64)(*(vldsp__ComplexF64 *)&x)

fn C.to_liquid_float_complex(x ComplexF32) C.liquid_float_complex
fn C.to_liquid_float_complex_ptr(x ComplexF32) &C.liquid_float_complex
fn C.from_liquid_float_complex(x C.liquid_float_complex) ComplexF32

fn C.to_liquid_double_complex(x ComplexF64) C.liquid_double_complex
fn C.from_liquid_double_complex(x C.liquid_double_complex) ComplexF64

[_pack: '1']
pub struct ComplexF32 {
mut:
	real f32
	imag f32
}

[_pack: '1']
pub struct ComplexF64 {
mut:
	real f64
	imag f64
}    

// struct C.liquid_float_complex{}
// pub type ComplexF32 = C.liquid_float_complex

// struct C.liquid_double_complex{}
// pub type ComplexF64 = C.liquid_double_complex

pub fn float_complex(r f32, i f32) ComplexF32 {
	return ComplexF32 {
		real: r,
		imag: i
	}
}
pub fn (this ComplexF32)str() string {
	x := this.real
	y := this.imag
	return 'ComplexF32: [${x}, ${y}]'
}

// fn C.CMPLXF(f32, f32) C.liquid_float_complex
// fn C.crealf(C.liquid_float_complex) f32
// fn C.cimagf(ComplexF32) f32

pub fn (this ComplexF32)real() f32{
	return this.real
}

pub fn (mut this ComplexF32)set_real(x f32) {
	this.real = x
}

pub fn (this ComplexF32)imag() f32 {
	return this.imag
}

pub fn (mut this ComplexF32)set_imag(y f32) {
	this.imag = y
}

// fn C.CMPLX(f64, f64) C.liquid_double_complex
// fn C.creal(C.liquid_double_complex) f64
// fn C.cimag(C.liquid_double_complex) f64

pub fn double_complex(r f64, i f64) ComplexF64{
	return ComplexF64{
		real: r,
		imag: i
	}
}

pub fn (this ComplexF64)str() string {
	x := this.real
	y := this.imag
	return 'ComplexF64: [${x}, ${y}]'
}

pub fn (this ComplexF64)real() f64 {
	return this.real
}
pub fn (mut this ComplexF64)set_real(x f64) {
	this.real = x
}

pub fn (this ComplexF64)imag() f64 {
	return this.imag
}
pub fn (mut this ComplexF64)set_imag(y f64) {
	this.imag = y
}

fn C.cabsf(z C.liquid_float_complex) f32
pub fn (this ComplexF32)abs() f32 {
	return C.cabsf(C.to_liquid_float_complex(this))
}

fn C.cabs(z C.liquid_double_complex) f64
pub fn (this ComplexF64)abs() f64 {
	return C.cabs(C.to_liquid_double_complex(this))
}

fn C.cargf(z C.liquid_float_complex) f32
pub fn (this ComplexF32)arg() f32 {
	return C.cargf(C.to_liquid_float_complex(this))
}

fn C.carg(z C.liquid_double_complex) f64
pub fn (this ComplexF64)arg() f64 {
	return C.carg(C.to_liquid_double_complex(this))
}

fn C.conjf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)conjugate() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.conjf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.conj(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)conjugate() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.conj(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

// Computes the projection of z on the Riemann sphere. //
fn C.cprojf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)project() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.cprojf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

// Computes the projection of z on the Riemann sphere. //
fn C.cproj(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)project() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.cproj(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.cexpf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)exp() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.cexpf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.cexp(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)exp() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.cexp(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.clogf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)log() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.clogf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.clog(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)log() ComplexF64{
	cthis := C.to_liquid_double_complex(this)
	z := C.clog(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.cpowf(x C.liquid_float_complex, y C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)pow(x ComplexF32, y ComplexF32) ComplexF32 {
	x1 := C.to_liquid_float_complex(x)
	y1 := C.to_liquid_float_complex(y)
	z := C.cpowf(x1, y1)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.cpow(x C.liquid_double_complex, y C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)pow(x ComplexF64, y ComplexF64) ComplexF64 {
	x1 := C.to_liquid_double_complex(x)
	y1 := C.to_liquid_double_complex(y)
	z := C.cpow(x1, y1)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.csqrtf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)sqrt() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.csqrtf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.csqrt(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)sqrt() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.csqrt(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.csinf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)sin() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.csinf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.csin(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)sin() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.csin(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.ccosf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)cos() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.ccosf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.ccos(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)cos() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.ccos(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.ctanf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)tan() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.ctanf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.ctan(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)tan() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.ctan(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.casinf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)asin() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.casinf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.casin(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)asin() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.casin(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.cacosf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)acos() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.cacosf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.cacos(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)acos() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.cacos(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.catanf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)atan() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.catanf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.catan(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)atan() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.catan(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.csinhf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)sinh() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.csinhf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.csinh(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)sinh() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.csinh(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.ccoshf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)cosh() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.ccoshf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.ccosh(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)cosh() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.ccosh(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.ctanhf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)tanh() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.ctanhf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.ctanh(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)tanh() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.ctanh(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.casinhf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)asinh() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.casinhf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.casinh(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)asinh() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.casinh(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.cacoshf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)acosh() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.cacoshf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.cacosh(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)acosh() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.cacosh(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.catanhf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this ComplexF32)atanh() ComplexF32 {
	cthis := C.to_liquid_float_complex(this)
	z := C.catanhf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.catanh(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this ComplexF64)atanh() ComplexF64 {
	cthis := C.to_liquid_double_complex(this)
	z := C.catanh(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

// Operator overloading for ComplexF32 //

pub fn (this ComplexF32)+(ref ComplexF32) ComplexF32 {
	x := this.real() + ref.real()
	y := this.imag() + ref.imag()
	z := float_complex(x, y)
	return z
}

// Operator overloading for ComplexF64 //

pub fn (this ComplexF64)+(ref ComplexF64) ComplexF64 {
	x := this.real() + ref.real()
	y := this.real() + ref.imag()
	z := double_complex(x, y)
	return z
}

// Copyright(C) 2021 Erdet Nasufi. All rights reserved. MIT License.

module vdsp

// float  = f32
// double = f64

#define to_liquid_float_complex(x) (liquid_float_complex)(*(liquid_float_complex *)&x)
#define from_liquid_float_complex(x) (vdsp__FloatComplex)(*(vdsp__FloatComplex *)&x)

#define to_liquid_double_complex(x) (liquid_double_complex)(*(liquid_double_complex *)&x)
#define from_liquid_double_complex(x) (vdsp__DoubleComplex)(*(vdsp__DoubleComplex *)&x)

fn C.to_liquid_float_complex(x FloatComplex) C.liquid_float_complex
fn C.from_liquid_float_complex(x C.liquid_float_complex) FloatComplex

fn C.to_liquid_double_complex(x DoubleComplex) C.liquid_double_complex
fn C.from_liquid_double_complex(x C.liquid_double_complex) DoubleComplex

[_pack: '1']
pub struct FloatComplex {
mut:
	real f32
	imag f32
}

[_pack: '1']
pub struct DoubleComplex {
mut:
	real f64
	imag f64
}    

// struct C.liquid_float_complex{}
// pub type FloatComplex = C.liquid_float_complex

// struct C.liquid_double_complex{}
// pub type DoubleComplex = C.liquid_double_complex

pub fn float_complex(r f32, i f32) FloatComplex {
	return FloatComplex {
		real: r,
		imag: i
	}
}
pub fn (this FloatComplex)str() string {
	x := this.real
	y := this.imag
	return 'FloatComplex: [${x}, ${y}]'
}

// fn C.CMPLXF(f32, f32) C.liquid_float_complex
// fn C.crealf(C.liquid_float_complex) f32
// fn C.cimagf(FloatComplex) f32

pub fn (this FloatComplex)real() f32{
	return this.real
}

pub fn (mut this FloatComplex)set_real(x f32) {
	this.real = x
}

pub fn (this FloatComplex)imag() f32 {
	return this.imag
}

pub fn (mut this FloatComplex)set_imag(y f32) {
	this.imag = y
}

// fn C.CMPLX(f64, f64) C.liquid_double_complex
// fn C.creal(C.liquid_double_complex) f64
// fn C.cimag(C.liquid_double_complex) f64

pub fn double_complex(r f64, i f64) DoubleComplex{
	return DoubleComplex{
		real: r,
		imag: i
	}
}

pub fn (this DoubleComplex)str() string {
	x := this.real
	y := this.imag
	return 'DoubleComplex: [${x}, ${y}]'
}

pub fn (this DoubleComplex)real() f64 {
	return this.real
}
pub fn (mut this DoubleComplex)set_real(x f64) {
	this.real = x
}

pub fn (this DoubleComplex)imag() f64 {
	return this.imag
}
pub fn (mut this DoubleComplex)set_imag(y f64) {
	this.imag = y
}

fn C.cabsf(z C.liquid_float_complex) f32
pub fn (this FloatComplex)abs() f32 {
	return C.cabsf(C.to_liquid_float_complex(this))
}

fn C.cabs(z C.liquid_double_complex) f64
pub fn (this DoubleComplex)abs() f64 {
	return C.cabs(C.to_liquid_double_complex(this))
}

fn C.cargf(z C.liquid_float_complex) f32
pub fn (this FloatComplex)arg() f32 {
	return C.cargf(C.to_liquid_float_complex(this))
}

fn C.carg(z C.liquid_double_complex) f64
pub fn (this DoubleComplex)arg() f64 {
	return C.carg(C.to_liquid_double_complex(this))
}

fn C.conjf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)conjugate() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.conjf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.conj(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)conjugate() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.conj(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

// Computes the projection of z on the Riemann sphere. //
fn C.cprojf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)project() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.cprojf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

// Computes the projection of z on the Riemann sphere. //
fn C.cproj(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)project() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.cproj(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.cexpf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)exp() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.cexpf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.cexp(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)exp() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.cexp(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.clogf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)log() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.clogf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.clog(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)log() DoubleComplex{
	cthis := C.to_liquid_double_complex(this)
	z := C.clog(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.cpowf(x C.liquid_float_complex, y C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)pow(x FloatComplex, y FloatComplex) FloatComplex {
	x1 := C.to_liquid_float_complex(x)
	y1 := C.to_liquid_float_complex(y)
	z := C.cpowf(x1, y1)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.cpow(x C.liquid_double_complex, y C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)pow(x DoubleComplex, y DoubleComplex) DoubleComplex {
	x1 := C.to_liquid_double_complex(x)
	y1 := C.to_liquid_double_complex(y)
	z := C.cpow(x1, y1)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.csqrtf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)sqrt() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.csqrtf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.csqrt(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)sqrt() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.csqrt(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.csinf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)sin() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.csinf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.csin(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)sin() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.csin(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.ccosf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)cos() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.ccosf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.ccos(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)cos() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.ccos(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.ctanf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)tan() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.ctanf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.ctan(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)tan() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.ctan(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.casinf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)asin() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.casinf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.casin(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)asin() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.casin(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.cacosf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)acos() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.cacosf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.cacos(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)acos() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.cacos(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.catanf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)atan() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.catanf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.catan(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)atan() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.catan(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.csinhf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)sinh() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.csinhf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.csinh(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)sinh() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.csinh(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.ccoshf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)cosh() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.ccoshf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.ccosh(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)cosh() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.ccosh(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.ctanhf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)tanh() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.ctanhf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.ctanh(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)tanh() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.ctanh(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.casinhf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)asinh() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.casinhf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.casinh(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)asinh() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.casinh(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.cacoshf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)acosh() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.cacoshf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.cacosh(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)acosh() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.cacosh(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

fn C.catanhf(z C.liquid_float_complex) C.liquid_float_complex
pub fn (mut this FloatComplex)atanh() FloatComplex {
	cthis := C.to_liquid_float_complex(this)
	z := C.catanhf(cthis)
	this = C.from_liquid_float_complex(z)
	return this
}

fn C.catanh(z C.liquid_double_complex) C.liquid_double_complex
pub fn (mut this DoubleComplex)atanh() DoubleComplex {
	cthis := C.to_liquid_double_complex(this)
	z := C.catanh(cthis)
	this = C.from_liquid_double_complex(z)
	return this
}

// Operator overloading for FloatComplex //

pub fn (this FloatComplex)+(ref FloatComplex) FloatComplex {
	x := this.real() + ref.real()
	y := this.imag() + ref.imag()
	z := float_complex(x, y)
	return z
}

// Operator overloading for DoubleComplex //

pub fn (this DoubleComplex)+(ref DoubleComplex) DoubleComplex {
	x := this.real() + ref.real()
	y := this.real() + ref.imag()
	z := double_complex(x, y)
	return z
}

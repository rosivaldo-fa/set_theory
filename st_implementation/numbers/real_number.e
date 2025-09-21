note
	description: "[
			Implementation of {STS_REAL_NUMBER}
			
			This implementation treats real numbers as if they were encoded by a 16-bit, base 2, IEEE 754-like, floating point number with the following
			parameters:
				sign bit: 1 bit;
				exponent width: 5 bits;
				significand (mantissa) precision: 11 bits (10 explicitly stored).
			Conceptual adapted value layout: s_e_eeee_mm_mmmm_mmmm (i.e. an IEEE 754-like binary16, or half precision, floating point number: 
				https://en.wikipedia.org/wiki/Half-precision_floating-point_format)
			
			I'd like to thank Jeroen van der Zijp, whose paper "Fast Half Float Conversions" (http://www.fox-toolkit.org/ftp/fasthalffloatconversion.pdf) gave me
			a clear understanding on how to represent, store and convert different sizes of IEEE 754-like binary floating-point numbers.
			
			Notice that, as stated at {STS_REAL_NUMBER} description, that specification (and this implementation)) does not try to offer a high-grade numeric
			class. Its intent is just to introduce examples of how several numeric types and sets may receive a set-theoretic treatment.
		]"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	REAL_NUMBER

inherit
	STS_REAL_NUMBER
		redefine
			default_create,
			out
		end

	DEBUG_OUTPUT
		rename
			debug_output as out
		redefine
			default_create,
			out
		end

create
	default_create,
	make,
	make_from_reference

convert
	make ({REAL}),
	make_from_reference ({STS_REAL_NUMBER, STS_RATIONAL_NUMBER, STS_INTEGER_NUMBER, STS_NATURAL_NUMBER})

feature {NONE} -- Initialization

	default_create
			-- Create a real number with `value' = 0
		do
			value_bit_pattern := 0
		ensure then
			value: value = 0
		end

	make (v: like value)
			-- Create a real number with `value' = `adjusted_value' (`v').
		do
			value_bit_pattern := bit_pattern_from_native_real (v)
		ensure
			adjusted_value: value = adjusted_value (v)
		end

	make_from_reference (x: STS_REAL_NUMBER)
			-- Create a real number with `value' = `adjusted_value' (`x'.`value').
			--| Notice that `x' might not conform to `Current', so `x'.`value' might not be kept intact after adjusted for current real type.
		do
			make (x.value)
		ensure
			adjusted_value: value = adjusted_value (x.value)
		end

feature -- Primitive

	value: like native_real_anchor
			-- <Precursor>
		local
			m: like value_bit_pattern
			sgn: like value.sign
			exp: like Exponent_bias
		do
			sgn := if sign_bit_status = 0 then 1 else -1 end
			exp := exponent_bit_pattern.as_integer_8 - Exponent_bias
			m := mantissa_bit_pattern
			if max_exponent < exp then
				if m = 0 then
					Result := sgn × {like value}.Positive_infinity
				else
					Result := c_copysign ({like value}.Nan, sgn)
				end
			elseif min_normal_exponent ≤ exp then
					-- Normal range
				Result := (sgn × (2 ^ exp) × (1 + m / Mantissa_scale)).truncated_to_real -- TODO: Get rid of truncated_to_real.
			elseif 0 < m then
					-- Subnormal range
				Result := (sgn × (2 ^ min_normal_exponent) × m / Mantissa_scale).truncated_to_real -- TODO: Get rid of truncated_to_real.
			else
				Result := sgn × {REAL} 0.0
			end
		ensure then
			el_sgn: attached if sign_bit_status = 0 then 1 else -1 end as el_sgn
			el_exp: attached (exponent_bit_pattern.as_integer_8 - Exponent_bias) as el_exp
			el_m: attached mantissa_bit_pattern as el_m

			when_nan: max_exponent < el_exp and el_m /= 0 ⇒ Result.is_nan
			when_huge: max_exponent < el_exp and el_m = 0 ⇒ Result = el_sgn × {like value}.Positive_infinity
			when_normal: min_normal_exponent ≤ el_exp and el_exp ≤ max_exponent ⇒
				Result = (el_sgn × (2 ^ el_exp) × (1 + el_m / Mantissa_scale)).truncated_to_real
			when_subnormal: el_exp < min_normal_exponent and 0 < el_m ⇒
				Result = (el_sgn × (2 ^ min_normal_exponent) × el_m / Mantissa_scale).truncated_to_real
			when_tiny: el_exp < min_normal_exponent and el_m = 0 ⇒ Result = el_sgn × 0
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := value.out
		ensure then
			definition: Result ~ value.out
		end

feature -- Math

	value_sign_bit (v: like native_real_anchor): like integer_anchor.value
			-- Status of the sign bit of `v', which is 1 for negative numbers but also, e.g. for a "negative" zero as specified by IEEE 754.
		external
			"C inline use <math.h>"
		alias
			"{
				return signbit ($v)? 1: 0;
			}"
		ensure
			class
			when_nan: v.is_nan ⇒ Result = 0 or Result = 1
			when_negative: not v.is_nan and v < 0 ⇒ Result = 1
			when_zero: v = 0 ⇒ Result = 0 or Result = 1
			when_positive: 0 < v ⇒ Result = 0
		end

	value_logb (v: like native_real_anchor): like native_real_anchor
			-- Exponent of `v', as a signed integer value in ﬂoating-point format. If `v' is subnormal it is treated as though it were normalized; thus, for
			-- positive ﬁnite `v', 1 ≤ `v' × (2 ^ − `value_logb' (`v')) < 2.
			--| Needed because {like real_math_anchor}.log_2 has rounding errors.
		external
			"C signature (float): float use <math.h>"
		alias
			"logbf"
		ensure
			class
			when_nan: v.is_nan implies Result.is_nan
			when_negative: not v.is_nan and v < 0 implies Result = value_logb (v.abs)
			when_zero: v = 0 implies Result.is_negative_infinity
			when_finite_positive: 0 < v and not v.is_positive_infinity implies 1 ≤ (v × (2 ^ − Result)) and v × (2 ^ − Result) < 2.
			when_positive_infinity: v.is_positive_infinity implies Result.is_positive_infinity
		end

feature -- Implementation

	adjusted_value (v: like value): like value
			-- <Precursor>
		local
			exp: like value
		do
			exp := value_logb (v)
			if max_exponent < exp then
				Result := v.sign × {like value}.positive_infinity
			elseif min_normal_exponent ≤ exp then
				Result := v × (2 ^ (Mantissa_width - exp)).truncated_to_real
				Result := Result.truncated_to_integer
				Result := Result / Mantissa_scale
				Result := (2 ^ exp).truncated_to_real × Result
			elseif min_subnormal_exponent ≤ exp then
				Result := v × (2 ^ (Mantissa_width.as_integer_8 - min_normal_exponent)).truncated_to_real
				Result := Result.truncated_to_integer
				Result := Result / Mantissa_scale
				Result := (2 ^ min_normal_exponent).truncated_to_real × Result
			else
				check
					no_surprising_nan: not (v.is_negative_infinity or v.is_positive_infinity) -- Otherwise Greatest_exponent < exp = +Infinity (see above.)
					nan_is_included: v.is_nan implies (0 × v).is_nan
				end
				Result := 0 × v
			end
		ensure then
			class
			el_exp: attached {like value} value_logb (v) as el_exp
			when_huge: max_exponent < el_exp implies Result = v.sign × {like value}.Positive_infinity
			when_normal: min_normal_exponent ≤ el_exp and el_exp <= max_exponent implies
				Result = (2 ^ el_exp).truncated_to_real × (v × (2 ^ (Mantissa_width - el_exp)).truncated_to_real).truncated_to_integer / Mantissa_scale
			when_subnormal: min_subnormal_exponent ≤ el_exp and el_exp < min_normal_exponent implies Result =
					(2 ^ min_normal_exponent).truncated_to_real × (v × (2 ^ (Mantissa_width.as_integer_8 - min_normal_exponent)).truncated_to_real).truncated_to_integer / Mantissa_scale
			when_tiny: el_exp < min_subnormal_exponent implies Result = 0 × v
		end

feature -- Anchor

	real_anchor: REAL_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

	integer_anchor: INTEGER_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

feature {NONE} -- Implementation

	bit_pattern_from_native_real (v: like value): like value_bit_pattern
			-- `v' converted to a bit pattern that represents the value of a real number like current
		local
			exp: like value
			s: like value_bit_pattern
			e: like Exponent_mask
			m: like Mantissa_mask
		do
			s := value_sign_bit (v).as_natural_16
			exp := value_logb (v)
			if max_exponent < exp then
				e := max_exponent_bit_pattern
				check
					m = 0
				end
			elseif min_normal_exponent ≤ exp then
				e := (exp.truncated_to_integer + Exponent_bias).as_natural_16 -- TODO: Get rid of as_natural_16?
				m := (v.abs × (2 ^ (Mantissa_width - exp))).truncated_to_integer.as_natural_16
				m := m & Mantissa_mask
			elseif min_subnormal_exponent <= exp then
				e := 0
				m := (v.abs × (2 ^ (Mantissa_width.as_integer_16 - min_normal_exponent))).truncated_to_integer.as_natural_16 -- TODO: get rid of as_integer_16 and as_natural_16?
			elseif {like value}.Nan < exp then
				e := 0
				m := 0
			else
				e := max_exponent_bit_pattern
				m := Max_mantissa
			end
			s := s |<< (Exponent_width + Mantissa_width)
			e := e |<< Mantissa_width
			Result := s | e | m
		ensure
			class
			el_s: attached value_sign_bit (v) as el_s
			el_exp: attached value_logb (v) as el_exp

			when_huge: max_exponent < el_exp ⇒ Result = (el_s |<< (Exponent_width + Mantissa_width)) | (max_exponent_bit_pattern |<< Mantissa_width) | 0
			when_normal: min_normal_exponent ≤ el_exp and el_exp ≤ max_exponent ⇒ Result =
					(el_s |<< (Exponent_width + Mantissa_width)) |
					((el_exp.truncated_to_integer + Exponent_bias).as_natural_16 |<< Mantissa_width) |
					((v.abs × (2 ^ (Mantissa_width - el_exp))).truncated_to_integer.as_natural_16 & Mantissa_mask)
			when_subnormal: min_subnormal_exponent <= el_exp and el_exp < min_normal_exponent ⇒ Result =
					(el_s |<< (Exponent_width + Mantissa_width)) |
					(0 |<< Mantissa_width) |
					(v.abs × (2 ^ (Mantissa_width.as_integer_16 - min_normal_exponent))).truncated_to_integer.as_natural_16
			when_above_nan: {like value}.Nan < el_exp and el_exp < min_subnormal_exponent ⇒ Result =
					(el_s |<< (Exponent_width + Mantissa_width)) |
					(0 |<< Mantissa_width) |
					0
			when_nan: el_exp.is_nan ⇒ Result =
					(el_s |<< (Exponent_width + Mantissa_width)) |
					(max_exponent_bit_pattern |<< Mantissa_width) |
					Max_mantissa
		end

	value_bit_pattern: NATURAL_16
			-- Bit pattern of the `value' of current real number

	sign_bit_status: like value_bit_pattern
			-- Status of the sign bit of `value_bit_pattern'
			-- Notice that, unlike `sign', it has only two possible values (0 or 1), and it may be non zero for, e.g. negative zero.
		do
			Result := value_bit_pattern |>> (Exponent_width + Mantissa_width)
			Result := Result & 1
		ensure
			definition: Result = (value_bit_pattern |>> (Exponent_width + Mantissa_width)) & 1
		end

	exponent_width: NATURAL_8 = 5
			-- How many bits a real number uses to represent its exponent

	exponent_mask,
			-- Binary mask for the exponent of a real number
	max_exponent_bit_pattern: like exponent_bit_pattern = 0b1_1111 -- 2 ^ `exponent_width' - 1
			-- Maximum biased value for the exponent of a real number

	exponent_bias, -- Bias value for the exponent of a real number
	max_exponent: like exponent_bit_pattern.as_integer_8 = 0b0_1111 -- `max_exponent_bit_pattern' // 2
			-- Maximum unbiased value for the exponent of a real number
			--| TODO: Get rid of as_integer_8

	exponent_bit_pattern: like value_bit_pattern
			-- Bit pattern that represents the exponent, on base 2, of current real number.
		do
			Result := value_bit_pattern |>> Mantissa_width
			Result := Result & Exponent_mask
		ensure
			definition: Result = (value_bit_pattern |>> Mantissa_width) & Exponent_mask
		end

	min_normal_exponent: like max_exponent = -14 -- 1 - `exponent_bias'
			-- Minimum unbiased value for the exponent of a normal real number

	min_subnormal_exponent: like max_exponent = -24 -- `min_normal_exponent' - `mantissa_width'
			-- Minimum unbiased value for the exponent of a subnormal real number

	mantissa_width: NATURAL_8 = 10
			-- Number of (explicit) bits used to store the mantissa of a real number

	mantissa_bit_pattern: like value_bit_pattern
			-- Bit pattern that represents the mantissa, on base 2, of current real number.
		do
			Result := value_bit_pattern & Mantissa_mask
		ensure
			definition: Result = value_bit_pattern & Mantissa_mask
		end

	mantissa_mask,
		-- Binary mask for the mantissa of a real number
	max_mantissa: like value_bit_pattern = 0b11_1111_1111 -- 2 ^ `mantissa_width' - 1
			-- Maximum value for the mantissa of a real number

	mantissa_scale: like Mantissa_mask = 0b100_0000_0000 -- 2 ^ `mantissa_width'
			-- Reference against wich the units of the mantissa of a real number are measured

	c_copysign (x, y: like real_anchor.value): like real_anchor.value
			-- Value with the magnitude of `x' and the sign of `y'. It produces a NaN (with the sign of `y') if `x' is a NaN.
		external
			"C signature (float, float): float use <math.h>"
		alias
			"copysignf"
		ensure
			class
			keep_magnitude: Result.abs = x.abs
			take_y_sign: value_sign_bit (Result) = value_sign_bit (y)
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end

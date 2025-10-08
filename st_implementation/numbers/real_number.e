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
			is_nan,
			is_negative_infinity,
			out,
			is_less,
			is_greater,
			three_way_comparison
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
	make_from_reference,
	make_from_bit_pattern,
	make_abs,
	make_opposite

convert
	make ({REAL}),
	make_from_reference ({STS_REAL_NUMBER, STS_RATIONAL_NUMBER, STS_INTEGER_NUMBER, STS_NATURAL_NUMBER}),
	value: {REAL, REAL_REF, NUMERIC, COMPARABLE, HASHABLE}

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

	make_from_bit_pattern (bp: like value_bit_pattern)
			-- Create a real number with `value' determined by `bp'
		require
			no_extra_bit: bp & (⊝ Value_bit_pattern_mask) = 0
		do
			value_bit_pattern := bp
		ensure
			value_bit_pattern: value_bit_pattern = bp
		end

	make_abs (x: REAL_NUMBER)
			-- Create a real number with value `x'.`value'.`abs'.
		do
			value_bit_pattern := x.value_bit_pattern & ⊝ ({NATURAL_8} 1 |<< (Exponent_width + Mantissa_width))
		ensure
			value: value = x.value.abs
		end

	make_opposite (x: REAL_NUMBER)
			-- Create a real number with value -`x'.`value'
		do
			value_bit_pattern := x.value_bit_pattern ⊕ ({NATURAL_16} 1 |<< (Exponent_width + Mantissa_width))
		ensure
			value: value = - x.value
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

feature -- Access

	sign_bit: like Integer_anchor
			-- Status of the sign bit of `value', which is 1 for negative numbers but also, e.g. for a "negative" zero as specified by IEEE 754.
			--| TODO: Natural instead?
		do
			check
					-- sign_bit_status.as_integer_8 ∈ {0, 1}
				big_enough: {INTEGER_NUMBER}.Native_min_value ≤ sign_bit_status.as_integer_8
				small_enough: sign_bit_status.as_integer_8 ≤ {INTEGER_NUMBER}.Native_max_value
			end
			create Result.make ((sign_bit_status.as_integer_8))
		ensure
			definition: Result.value = value_sign_bit (value)
		end

	zero: REAL_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

	one: REAL_NUMBER
			-- <Precursor>
		once
			Result := {REAL} 1.0
		ensure then
			class
		end

	machine_epsilon: REAL_NUMBER
			-- The difference between 1 and the least value greater than 1 that is representable by current kind of real number.
		local
			e: like Exponent_mask
		once
			e := (Exponent_bias.as_natural_8 - Mantissa_width) |<< Mantissa_width
			check
				no_extra_bit: ({NATURAL_8} 0 | e | 0) & (⊝ Value_bit_pattern_mask) = 0
				-- 0 | ((Exponent_bias - Mantissa_width) |<< Mantissa_width) | 0 < Value_bit_pattern_mask
			end
			create Result.make_from_bit_pattern ({NATURAL_8} 0 | e | 0) -- TODO: Get rid of {NATURAL_8}?
		ensure
			class
			definition: Result ≍ one.relative_epsilon
		end

	ulp,
	relative_epsilon: like real_anchor
			-- Unit in last place (ulp) of the floating representation of current real number
			--| This specifications follows the definition given at https://docs.julialang.org/en/v1/base/base/#Base.eps-Tuple{AbstractFloat}.
			--| TODO: Optimize it?
		do
			Result := abs
			if Max_value ≤ Result then
				Result := Result - Result.previous_float
			else
				Result := Result.next_float - Result
			end
		ensure
			when_huge_negative: previous_float.is_negative_infinity implies Result ≍ (next_float - Current)
			when_huge_positive: next_float.is_positive_infinity implies Result ≍ (Current - previous_float)
			ordinary_definition: not previous_float.is_negative_infinity and not next_float.is_positive_infinity implies Result ≍ (abs.next_float - abs)
		end

	epsilon: REAL_NUMBER
			-- Minimum normalized positive number representable by current kind of real number
		local
			e: like Exponent_mask
		once
			e := {NATURAL_8} 1 |<< Mantissa_width
			check
				no_extra_bit: ({NATURAL_8} 0 | e | 0) & (⊝ Value_bit_pattern_mask) = 0 -- 0 | (1 |<< Mantissa_width) | 0 < Value_bit_pattern_mask
			end
			create Result.make_from_bit_pattern ({NATURAL_8} 0 | e | 0)
		ensure
			class
			definition: Result.value = 2 ^ min_normal_exponent
		end

	previous_float: like real_anchor
			-- Greatest representable value that is less than current real number
		local
			e: like value_bit_pattern
			m: like value_bit_pattern
		do
			e := exponent_bit_pattern
			m := mantissa_bit_pattern
			if sign_bit_status = 0 then
				if e = max_exponent_bit_pattern then
					if m = 0 then
						check
							is_positive_infinity
						end
							-- Come down to `Max_value'
						check
							no_extra_bit: (value_bit_pattern - 1) & (⊝ Value_bit_pattern_mask) = 0
							-- value_bit_pattern - 1 < Value_bit_pattern_mask <== value_bit_pattern ≤ Value_bit_pattern_mask
						end
						create Result.make_from_bit_pattern (value_bit_pattern - 1)
					else
						check
							is_nan
						end
							-- Stay upon NaN.
						check
							no_extra_bit: value_bit_pattern & (⊝ Value_bit_pattern_mask) = 0 -- value_bit_pattern ≤ Value_bit_pattern_mask
						end
						create Result.make_from_bit_pattern (value_bit_pattern)
					end
				elseif e | m = 0 then
					check
						Current ≍ Zero
					end
						-- Flip sign and go to the tiniest negative value.
					check
						no_extra_bit: (({NATURAL_8} 1 |<< (Exponent_width + Mantissa_width)) | 0 | 1) & (⊝ Value_bit_pattern_mask) = 0
						-- ((1 |<< (Exponent_width + Mantissa_width)) | 0 | 1) < Value_bit_pattern_mask
					end
					create Result.make_from_bit_pattern (({NATURAL_8} 1 |<< (Exponent_width + Mantissa_width)) | 0 | 1)
				else
					check
						Zero < Current
					end
						-- Come one `ulp' down.
					check
						no_extra_bit: (value_bit_pattern - 1) & (⊝ Value_bit_pattern_mask) = 0
						-- value_bit_pattern - 1 < Value_bit_pattern_mask <== value_bit_pattern ≤ Value_bit_pattern_mask
					end
					create Result.make_from_bit_pattern (value_bit_pattern - 1)
				end
			else
				if e = max_exponent_bit_pattern then
					check
						is_nan or is_negative_infinity
					end
						-- Nothing changes.
					create Result.make_from_bit_pattern (value_bit_pattern)
				else
					check
						is_finite
						Current ≤ Zero
					end
						-- Come one `ulp' down.
					create Result.make_from_bit_pattern (value_bit_pattern + 1) -- The segative sign inverts the order.
				end
			end
		ensure
			when_nan: is_nan implies Result.is_nan
			when_negative_infinity: is_negative_infinity implies Result.is_negative_infinity
			ordinary_case: not is_nan and not is_negative_infinity implies Result < Current
				-- greatest_below: -- Please see `previous_float' post-condition of `is_greater'

			when_positive_infinity: is_positive_infinity implies Result ≍ Max_value

			el_exp: attached {like value} value_logb (value) as el_exp
			el_normal_v: attached {like value} (value / (2 ^ el_exp).truncated_to_real) as el_normal_v
			el_subnormal_v: attached {like value} (value / (2 ^ min_normal_exponent).truncated_to_real) as el_subnormal_v

			when_normal_positive_same_exponent: 0 < value and min_normal_exponent ≤ el_exp and (el_normal_v - 1) × Mantissa_scale > 0 implies
				Result.value = (2 ^ el_exp).truncated_to_real × (1 + ((el_normal_v - 1) × Mantissa_scale - 1) / Mantissa_scale)
			when_normal_positive_new_exponent_still_normal: 0 < value and min_normal_exponent < el_exp and (el_normal_v - 1) × Mantissa_scale = 0 implies
				Result.value = (2 ^ (el_exp - 1)).truncated_to_real × (1 + (Mantissa_scale - 1) / Mantissa_scale)
			when_normal_positive_new_subnormal_exponent: 0 < value and min_normal_exponent = el_exp and (el_normal_v - 1) × Mantissa_scale = 0 implies
				Result.value = (2 ^ el_exp).truncated_to_real × (Mantissa_scale - 1) / Mantissa_scale
			when_subnormal_positive: 0 < value and el_exp < min_normal_exponent implies
				Result.value = (2 ^ min_normal_exponent).truncated_to_real × (el_subnormal_v × Mantissa_scale - 1) / Mantissa_scale
			when_non_positive: Current ≤ Zero implies Result ≍ - abs.next_float
		end

	next_float: like real_anchor
			-- Least representable value that is greater than current real number
		local
			e: like value_bit_pattern
			m: like value_bit_pattern
		do
			e := exponent_bit_pattern
			m := mantissa_bit_pattern
			if sign_bit_status = 0 then
				if e = max_exponent_bit_pattern then
					check
						is_nan or is_positive_infinity
					end
						-- Nothing changes.
					check
						no_extra_bit: value_bit_pattern & (⊝ Value_bit_pattern_mask) = 0 -- value_bit_pattern ≤ Value_bit_pattern_mask
					end
					create Result.make_from_bit_pattern (value_bit_pattern)
				else
					check
						is_finite
						Zero ≤ Current
					end
						-- Go one `ulp' up.
					check
						no_extra_bit: (value_bit_pattern + 1) & (⊝ Value_bit_pattern_mask) = 0
						-- value_bit_pattern + 1 < Value_bit_pattern_mask <== is_finite
					end
					create Result.make_from_bit_pattern (value_bit_pattern + 1)
				end
			else
				if e = max_exponent_bit_pattern then
					if m = 0 then
						check
							is_negative_infinity
						end
							-- Go up to `Min_value'.
						check
							no_extra_bit: (value_bit_pattern - 1) & (⊝ Value_bit_pattern_mask) = 0
							-- value_bit_pattern - 1 < Value_bit_pattern_mask <== value_bit_pattern ≤ Value_bit_pattern_mask
						end
						create Result.make_from_bit_pattern (value_bit_pattern - 1) -- The segative sign inverts the order.
					else
						check
							is_nan
						end
							-- Stay upon NaN.
						check
							no_extra_bit: value_bit_pattern & (⊝ Value_bit_pattern_mask) = 0 -- value_bit_pattern ≤ Value_bit_pattern_mask
						end
						create Result.make_from_bit_pattern (value_bit_pattern)
					end
				elseif e | m = 0 then
					check
						negative_zero: Current ≍ Zero
					end
						-- Flip sign and go to the tiniest positive value.
					check
						no_extra_bit: ({NATURAL_8} 0 | 0 | 1) & (⊝ Value_bit_pattern_mask) = 0 -- By definition
					end
					create Result.make_from_bit_pattern ({NATURAL_8} 0 | 0 | 1) -- TODO: Get rid of {NATURAL_8}?
				else
					check
						is_finite
						Current < Zero
					end
						-- Go one `ulp' up.
					check
						no_extra_bit: (value_bit_pattern - 1) & (⊝ Value_bit_pattern_mask) = 0
						-- value_bit_pattern - 1 < Value_bit_pattern_mask <== is_finite
					end
					create Result.make_from_bit_pattern (value_bit_pattern - 1) -- The segative sign inverts the order.
				end
			end
		ensure
			when_nan: is_nan implies Result.is_nan
			when_positive_infinity: is_positive_infinity implies Result.is_positive_infinity
			ordinary_case: not is_nan and not is_positive_infinity implies Current < Result
				-- least_above: -- Please see `next_float' post-condition of `is_less'

			when_nan: is_nan implies Result.is_nan
			when_negative: Current < Zero implies Result ≍ - abs.previous_float
			when_sero: Current ≍ Zero implies Result.value = Epsilon.value / Mantissa_scale

			el_exp: attached {like value} value_logb (value) as el_exp

			when_sub_normal: Zero < Current and el_exp < min_normal_exponent implies
				Result.value = (2 ^ min_normal_exponent).truncated_to_real × ((value / (2 ^ min_normal_exponent).truncated_to_real) × Mantissa_scale + 1) / Mantissa_scale -- TODO: × and * have different precedences.
			when_normal: Zero < Current and min_normal_exponent ≤ el_exp and Current < Max_value implies
				Result.value = (2 ^ el_exp).truncated_to_real × (1 + ((value / (2 ^ el_exp).truncated_to_real - 1) × Mantissa_scale + 1) / Mantissa_scale)
			when_huge: Max_value ≤ Current implies Result.is_positive_infinity
		end

	max_value: REAL_NUMBER
			-- Maximum value representable by current kind of real number.
		local
			e: like Exponent_mask
			m: like value_bit_pattern
		once
			e := (max_exponent_bit_pattern - 1) |<< Mantissa_width
			m := Max_mantissa
			check
				no_extra_bit: ({NATURAL_8} 0 | e | m) & (⊝ Value_bit_pattern_mask) = 0
				-- 0 | ((max_exponent_bit_pattern - 1) |<< Mantissa_width) | Max_mantissa < Value_bit_pattern_mask
			end
			create Result.make_from_bit_pattern ({NATURAL_8} 0 | e | m) -- TODO: Get rid of {NATURAL_8}?
		ensure
			class
			definition: Result.value = (2 ^ max_exponent) × (1 + Max_mantissa / Mantissa_scale)
		end

feature -- Quality

	is_nan: BOOLEAN
			-- <Precursor>
		do
			Result := exponent_bit_pattern = max_exponent_bit_pattern and mantissa_bit_pattern /= 0
		end

	is_negative_infinity: BOOLEAN
			-- <Precursor>
		do
			Result := mantissa_bit_pattern = 0 and exponent_bit_pattern = max_exponent_bit_pattern and sign_bit_status = 1
		end

	is_negative_zero: BOOLEAN
			-- Is current the representation of a "negative" zero, as specified by IEEE 754?
		do
			Result := value_bit_pattern = {NATURAL_16} 1 |<< (Exponent_width + Mantissa_width)
		ensure
			definition: Result = (Current ≍ zero and sign_bit ≍ one.truncated_to_integer)
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := value.out
		ensure then
			definition: Result ~ value.out
		end

feature -- Comparison

	is_less alias "<" (x: STS_REAL_NUMBER): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {STS_REAL_NUMBER} (x)
		ensure then
			next_float: Result implies next_float ≤ x
		end

	is_greater alias ">" (x: STS_REAL_NUMBER): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {STS_REAL_NUMBER} (x)
		ensure then
			previous_float: Result implies x ≤ previous_float
		end

	three_way_comparison alias "⋚" (x: STS_REAL_NUMBER): like integer_anchor
			-- <Precursor>
		local
			v: like Integer_anchor.value
		do
			v := value ⋚ x.value
			check
				not_too_small: {INTEGER_NUMBER}.Native_min_value ≤ v.as_integer_8 -- {INTEGER_NUMBER}.Native_min_value ≤ -1
				not_too_big: v.as_integer_8 ≤ {INTEGER_NUMBER}.Native_max_value -- 1 ≤ {INTEGER_NUMBER}.Native_max_value
			end
			create Result.make (v.as_integer_8)
		end

feature -- Operation

	modulus,
	abs: like real_anchor
			-- Distance from current real number to the origin of the real number
			-- line
		do
			create Result.make_abs (Current)
		end

	minus alias "-" alias "−" (x: STS_REAL_NUMBER): like real_anchor
			-- Result of subtracting `x` from current real number
		do
			Result := real_from_value (value - x.value)
		ensure
			definition: Result ≍ real_from_value (value - x.value)
		end

	opposite alias "-" alias "−": like real_anchor
			-- <Precursor>
		do
			create Result.make_opposite (Current)
		end

feature -- Conversion

	truncated_to_integer: like integer_anchor
			-- <Precursor>
		do
			Result := value.truncated_to_integer
		end

feature -- Math

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

feature -- Factory

	real_from_value (v: like real_anchor.value): like real_anchor
			-- <Precursor>
		do
			create Result.make (v)
		ensure then
			class
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

feature {REAL_NUMBER} -- Implementation

	value_bit_pattern: NATURAL_16
			-- Bit pattern of the `value' of current real number

feature {NONE} -- Implementation

	sign_bit_status: like value_bit_pattern
			-- Status of the sign bit of `value_bit_pattern'
			-- Notice that, unlike `sign', it has only two possible values (0 or 1), and it may be non zero for, e.g. negative zero.
		do
			Result := value_bit_pattern |>> (Exponent_width + Mantissa_width)
			Result := Result & 1
		ensure
			definition: Result = (value_bit_pattern |>> (Exponent_width + Mantissa_width)) & 1
		end

	exponent_bit_pattern: like value_bit_pattern
			-- Bit pattern that represents the exponent, on base 2, of current real number.
		do
			Result := value_bit_pattern |>> Mantissa_width
			Result := Result & Exponent_mask
		ensure
			definition: Result = (value_bit_pattern |>> Mantissa_width) & Exponent_mask
		end

	mantissa_bit_pattern: like value_bit_pattern
			-- Bit pattern that represents the mantissa, on base 2, of current real number.
		do
			Result := value_bit_pattern & Mantissa_mask
		ensure
			definition: Result = value_bit_pattern & Mantissa_mask
		end

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

	min_normal_exponent: like max_exponent = -14 -- 1 - `exponent_bias'
			-- Minimum unbiased value for the exponent of a normal real number

	min_subnormal_exponent: like max_exponent = -24 -- `min_normal_exponent' - `mantissa_width'
			-- Minimum unbiased value for the exponent of a subnormal real number

	mantissa_width: NATURAL_8 = 10
			-- Number of (explicit) bits used to store the mantissa of a real number

	mantissa_mask,
		-- Binary mask for the mantissa of a real number
	max_mantissa: like value_bit_pattern = 0b11_1111_1111 -- 2 ^ `mantissa_width' - 1
			-- Maximum value for the mantissa of a real number

	mantissa_scale: like Mantissa_mask = 0b100_0000_0000 -- 2 ^ `mantissa_width'
			-- Reference against wich the units of the mantissa of a real number are measured

	value_bit_pattern_mask: like value_bit_pattern = 0b1_11111_1111111111 -- 2 ^ `value_bit_pattern_width' - 1
			-- Binary mask for the (codified) value of a real number
			--| TODO: Test.

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

note
	description: "[
					Model of a real number, i.e. a complex number whose imaginary part is zero.
			
					A finite representation, IEEE 754-like, is assumed, although with some minor changes it would allow even an implementation with real numbers
					of arbitrary precision. Anyway, this specification does not try to offer a high-grade numeric class. Its intent is just to introduce examples
					of how several numeric types and sets may receive a set-theoretic treatment.
			
					It is Noteworthy that this specification does not inherit from {NUMERIC} or {COMPARABLE}, since those classes use covariant arguments, which
					this library avoids as much as possible.
		]"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REAL_NUMBER

inherit
	ELEMENT
		rename
			is_in as element_is_in,
			is_not_in as element_is_not_in
		end

feature -- Primitive

	value: like native_real_anchor
			-- Native value of current real number
		deferred
		ensure
			adjusted: Result = adjusted_value (Result)
		end

feature -- Membership

	is_in alias "∈" (s: SET [REAL_NUMBER]): BOOLEAN
			-- Does `s` have current real number?
		do
			Result := s ∋ Current
		ensure
			definition: Result = s ∋ Current
		end

	is_not_in alias "∉" (s: SET [REAL_NUMBER]): BOOLEAN
			-- Is not current real number in `s'?
		do
			Result := not (Current ∈ s)
		ensure
			definition: Result = not (Current ∈ s)
		end

feature -- Access

	sign: like integer_anchor
			-- Sign of current number as an integer value (0, -1 or 1)
		do
			Result := Current ⋚ zero
		ensure
			three_way: Result ≍ (Current ⋚ zero)
		end

	zero: like real_anchor
			-- The real number 0
		deferred
		ensure
			definition: Result.value = 0
		end

	one: like real_anchor
			-- The real number 1
		deferred
		ensure
			definition: Result.value = 1
		end

	two: like real_anchor
			-- The real number 2
			--| Necessary for some specifications and properties
		deferred
		ensure
			definition: Result.value = 2
		end

feature -- Quality

	is_nan: BOOLEAN
			-- Is current the representation of NaN, i.e. does it represent no valid real number?
		do
			Result := value.is_nan
		ensure
			definition: Result = value.is_nan
			total_order: Result implies Current ≍ Current
		end

	is_negative_infinity: BOOLEAN
			-- Is current the representation of negative_infinity, i.e. is it not greater than any valid real number?
		do
			Result := value.is_negative_infinity
		ensure
			definition: Result = value.is_negative_infinity
		end

	is_positive_infinity: BOOLEAN
			-- Is current the representation of positive_infinity, i.e. is it not less than any valid real number?
		do
			Result := value.is_positive_infinity
		ensure
			definition: Result = value.is_positive_infinity
		end

	is_infinite: BOOLEAN
			-- Is current the representation of an infinity, i.e. either it `is_negative_infinity' or `is_positive_infinity'?
		do
			Result := is_negative_infinity or is_positive_infinity
		ensure then
			real_definition: Result = (is_negative_infinity or is_positive_infinity)
		end

	is_finite: BOOLEAN
			-- Is current the representation of a finite real number, i.e. neither it `is_nan' or `is_infinite'?
		do
			Result := not (is_nan or is_infinite)
		ensure then
			real_definition: Result = not (is_nan or is_infinite)
		end

	is_rational: BOOLEAN
			-- Does current real number represent a rational number?
		deferred
		ensure then
			splitted_one: attached splitted (one) as splitted_one
			a: attached splitted_one.a as a
			b: attached splitted_one.b as b
			real_definition: Result = (
				(a.is_integer or zero.truncated_to_integer.max_value_exists and then (a - one) ≍ zero.truncated_to_integer.max_value) and
				(b.is_integer or zero.truncated_to_integer.max_value_exists and then (b - one) ≍ zero.truncated_to_integer.max_value)
				)
		end

	is_integer: BOOLEAN
			-- Does current real number represent an integer number?
		do
			Result := Current ≍ truncated_to_integer
		ensure then
			real_definition: Result = Current ≍ truncated_to_integer
		end

	is_natural: BOOLEAN
			-- Does current real number represent a natural number?
		do
			Result := is_integer and zero ≤ Current
		ensure
			definition: Result = (is_integer and zero ≤ Current)
		end

	is_invertible: BOOLEAN
			-- Does current real number have a multiplicative inverse (AKA reciprocal)?
			-- Notice that the real_quasi_definition post-condition allows an implementation to regard zero as invertible.
		do
			Result := Current ≭ zero
		ensure then
			real_quasi_definition: Current ≭ zero ⇒ Result
		end

feature -- Comparison

	equals alias "≍" (x: REAL_NUMBER): BOOLEAN
			-- Do current real number and `x' have the same numeric value?
			--| Please have a look at the note in the header of {SET}.equals.
		do
			Result := value = x.value
		ensure
			definition: Result = (value = x.value)
		end

	unequals alias "≭" (x: REAL_NUMBER): BOOLEAN
			-- Does not current real number equal `x'?
		do
			Result := not (Current ≍ x)
		ensure
			definition: Result = not (Current ≍ x)
		end

	is_less alias "<" (x: REAL_NUMBER): BOOLEAN
			-- Is current real number less than `x'?
		do
			Result := value < x.value
		ensure
			definition: Result = (value < x.value)
		end

	is_less_equal alias "<=" alias "≤" (x: REAL_NUMBER): BOOLEAN
			-- Is current real number less than or equal to `x'?
		do
			Result := Current < x or Current ≍ x
		ensure
			definition: Result = (Current < x or Current ≍ x)
		end

	is_greater alias ">" (x: REAL_NUMBER): BOOLEAN
			-- Is current real number greater than `x'?
		do
			Result := x < Current
		ensure
			definition: Result = (x < Current)
		end

	three_way_comparison alias "⋚" (x: REAL_NUMBER): like integer_anchor
			-- If current real number equal to `x', 0; if smaller, -1; if greater, 1.
		do
			if Current < x then
				Result := - one.truncated_to_integer
			elseif Current ≍ x then
				Result := zero.truncated_to_integer
			else
				Result := one.truncated_to_integer
			end
		ensure
			equal_zero: (Result ≍ zero.truncated_to_integer) = (Current ≍ x)
			smaller_negative: (Result ≍ - one.truncated_to_integer) = (Current < x)
			greater_positive: (Result ≍ one.truncated_to_integer) = (Current > x)
		end

feature -- Relationship

	divisible (x: REAL_NUMBER): BOOLEAN
			-- May current real number be divided by `x`?
		do
			Result := x.is_invertible
		ensure
			definition: Result = x.is_invertible
		end

feature -- Operation

	modulus,
	abs: like real_anchor
			-- Distance from current real number to the origin of the real line
		do
			Result := real_from_value (value.abs)
		ensure
			definition: Result ≍ real_from_value (value.abs)
		end

	minus alias "-" alias "−" (x: REAL_NUMBER): like real_anchor
			-- Result of subtracting `x` from current real number
		do
			Result := real_from_value (value - x.value)
		ensure
			definition: Result ≍ real_from_value (value - x.value)
		end

	product alias "*" alias "×" alias "⋅" (x: REAL_NUMBER): like real_anchor
			-- Current real number multiplied by `x`
		do
			Result := real_from_value (value × x.value)
		ensure
			definition: Result ≍ real_from_value (value × x.value)
		end

	quotient alias "/" alias "÷" (x: REAL_NUMBER): like real_anchor
			-- Division of current real number by `x`
			-- Notice that quasi_definition post-condition allows an implementation to regard `zero' a good divisor.
		require
			good_divisor: divisible (x)
		do
				check
					good_divisor: value.divisible (x.value) -- x.is_invertible <== divisible (x)
				end
			Result := real_from_value (value / x.value)
		ensure
			quasi_definition: value.divisible (x.value) implies Result ≍ real_from_value (value / x.value)
		end

feature -- Conversion

	to_rational: like rational_anchor
			-- Rational representation of current real number
			-- TODO: Properties, tests
		require
			is_rational: is_rational
		deferred
		ensure
			splitted_one: attached splitted (one) as splitted_one
			a: attached splitted_one.a as a
			b: attached splitted_one.b as b
			numerator: a.abs ≍ Result.p.rational_abs
			denominator: b.abs ≍ Result.q.rational_abs
			same_sign: Result.sign ≍ sign
		end

	truncated_to_integer: like integer_anchor
			-- Integer part (same sign, largest absolute value no greater than current real number's)
		deferred
		ensure
			definition: Result.value = Result.adjusted_value (value.truncated_to_integer)
		end

feature -- Factory

	real_from_value (v: like native_real_anchor): like real_anchor
			-- Real number whose value is {REAL_NUMBER}.adjusted_value (`v')
		deferred
		ensure
			definition: Result.value = Result.adjusted_value (v)
		end

feature -- Math

	splitted (q: REAL_NUMBER): TUPLE [a, b: REAL_NUMBER]
			-- Current real number represented as a tuple [a, b] = [`Current' ⋅ (2 ^ k), `q' ⋅ (2 ^ k)], k ∈ ℕ.
		deferred
		ensure
				-- TODO: Get rid of `floor_real_32'.
			when_integral: value = value.floor_real_32 ⇒ Result.a ≍ Current and Result.b ≍ q
			when_fractional: value /= value.floor_real_32 ⇒ Result.a ≍ (Current ⋅ two).splitted (q ⋅ two).a and Result.b ≍ (Current ⋅ two).splitted (q ⋅ two).b
		end

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

feature -- Implementation

	adjusted_value (v: like value): like value
			-- `v' adjusted to represent the `value' of a real number like current
		deferred
		ensure
			stable: adjusted_value (Result) = Result
		end

feature -- Anchor

	native_real_anchor: REAL
			-- Anchor for native representation of real numbers
		once
		ensure
			class
		end

	real_anchor: REAL_NUMBER
			-- Anchor for real numbers
		deferred
		end

	rational_anchor: RATIONAL_NUMBER
			-- Anchor for rational numbers
		deferred
		end

	integer_anchor: INTEGER_NUMBER
			-- Anchor for integer numbers
		deferred
		end

	real_math_anchor: SINGLE_MATH
			-- Anchor for accessing basic mathematical operations on native real numbers
		once
			create Result
		ensure
			class
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end

note
	description: "Implementation of {STS_INTEGER_NUMBER}"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	INTEGER_NUMBER

inherit
	STS_INTEGER_NUMBER
		redefine
			default_create,
			sign,
			out,
			rational_min,
			rational_max,
			three_way_comparison,
			min,
			max,
			rational_modulus,
			rational_abs,
			converted_integer
		end

	DEBUG_OUTPUT
		rename
			debug_output as out
		undefine
			default_create
		redefine
			out
		end

create
	default_create,
	make,
	make_from_reference

convert
	make ({INTEGER}),
	make_from_reference ({STS_INTEGER_NUMBER}),
	as_rational: {RATIONAL_NUMBER}

feature {NONE} -- Initialization

	default_create
			-- Create an integer number with value = 0
		do
			stored_value := 0
		ensure then
			value: value = 0
		end

	make (v: like value)
			-- Create an integer number out of value `v'.
		do
			stored_value := v.as_integer_8
		ensure
			value: value = adjusted_value (v)
		end

	make_from_reference (i: STS_INTEGER_NUMBER)
			-- Create an integer number with value `i'.`value'.
		do
			make (i.value)
		ensure
			value: value = adjusted_value (i.value)
		end

feature -- Primitive

	value: like native_integer_anchor
			-- <Precursor>
		do
			Result := stored_value
		end

feature -- Access

	sign: like integer_anchor
			-- <Precursor>
		do
				check
					not_too_small: Native_min_value ≤ stored_value.sign -- -1 ≤ stored_value.sign
					not_too_big: stored_value.sign ≤ Native_max_value -- stored_value.sign ≤ 1
				end
			create Result.make (stored_value.sign)
		end

	Zero: INTEGER_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

	One: INTEGER_NUMBER
			-- <Precursor>
		once
			create Result.make (1)
		ensure then
			class
		end

	Min_value: INTEGER_NUMBER
			-- Minimum value representable by this implementation of integer numbers
		require else
			Min_value_exists: True
		once
			Result := Native_min_value.as_integer_32
		ensure then
			class
			definition: Result ≍ (- Max_value - One)
		end

	Max_value: INTEGER_NUMBER
			-- Maximum value representable by this implementation of integer numbers
		require else
			Max_value_exists: True
		once
			Result := Native_max_value.as_integer_32
		ensure then
			class
			definition: Result.value = Native_max_value
		end

feature -- Quality

	min_value_exists: BOOLEAN = True
			-- <Precursor>

	max_value_exists: BOOLEAN = True
			-- <Precursor>

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := stored_value.out
		ensure then
			definition: Result ~ value.out
		end

feature -- Comparison

	rational_min (pq: STS_RATIONAL_NUMBER): like Rational_anchor
			-- <Precursor>
		do
			Result := as_rational ∧ pq
		end

	rational_max (pq: STS_RATIONAL_NUMBER): like Rational_anchor
			-- <Precursor>
		do
			Result := as_rational ∨ pq
		end

	three_way_comparison alias "⋚" (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (value ⋚ i.value)
		end

	min alias "∧" (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (stored_value ∧ i.value)
		end

	max alias "∨" (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (stored_value ∨ i.value)
		end

feature -- Operation

	rational_modulus,
	rational_abs: like rational_anchor
			-- <Precursor>
		do
			Result := as_rational.abs
		end

	rational_opposite: like rational_anchor
			-- <Precursor>
		do
			Result := - as_rational
		end

	modulus,
	abs: like integer_anchor
			-- <Precursor>
		do
			create Result.make (stored_value.abs)
		end

	plus alias "+" (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (stored_value + i.value)
		end

	minus alias "-" alias "−" (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (stored_value - i.value)
		end

	opposite alias "-" alias "−": like integer_anchor
			-- <Precursor>
		do
			create Result.make (- stored_value)
		end

	product alias "*" alias "×" alias "⋅" (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (stored_value * i.value)
		end

	quotient alias "/" alias "÷" (i: STS_INTEGER_NUMBER): like rational_anchor
			-- <Precursor>
		do
			create Result.make (Current, i)
		end

	integer_quotient alias "//" (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			check
--					good_divisor: stored_value.to_integer_32.divisible (i.value) -- i.value /= 0 ⇐ divisible (i) -- TODO: Segmentation violation.
				good_divisor: i.value /= 0
			end
			create Result.make (stored_value // i.value)
		end

	integer_remainder alias "\\" (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			check
--					good_divisor: stored_value.to_integer_32.divisible (i.value) -- i.value /= 0 ⇐ divisible (i) -- TODO: Segmentation violation.
				good_divisor: i.value /= 0
			end
			create Result.make (stored_value \\ i.value)
		end

--feature -- Math

--	gcd (i, j: STS_INTEGER_NUMBER): like integer_anchor
--			-- Greatest common divisor of `i' and `j'
--		do
--			if j ≍ zero then
--				Result := i.abs.value
--			else
--					check
--						good_divisor: i.divisible (j) -- j /= 0
--					end
--				Result := gcd (j, i \\ j)
--			end
--		ensure
--			base: j ≍ zero implies Result ≍ i.abs
--			good_divisor: j ≭ zero implies i.divisible (j)
--			induction: j ≭ zero implies Result ≍ gcd (j, i \\ j)
--		end

feature -- Conversion

	as_rational: like Rational_anchor
			-- Current integer number represented as a rational number
		do
			create Result.make (Current, One)
		ensure
			numerator: Result.p ≍ Current
			denominator: Result.q ≍ One
		end

feature -- Implementation

	adjusted_value (v: like value): like value
			-- <Precursor>
		do
			Result := v.as_integer_8
		ensure then
			class
			definition: Result = v.as_integer_8
		end

feature -- Factory

	converted_integer (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			Result := {RATIONAL_NUMBER}.converted_integer (i)
		ensure then
			class
		end

feature -- Anchor

	integer_anchor: INTEGER_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

	native_integer_anchor: INTEGER
			-- <Precursor>
		once
		ensure then
			class
		end

	rational_anchor: RATIONAL_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

feature {NONE} -- Implementation

	stored_value: INTEGER_8;
			-- Bit pattern of the `value' of current integer number

	native_min_value: INTEGER_8 = - 128
			-- Native minimum value representable by this implementation of integer numbers

	native_max_value: INTEGER_8 = 127
			-- Native maximum value representable by this implementation of integer numbers

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end

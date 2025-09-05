note
	description: "Implementation of {STS_NATURAL_NUMBER}"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	NATURAL_NUMBER

inherit
	STS_NATURAL_NUMBER
		redefine
			default_create,
			sign,
			is_natural,
			out,
			rational_three_way_comparison,
			rational_min,
			rational_max,
			integer_three_way_comparison,
			integer_min,
			integer_max,
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
	make ({NATURAL}),
	make_from_reference ({STS_NATURAL_NUMBER}),
	as_integer: {INTEGER_NUMBER},
	as_rational: {RATIONAL_NUMBER}

feature {NONE} -- Initialization

	default_create
			-- Create a natural number with value = 0
		do
			stored_value := 0
		ensure then
			value: value = 0
		end

	make (v: like value)
			-- Create a natural number out of value `v'.
		do
			stored_value := v.as_natural_8 & Stored_value_mask
		ensure
			value: value = adjusted_value (v)
		end

	make_from_reference (n: STS_NATURAL_NUMBER)
			-- Create a natural number with value `n'.`value'.
		do
			make (n.value)
		ensure
			value: value = adjusted_value (n.value)
		end

feature -- Primitive

	integer_value: like native_integer_anchor
			-- <Precursor>
		do
			Result := stored_value
		end

	value: like native_natural_anchor
			-- <Precursor>
		do
			Result := stored_value
		end

feature -- Access

	sign: like Integer_anchor
			-- <Precursor>
		do
			Result := Current ⋚ Zero
		end

	Zero: NATURAL_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

	One: NATURAL_NUMBER
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

	is_natural: BOOLEAN = True
			-- <Precursor>

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

	rational_three_way_comparison (pq: STS_RATIONAL_NUMBER): like integer_anchor
			-- <Precursor>
		do
			if rational_is_less (pq) then
				Result := -1
			elseif rational_equals (pq) then
				Result := 0
			else
				Result := 1
			end
		end

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

	integer_three_way_comparison (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (integer_value ⋚ i.value)
		end

	integer_min (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (stored_value ∧ i.value)
		end

	integer_max (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (stored_value ∨ i.value)
		end

	three_way_comparison alias "⋚" (n: STS_NATURAL_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (value ⋚ n.value)
		end

	min alias "∧" (n: STS_NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			create Result.make (stored_value ∧ n.value)
		end

	max alias "∨" (n: STS_NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			create Result.make (stored_value ∨ n.value)
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

	integer_plus (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (stored_value + i.value)
		end

	integer_minus (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (stored_value - i.value)
		end

	integer_product (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (stored_value * i.value)
		end

	integer_quotient (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			check
				good_divisor: i.value /= 0 -- good_divisor precondition
			end
			create Result.make (stored_value // i.value)
		end

	integer_remainder (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			check
				good_divisor: i.value /= 0 -- good_divisor precondition
			end
			create Result.make (stored_value \\ i.value)
		end

	plus alias "+" (n: STS_NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			create Result.make (stored_value + n.value)
		end

	minus alias "-" alias "−" (n: STS_NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			create Result.make (stored_value - n.value)
		end

	opposite alias "-" alias "−": like integer_anchor
			-- <Precursor>
		do
			create Result.make (- integer_value)
		end

	product alias "*" alias "×" alias "⋅" (n: STS_NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			create Result.make (stored_value * n.value)
		end

	quotient alias "/" alias "÷" (i: STS_INTEGER_NUMBER): like rational_anchor
			-- <Precursor>
		do
			create Result.make (Current, i)
		end

	natural_quotient alias "//" (n: STS_NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			check
--					good_divisor: stored_value.to_natural_32.divisible (n.value) -- n.value /= 0 ⇐ divisible (n) -- TODO: Segmentation violation.
				good_divisor: n.value /= 0
			end
			create Result.make (stored_value // n.value)
		end

	natural_remainder alias "\\" (n: STS_NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			check
--					good_divisor: stored_value.to_natural_32.divisible (n.value) -- n.value /= 0 ⇐ divisible (n) -- TODO: Segmentation violation.
				good_divisor: n.value /= 0
			end
			create Result.make (stored_value \\ n.value)
		end

feature -- Conversion

	as_rational: like Rational_anchor
			-- Current natural number represented as a rational number
		do
			create Result.make (Current, One)
		ensure
			numerator: Result.p ≍ Current
			denominator: Result.q ≍ One
		end

	as_integer: like Integer_anchor
			-- Current natural number represented as an integer number
		do
			create Result.make (stored_value)
		ensure
			value: Result.value = value.as_integer_32
		end

feature -- Factory

	converted_integer (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			Result := {RATIONAL_NUMBER}.converted_integer (i)
		ensure then
			class
		end

feature -- Implementation

	integer_adjusted_value (v: like integer_value): like integer_value
			-- <Precursor>
		do
			Result := {INTEGER_NUMBER}.adjusted_value (v)
		ensure then
			class
			definition: Result = {INTEGER_NUMBER}.adjusted_value (v)
		end

	adjusted_value (v: like value): like value
			-- <Precursor>
		do
			Result := v & Stored_value_mask
		ensure then
			class
			definition: Result = v & Stored_value_mask
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

	natural_anchor: NATURAL_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

	native_natural_anchor: NATURAL
			-- <Precursor>
		do
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

	stored_value: NATURAL_8;
		-- Bit pattern of the `value' of current natural number

	stored_value_mask: like stored_value = 0b0111_1111
			-- Binary mask for the (stored) value of a natural number

	native_min_value: INTEGER_8 = -128
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

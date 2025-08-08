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
			out,
			integer_three_way_comparison,
			integer_min,
			integer_max,
			three_way_comparison,
			min,
			max
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
	make

convert
	make ({NATURAL})

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

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := stored_value.out
		ensure then
			definition: Result ~ value.out
		end

feature -- Comparison

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

feature {NONE} -- Implementation

	stored_value: NATURAL_8;
		-- Bit pattern of the `value' of current natural number

	stored_value_mask: like stored_value = 0b1111111
			-- Binary mask for the (stored) value of a natural number

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end

note
	description: "Implementation of {NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	EFFECTIVE_NATURAL_NUMBER

inherit
	NATURAL_NUMBER
		redefine
			default_create,
			out,
			min,
			max
		end

	DEBUG_OUTPUT
		redefine
			default_create,
			out
		end

create
	default_create,
	make,
	make_from_reference

convert
	make ({NATURAL}),
	make_from_reference ({NATURAL_NUMBER})

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

	make_from_reference (n: NATURAL_NUMBER)
			-- Create a natural number with value `n'.`value'.
		do
			make (n.value)
		ensure
			value: value = adjusted_value (n.value)
		end

feature -- Primitive

	value: like native_natural_anchor
			-- <Precursor>
		do
			Result := stored_value
		end

feature -- Access

	Zero: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

	One: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			create Result.make (1)
		ensure then
			class
		end

	Max_value: EFFECTIVE_NATURAL_NUMBER
			-- Maximum value representable by this implementation of natural numbers
			--| NOTICE: Every natural number must be an integer number, hence the need for the quotient {like stored_value}.Max_value \\ 2.
		once
			Result := adjusted_value ({like stored_value}.Max_value // 2)
		ensure then
			class
			definition: Result.value = {like stored_value}.Max_value // 2
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := stored_value.out
		ensure then
			definition: Result ~ stored_value.out
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- <Precursor>
		do
			Result := stored_value.out
		ensure then
			definition: Result ~ stored_value.out
		end

feature -- Comparison

	min alias "∧" (n: NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			create Result.make (stored_value ∧ n.value)
		end

	max alias "∨" (n: NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			create Result.make (stored_value ∨ n.value)
		end

feature -- Operation

	plus alias "+" (n: NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			create Result.make (stored_value + n.value)
		end

	minus alias "-" alias "−" (n: NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			create Result.make (stored_value - n.value)
		end

	product alias "*" alias "×" alias "⋅" (n: NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			create Result.make (stored_value * n.value)
		end

	natural_quotient alias "//" (n: NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			check
--					good_divisor: stored_value.to_natural_32.divisible (n.value) -- n.value /= 0 ⇐ divisible (n) -- TODO: Segmentation violation.
				good_divisor: n.value /= 0
			end
			create Result.make (stored_value // n.value)
		end

	natural_remainder alias "\\" (n: NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			check
--					good_divisor: stored_value.to_natural_32.divisible (n.value) -- n.value /= 0 ⇐ divisible (n) -- TODO: Segmentation violation.
				good_divisor: n.value /= 0
			end
			create Result.make (stored_value \\ n.value)
		end

feature -- Implementation

	adjusted_value (v: like value): like value
			-- <Precursor>
		do
			Result := v & Stored_value_mask
		ensure then
			class
			definition: Result = v & Stored_value_mask
		end

feature -- Anchor

	natural_anchor: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		do
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

	stored_value: NATURAL_8
		-- Bit pattern of the `value' of current natural number

	stored_value_mask: like stored_value = 0b0111_1111
			-- Binary mask for the (stored) value of a natural number

invariant
	Max_value: Current ≤ Max_value

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end

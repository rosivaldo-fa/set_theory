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
			out,
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
	make ({INTEGER})

feature {NONE} -- Initialization

	default_create
			-- Create a integer number with value = 0
		do
			stored_value := 0
		ensure then
			value: value = 0
		end

	make (v: like value)
			-- Create a integer number out of value `v'.
		do
			stored_value := v.as_integer_8
		ensure
			value: value = adjusted_value (v)
		end

feature -- Primitive

	value: like native_integer_anchor
			-- <Precursor>
		do
			Result := stored_value
		end

feature -- Access

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

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := stored_value.out
		ensure then
			definition: Result ~ value.out
		end

feature -- Comparison

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

	product alias "*" alias "×" alias "⋅" (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			create Result.make (stored_value * i.value)
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

feature -- Implementation

	adjusted_value (v: like value): like value
			-- <Precursor>
		do
			Result := v.as_integer_8
		ensure then
			class
			definition: Result = v.as_integer_8
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
		do
		ensure then
			class
		end

feature {NONE} -- Implementation

	stored_value: INTEGER_8;
	-- Bit pattern of the `value' of current integer number

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end

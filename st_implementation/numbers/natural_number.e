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
			min
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

feature -- Comparison

	min alias "∧" (n: STS_NATURAL_NUMBER): like natural_anchor
			-- <Precursor>
		do
			create Result.make (stored_value ∧ n.value)
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

note
	description: "Implementation of {NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	EFFECTIVE_NATURAL_NUMBER

inherit
	NATURAL_NUMBER
		redefine
			default_create
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

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end

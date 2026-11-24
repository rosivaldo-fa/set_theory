note
	description: "Implementation of {INTEGER_NUMBER}"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	EFFECTIVE_INTEGER_NUMBER

inherit
	INTEGER_NUMBER
		redefine
			default_create
		end

create
	default_create,
	make,
	make_from_reference

convert
	make ({INTEGER}),
	make_from_reference ({INTEGER_NUMBER})

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

	make_from_reference (i: INTEGER_NUMBER)
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

	native_integer_anchor: INTEGER
			-- <Precursor>
		once
		ensure then
			class
		end

feature {NONE} -- Implementation

	stored_value: INTEGER_8;
			-- Bit pattern of the `value' of current integer number

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end

note
	description: "Implementation of {STS_NATURAL_NUMBER}"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	NATURAL_NUMBER

inherit
	STS_NATURAL_NUMBER

feature -- Primitive

	value: like native_natural_anchor
			-- <Precursor>
		do
			Result := stored_value
		end

feature -- Anchor

	native_natural_anchor: NATURAL
			-- <Precursor>
		do
		ensure then
			class
		end

feature {NONE} -- Implementation

	stored_value: NATURAL_8;
			-- Bit pattern of the `value' of current natural number

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

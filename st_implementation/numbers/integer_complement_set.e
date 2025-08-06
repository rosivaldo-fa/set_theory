note
	description: "Set whose integer-number elements are those not included in a given reference set"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_COMPLEMENT_SET

inherit
	STS_INTEGER_SET
		redefine
			out
		end

	COMPLEMENT_SET [STS_INTEGER_NUMBER]
		rename
			extended as set_extended,
			u as z,
			universe as integer_numbers
		redefine
			z,
			integer_numbers,
			out,
			subset_anchor
		end

create
	make

feature -- Construction

	extended (a_n: INTEGER_NUMBER): like integer_superset_anchor
			-- <Precursor>
		do
			create Result.make_extended (a_n, Current)
		end

feature -- Access

	z, integer_numbers: UNIVERSE [STS_INTEGER_NUMBER]
			-- <Precursor>
		once
			create Result
		ensure then
			class
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := {UTF_CONVERTER}.string_32_to_utf_8_string_8 ("∁ (")
			Result.append (reference_set.out)
			Result.append_character (')')
		ensure then
			definition: Result ~ {UTF_CONVERTER}.string_32_to_utf_8_string_8 ("∁ (") + reference_set.out + ")"
		end

feature -- Anchor

	subset_anchor: INTEGER_COMPLEMENT_SET
			-- <Precursor>
		do
			Result := Current
		end

	integer_superset_anchor: INTEGER_SET
			-- <Precursor>
		do
			create Result
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

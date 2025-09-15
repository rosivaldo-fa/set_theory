note
	description: "Set whose rational-number elements are those not included in a given reference set"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	RATIONAL_COMPLEMENT_SET

inherit
	STS_RATIONAL_SET
		redefine
			out
		end

	COMPLEMENT_SET [STS_RATIONAL_NUMBER]
		rename
			extended as set_extended,
			u as q,
			universe as rational_numbers
		redefine
			q,
			rational_numbers,
			out,
			subset_anchor
		end

create
	make

feature -- Construction

	extended (pq: RATIONAL_NUMBER): like rational_superset_anchor
			-- <Precursor>
		do
			create Result.make_extended (pq, Current)
		end

feature -- Access

	q, rational_numbers: RATIONAL_NUMBERS
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

	subset_anchor: RATIONAL_COMPLEMENT_SET
			-- <Precursor>
		do
			Result := Current
		end

	rational_superset_anchor: RATIONAL_SET
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

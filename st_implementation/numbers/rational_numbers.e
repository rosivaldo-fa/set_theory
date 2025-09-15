note
	description: "Implementation of {STS_RATIONAL_NUMBERS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	RATIONAL_NUMBERS

inherit
	STS_RATIONAL_NUMBERS
		undefine
			does_not_have
		redefine
			out
		end

	UNIVERSE [STS_RATIONAL_NUMBER]
		rename
			extended as set_extended,
			u as q,
			universe as rational_numbers
		redefine
			prunned,
			out,
			subset_anchor,
			superset_anchor
		end

feature -- Construction

	extended (pq: STS_RATIONAL_NUMBER): like rational_superset_anchor
			-- <Precursor>
		do
			Result := Current
		end

	prunned (pq: STS_RATIONAL_NUMBER): RATIONAL_COMPLEMENT_SET
			-- <Precursor>
		local
			s: RATIONAL_SET
		do
			create s
			create Result.make (s.extended (pq))
		end

feature -- Output

	out: STRING
			-- <Precursor>
		once
			Result := {UTF_CONVERTER}.string_32_to_utf_8_string_8 ("ℚ")
		ensure then
			class
		end

feature -- Anchor

	subset_anchor: STS_RATIONAL_SET
			-- <Precursor>
		do
			Result := Current
		end

	superset_anchor: RATIONAL_NUMBERS
			-- <Precursor>
		do
			Result := Current
		end

	rational_superset_anchor: RATIONAL_NUMBERS
			-- <Precursor>
		do
			Result := Current
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

note
	description: "Implementation of {STS_INTEGER_NUMBERS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_NUMBERS

inherit
	STS_INTEGER_NUMBERS
		undefine
			does_not_have
		redefine
			out
		end

	UNIVERSE [STS_INTEGER_NUMBER]
		rename
			extended as set_extended,
			u as z,
			universe as integer_numbers
		redefine
			prunned,
			out,
			subset_anchor,
			superset_anchor
		end

feature -- Construction

	extended (a_n: STS_INTEGER_NUMBER): like integer_superset_anchor
			-- <Precursor>
		do
			Result := Current
		end

	prunned (a_n: STS_INTEGER_NUMBER): INTEGER_COMPLEMENT_SET
			-- <Precursor>
		local
			s: INTEGER_SET
		do
			create s
			create Result.make (s.extended (a_n))
		end

feature -- Output

	out: STRING
			-- <Precursor>
		once
			Result := {UTF_CONVERTER}.string_32_to_utf_8_string_8 ("ℤ")
		ensure then
			class
		end

feature -- Anchor

	subset_anchor: STS_INTEGER_SET
			-- <Precursor>
		do
			Result := Current
		end

	superset_anchor: INTEGER_NUMBERS
			-- <Precursor>
		do
			Result := Current
		end

	integer_superset_anchor: INTEGER_NUMBERS
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

note
	description: "Set that has every element of a given type"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	UNIVERSE [G]

inherit
	SET [G]
		redefine
			does_not_have,
			out,
			superset_anchor
		end

	DEBUG_OUTPUT
		redefine
			out
		end

feature -- Membership

	has alias "∋" (a: G): BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	does_not_have alias "∌" (a: G): BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature -- Construction

	extended (a: G; eq: EQUALITY [G]): like superset_anchor
			-- <Precursor>
		do
			Result := Current
		end

	prunned (a: G): COMPLEMENT_SET [G]
			-- <Precursor>
		local
			s: EFFECTIVE_SET [G]
		do
			create s
			create Result.make (s.extended (a, create {REFERENCE_EQUALITY [G]}))
		end

feature -- Quality

	is_universe: BOOLEAN = True
			-- <Precursor>
			--| Current set knows it is a universe!

feature -- Output

	out: STRING
			-- <Precursor>
		once
			Result := {UTF_CONVERTER}.string_32_to_utf_8_string_8 ("𝕌")
		ensure then
			class
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- <Precursor>
		once
			Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
		ensure then
			class
			definition: Result ~ {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
		end

feature -- Anchor

	superset_anchor: UNIVERSE [G]
			-- <Precursor>
		do
			Result := Current
		end

invariant
	is_universe: is_universe

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end

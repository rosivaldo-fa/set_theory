note
	description: "Implementation of {STS_UNIVERSE}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	UNIVERSE [G]

inherit
	STS_UNIVERSE [G]
		redefine
			does_not_have,
			out
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

	extended (a: G; eq: STS_EQUALITY [G]): like superset_anchor
			-- <Precursor>
		do
			Result := Current
		end

	prunned (a: G): COMPLEMENT_SET [G]
			-- <Precursor>
		local
			s: SET [G]
		do
			create s
			create Result.make (s.extended (a, create {STS_REFERENCE_EQUALITY [G]}))
		end

feature -- Access

	universe: like universe_anchor
			-- <Precursor>
		do
			Result := Current
		end

feature -- Quality

	is_universe: BOOLEAN = True

feature -- Output

	out: STRING
			-- <Precursor>
		once
			Result := {UTF_CONVERTER}.string_32_to_utf_8_string_8 ("𝕌")
		ensure then
			class
			definition: Result ~ {UTF_CONVERTER}.string_32_to_utf_8_string_8 ("𝕌")
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

	subset_anchor: STS_SET [G]
			-- <Precursor>
		do
			Result := Current
		end

	superset_anchor: UNIVERSE [G]
			-- <Precursor>
		do
			Result := Current
		end

	universe_anchor: UNIVERSE [G]
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

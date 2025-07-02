note
	description: "Set whose elements are those not included in a given reference set"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPLEMENT_SET [G]

inherit
	STS_SET [G]
		redefine
			out
		end

	DEBUG_OUTPUT
		redefine
			out
		end

create
	make

feature {NONE} -- Initialization

	make (s: STS_SET [G])
			-- Create a complement set whose `reference_set' is `s'.
		do
			reference_set := s
		ensure
			reference_set: reference_set = s -- TODO: Use set equality instead.
		end

feature -- Primitive

	reference_set: STS_SET [G]
			-- Set that current set is a complement of

feature -- Membership

	has alias "∋" (a: G): BOOLEAN
			-- <Precursor>
		do
			Result := reference_set ∌ a
		end

feature -- Construction

	extended (a: G; eq: STS_EQUALITY [G]): like superset_anchor
			-- <Precursor>
		do
			create Result.make_extended (a, eq, Current)
		end

	prunned (a: G): like subset_anchor
			-- <Precursor>
		do
			create Result.make (reference_set.extended (a, create {STS_REFERENCE_EQUALITY [G]}))
		end

feature -- Access

	universe: like universe_anchor
			-- <Precursor>
		do
			create Result
		ensure then
			class
		end

feature -- Quality

	is_universe: detachable BOOLEAN_REF
			-- <Precursor>
		do
			-- TODO: Check whether `reference_set' is empty.
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

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- <Precursor>
		do
			Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
		ensure then
			definition: Result ~ {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
		end

feature -- Anchor

	subset_anchor: COMPLEMENT_SET [G]
			-- <Precursor>
		do
			Result := Current
		end

	superset_anchor: SET [G]
			-- <Precursor>
		do
			create Result
		end

	universe_anchor: UNIVERSE [G]
			-- <Precursor>
		do
			Result := universe
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

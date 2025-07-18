note
	description: "Set whose natural-number elements are those not included in a given reference set"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	NATURAL_COMPLEMENT_SET

inherit
	STS_NATURAL_SET
		redefine
			out
		end

	COMPLEMENT_SET [STS_NATURAL_NUMBER]
		rename
			extended as set_extended,
			u as n,
			universe as natural_numbers
		redefine
			out,
			subset_anchor
		end

create
	make

feature -- Construction

	extended (a_n: NATURAL_NUMBER): like natural_superset_anchor
			-- <Precursor>
		do
			create Result.make_extended (a_n, Current)
		end

--	prunned (a: G): like subset_anchor
--			-- <Precursor>
--		do
--			create Result.make (reference_set.extended (a, create {STS_REFERENCE_EQUALITY [G]}))
--		end

--feature -- Access

--	u, universe: like universe_anchor
--			-- <Precursor>
--		do
--			create Result
--		ensure then
--			class
--		end

--feature -- Quality

--	is_universe: detachable BOOLEAN_REF
--			-- <Precursor>
--		do
--			-- TODO: Check whether `reference_set' is empty.
--		end

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

--feature -- Status report

--	debug_output: READABLE_STRING_GENERAL
--			-- <Precursor>
--		do
--			Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
--		ensure then
--			definition: Result ~ {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
--		end

feature -- Anchor

	subset_anchor: NATURAL_COMPLEMENT_SET
			-- <Precursor>
		do
			Result := Current
		end

--	superset_anchor: SET [G]
--			-- <Precursor>
--		do
--			create Result
--		end

	natural_superset_anchor: NATURAL_SET
			-- <Precursor>
		do
			create Result
		end

--	universe_anchor: UNIVERSE [G]
--			-- <Precursor>
--		do
--			Result := universe
--		ensure then
--			class
--		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

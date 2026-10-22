note
	description: "Set that has every element of a given type"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	UNIVERSE [G]

inherit
	SET [G]
		rename
			superset_anchor as universe_anchor
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
			--| Notice that a universe has every thing, but it does not need to know anything about its elements, and indeed probably does not know. It has
			--| an important impact upon `there_exists'.
		do
			known_elements := known_elements.extended (a, create {REFERENCE_EQUALITY [G]})
			Result := True
		ensure then
			knowledge_extended: known_elements ∋ a
		end

	does_not_have alias "∌" (a: G): BOOLEAN
			-- <Precursor>
		do
			known_elements := known_elements.extended (a, create {REFERENCE_EQUALITY [G]})
			Result := False
		ensure then
			knowledge_extended: known_elements ∋ a
		end

feature -- Construction

	extended (a: G; eq: EQUALITY [G]): like universe_anchor
			-- <Precursor>
		do
			known_elements := known_elements.extended (a, eq)
			Result := Current
		ensure then
			knowledge_extended: known_elements ∋ a
		end

	prunned alias "/" (a: G): COMPLEMENT_SET [G]
			-- <Precursor>
		local
			s: EFFECTIVE_SET [G]
		do
			known_elements := known_elements.extended (a, create {REFERENCE_EQUALITY [G]})
			create s
			create Result.make (s.extended (a, create {REFERENCE_EQUALITY [G]}))
		ensure then
			knowledge_extended: known_elements ∋ a
		end

feature -- Access

	u,
	universe: like universe_anchor
			-- <Precursor>
		do
			Result := Current
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

feature -- Quantifier

	there_exists alias "|∃" (p: FUNCTION [G, BOOLEAN]): detachable BOOLEAN_REF
			-- <Precursor>
			--| Since a universe has every element of a given type, it does not need to know anything about those elements (just their type). So the universe
			--| does not need to keep a record of its elements, unless it needs them for some operation besides `has' or `does_not_have'. This is why, in
			--| general, a universe cannot answer a `there_exists' query unless it has some knowledge of actual instances of its elements, hence the need of
			--| `known_elements'.
		do
			if attached (known_elements |∃ p) as exists_in_known_elements and then exists_in_known_elements.item then
				Result := True
			end
		ensure then
			definition:
				if attached (known_elements |∃ p) as exists_in_known_elements then
					if exists_in_known_elements.item then
						attached Result and then Result.item
					else
						not attached Result
					end
				else
					not attached Result
				end
		end

feature -- Anchor

	subset_anchor: SET [G]
			-- <Precursor>
		do
			Result := Current
		end

	universe_anchor: UNIVERSE [G]
			-- <Precursor>
		do
			Result := Current
		end

feature {NONE} -- Implementation

	known_elements: EFFECTIVE_SET [G]
			-- Elements explicitly known to be in current universe
			--| This set is necessary for making possible to answer `there_exists' query.
		attribute
			create Result
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

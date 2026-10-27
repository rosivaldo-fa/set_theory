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
			Result := True
		end

	does_not_have alias "∌" (a: G): BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature -- Construction

	extended (a: G; eq: EQUALITY [G]): like universe_anchor
			-- <Precursor>
		do
			Result := Current
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

	there_exists alias "|∃" (p: PREDICATE [G]): detachable BOOLEAN_REF
			-- <Precursor>
		local
			g_type_id: INTEGER_32
			q: PREDICATE [detachable separate ANY]
		do
			g_type_id := ({G}).type_id
			q := p
			if g_type_id = ({NATURAL_8}).type_id then
				Result := there_exists_native_natural (q, {NATURAL_8} 0, {NATURAL_8}.Max_value)
			elseif g_type_id = ({NATURAL_16}).type_id then
				Result := there_exists_native_natural (q, {NATURAL_16} 0, {NATURAL_16}.Max_value)
			elseif g_type_id = ({NATURAL_32}).type_id then
				Result := there_exists_native_natural (q, {NATURAL_32} 0, {NATURAL_32}.Max_value)
			elseif g_type_id = ({NATURAL_64}).type_id then
				Result := there_exists_native_natural (q, {NATURAL_64} 0, {NATURAL_64}.Max_value)
			end
		end

	there_exists_native_natural (p: PREDICATE [detachable separate ANY]; min_value, max_value: NATURAL_64): BOOLEAN
			-- Does `p' hold for some native natural number within the interval [`min_value' .. `max_value']?
		local
			n: NATURAL_64
		do
			if min_value ≤ max_value then
				from
					n := min_value
					Result := p (n)
				invariant
					bounded: n ≤ max_value
					not_found_before: min_value < n ⇒ not there_exists_native_natural (p, min_value, n - 1)
					definition: Result = p (n)
				until
					n = max_value or Result
				loop
					n := n + 1
					Result := p (n)
				variant
					n: (max_value - n).as_integer_64
				end
			end
		ensure
			not_found: max_value < min_value ⇒ not Result
			found: min_value < max_value and p (min_value) ⇒ Result
			still_searching: min_value < max_value and not p (min_value) ⇒ Result = there_exists_native_natural (p, min_value + 1, max_value)
			last_chance: min_value = max_value ⇒ Result = p (min_value)
		end

	there_exists_native_integer (p: PREDICATE [detachable separate ANY]; min_value, max_value: INTEGER_64): BOOLEAN
			-- Does `p' hold for some native natural number within the interval [`min_value' .. `max_value']?
		local
			i: INTEGER_64
		do
			if min_value ≤ max_value then
				from
					i := min_value
					Result := p (i)
				invariant
					bounded: i ≤ max_value
					not_found_before: min_value < i ⇒ not there_exists_native_integer (p, min_value, i - 1)
					definition: Result = p (i)
				until
					i = max_value or Result
				loop
					i := i + 1
					Result := p (i)
				variant
					i: (max_value - i).as_integer_64
				end
			end
		ensure
			not_found: max_value < min_value ⇒ not Result
			found: min_value < max_value and p (min_value) ⇒ Result
			still_searching: min_value < max_value and not p (min_value) ⇒ Result = there_exists_native_integer (p, min_value + 1, max_value)
			last_chance: min_value = max_value ⇒ Result = p (min_value)
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

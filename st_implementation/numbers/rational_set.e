note
	description: "Implementation of {STS_RATIONAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	RATIONAL_SET

inherit
	STS_RATIONAL_SET
		redefine
			default_create,
			out
		end

	DEBUG_OUTPUT
		redefine
			default_create,
			out
		end

create
	default_create,
	make_extended

feature {NONE} -- Initialization

	default_create
			-- Create an empty rational set
		do
		ensure then
			is_empty: subset = Current
		end

	make_extended (pq: STS_RATIONAL_NUMBER; s: STS_RATIONAL_SET)
			-- Create a set whose `given_element' element and `subset' are, respectively, `pq' and `s'.
		do
			subset := s
			create given_element_storage.put (pq)
		ensure
			is_not_empty: subset /= Current
			given_element: given_element ≍ pq
			subset: subset = s -- TODO: Use set equality instead.
		end

feature -- Membership

	has alias "∋" (pq: STS_RATIONAL_NUMBER): BOOLEAN
			-- Is `pq' an element in current set?
		do
			if subset /= Current then -- Current set is not empty, so it is an "extended" set.
				Result := pq ≍ given_element or subset ∋ pq
			end
		end

feature -- Construction

	set_extended (pq: STS_RATIONAL_NUMBER; a_eq: STS_EQUALITY [STS_RATIONAL_NUMBER]): like superset_anchor
			-- Current set extended with `pq`, whose equality with any other element is defined by `a_eq`
		do
			create Result.make_extended (pq, a_eq, Current)
		ensure then
			equality: Result.eq = a_eq
			is_not_empty: Result.subset /= Result
			given_element: Result.given_element ≍ pq
			subset: Result.subset = Current -- TODO: Use set equality instead.
		end

	extended (pq: STS_RATIONAL_NUMBER): like rational_superset_anchor -- TODO: Use like superset_anchor?
			-- <Precursor>
		do
			create Result.make_extended (pq, Current)
		ensure then
			given_element: Result.given_element ≍ pq
			subset: Result.subset = Current -- TODO: Use set equality instead.
		end

	prunned (pq: STS_RATIONAL_NUMBER): like subset_anchor
			-- Set with every element of current set but any element regarded equal to `pq'
		do
			if subset = Current then
				Result := Current
			elseif pq ≍ given_element then
				Result := subset.prunned (pq)
			else
				Result := subset.prunned (pq).extended (given_element)
			end
		ensure then
			when_empty: subset = Current ⇒ Result = Current -- TODO: Use set equality instead.
--			when_found: attached eq and then eq (a, given_element) ⇒ Result ≍ subset.prunned (a)
--			when_not_found: attached eq and then not eq (a, given_element) ⇒ Result ≍ subset.prunned (a).extended (given_element, eq)
		end

feature -- Access

	q, rational_numbers: UNIVERSE [STS_RATIONAL_NUMBER]
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
			if Current = subset then
				Result := "{}"
			else
				Result := subset.out
				Result.append (" & (")
				Result.append (given_element.out)
				Result.append_character (')')
			end
		ensure then
			base: Current = subset ⇒ Result ~ "{}"
			induction: Current /= subset ⇒ Result ~ subset.out + " & (" + given_element.out + ")"
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- <Precursor>
		do
			Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
		ensure then
			definition: Result ~ {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
		end

feature -- Quality

	is_universe: detachable BOOLEAN_REF
			-- <Precursor>
		do
		end

feature -- Anchor

	subset_anchor: STS_RATIONAL_SET
			-- <Precursor>
		do
			Result := Current
		end

	superset_anchor: SET [STS_RATIONAL_NUMBER]
			-- <Precursor>
		do
			create Result
		end

	rational_superset_anchor: RATIONAL_SET
			-- <Precursor>
		do
			Result := Current
		end

	universe_anchor: UNIVERSE [STS_RATIONAL_NUMBER]
			-- <Precursor>
		once
			Result := q
		ensure then
			class
		end

feature {RATIONAL_SET} -- Implementation

	given_element: like given_element_anchor
			-- An arbitrary element in current set
		require
			is_not_empty: subset /= Current
		do
			check
				attached_given_element_storage: attached given_element_storage as ges -- not `is_empty'
			then
				Result := ges.item
			end
		ensure then
			attached_stored_any: attached given_element_storage as ges -- not `is_empty'
			definition: Result ~ ges.item
		end

	subset: like subset_anchor
			-- Set of all elements in current set but, possibly, `given_element'
		attribute
			Result := Current
		end

feature {NONE} -- Implementation

	given_element_storage: detachable CELL [like given_element_anchor]
			-- Storage for `given_element'
		note
			option: stable
		attribute
		end

feature {NONE} -- Anchor

	given_element_anchor: RATIONAL_NUMBER
			-- Anchor for objects like `given_element'
		do
			Result := given_element
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

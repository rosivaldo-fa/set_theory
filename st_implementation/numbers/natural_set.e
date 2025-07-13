note
	description: "Implementation of {STS_NATURAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	NATURAL_SET

inherit
	STS_NATURAL_SET
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
			-- Create an empty natural set
		do
		ensure then
			is_empty: subset = Current
		end

	make_extended (n: STS_NATURAL_NUMBER; s: STS_NATURAL_SET)
			-- Create a set whose `given_element' element and `subset' are, respectively, `n' and `s'.
		do
			subset := s
			create given_element_storage.put (converted_element (n))
		ensure
			is_not_empty: subset /= Current
			given_element: given_element ≍ n
			subset: subset = s -- TODO: Use set equality instead.
		end

feature -- Membership

	has alias "∋" (n: STS_NATURAL_NUMBER): BOOLEAN
			-- Is `n' an element in current set?
		do
			if subset /= Current then -- Current set is not empty, so it is an "extended" set.
				Result := n ≍ given_element or subset ∋ n
			end
		end

feature -- Construction

	set_extended (n: STS_NATURAL_NUMBER; a_eq: STS_EQUALITY [STS_NATURAL_NUMBER]): like superset_anchor
			-- Current set extended with `n`, whose equality with any other element is defined by `a_eq`
		do
			create Result.make_extended (n, a_eq, Current)
		ensure then
			equality: Result.eq = a_eq
			is_not_empty: Result.subset /= Result
			given_element: Result.given_element ≍ n
			subset: Result.subset = Current -- TODO: Use set equality instead.
		end

	extended (n: STS_NATURAL_NUMBER): like natural_superset_anchor -- TODO: Use like superset_anchor?
			-- <Precursor>
		do
			create Result.make_extended (n, Current)
		ensure then
			given_element: Result.given_element ≍ n
			subset: Result.subset = Current -- TODO: Use set equality instead.
		end

	prunned (n: STS_NATURAL_NUMBER): like subset_anchor
			-- Set with every element of current set but any element regarded equal to `n'
		do
			if subset = Current then
				Result := Current
			elseif n ≍ given_element then
				Result := subset.prunned (n)
			else
				Result := subset.prunned (n).extended (given_element)
			end
		ensure then
			when_empty: subset = Current ⇒ Result = Current -- TODO: Use set equality instead.
--			when_found: attached eq and then eq (a, given_element) ⇒ Result ≍ subset.prunned (a)
--			when_not_found: attached eq and then not eq (a, given_element) ⇒ Result ≍ subset.prunned (a).extended (given_element, eq)
		end

feature -- Access

	universe: like universe_anchor
			-- <Precursor>
		do
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

feature -- Factory

	converted_element (n: STS_NATURAL_NUMBER): like given_element_anchor
			-- `n` converted to an element like `given_element'
		do
			if attached {like given_element_anchor} n as l_n then
				Result := l_n
			else
				Result := n.value
			end
		ensure then
			class
		end

feature -- Anchor

	subset_anchor: STS_NATURAL_SET
			-- <Precursor>
		do
			Result := Current
		end

	superset_anchor: SET [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			create Result
		end

	natural_superset_anchor: NATURAL_SET
			-- <Precursor>
		do
			Result := Current
		end

	universe_anchor: UNIVERSE [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			Result := universe
		ensure then
			class
		end

feature {NATURAL_SET} -- Implementation

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

	given_element_anchor: NATURAL_NUMBER
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

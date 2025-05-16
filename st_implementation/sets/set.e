note
	description: "Implementation of {STS_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	SET [G]

inherit
	STS_SET [G]

create
	default_create,
	make_extended

feature {NONE} -- Initialization

	make_extended (a: G; a_eq: STS_EQUALITY [G]; s: SET [G])
			-- Create a set whose `given_element' element and `subset' are, respectively, `a' and `s'.
		do
			eq := a_eq
			subset := s
			create given_element_storage.put (a)
		ensure
			attached_storage: attached given_element_storage
			attached_eq: attached eq
			given_element: eq (given_element, a)
			subset: subset = s -- TODO: Use set equality instead.
		end

feature -- Membership

	has alias "∋" (a: G): BOOLEAN
			-- <Precursor>
		do
			Result := attached eq and then eq (a, given_element) or subset /= Current and then subset ∋ a
		end

feature -- Construction

	extended (a: G; a_eq: STS_EQUALITY [G]): like superset_anchor
			-- <Precursor>
		do
			create Result.make_extended (a, a_eq, Current)
		ensure then
			equality: Result.eq = a_eq
			given_element: a_eq (Result.given_element, a)
			subset: Result.subset = Current -- TODO: Use set equality instead.
		end

feature -- Anchor

	subset_anchor,
	superset_anchor: SET [G]
			-- <Precursor>
		do
			Result := Current
		end

feature {SET} -- Implementation

	given_element: like given_element_anchor
			-- An arbitrary element in current set
		do
			check
				attached_stored_any: attached given_element_storage -- not `is_empty'
			then
				Result := given_element_storage.item
			end
		ensure then
			attached_stored_any: attached given_element_storage -- not `is_empty'
			definition: Result ~ given_element_storage.item
		end

	subset: like subset_anchor
			-- Set of all elements in current set but, possibly, `given_element'
		attribute
			Result := Current
		end

	eq: detachable STS_EQUALITY [G]
			-- Rule for testing equality between `given_element' and any other element
		note
			option: stable
		attribute
		end

feature {NONE} -- Implementation

	given_element_storage: detachable CELL [like given_element_anchor]
			-- Storage for `given_element'
		note
			option: stable
		attribute
		end

feature {NONE} -- Anchor

	given_element_anchor: G
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

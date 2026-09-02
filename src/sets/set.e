note
	description: "[
			Element that models a mathematical set.
			Notice that Eiffel Base has a {SET} class, that was renamed to {EB_SET} in order to not clash with this one, that has a more
			fundamental nature, hence the choice of keeping current's name instead of Eiffel Base's one.
		]"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	SET [G]

inherit
	ELEMENT
		rename
			is_in as element_is_in,
			is_not_in as element_is_not_in
		redefine
			default_create
		end

create
	default_create,
	make_extended

feature {NONE} -- Initialization

	default_create
			-- Create an empty set
		do
		ensure then
			is_empty: subset = Current
		end

	make_extended (a: G; a_eq: EQUALITY [G]; s: SET [G])
			-- Create a set whose `given_element' element and `subset' are, respectively, `a' and `s'.
		do
			eq := a_eq
			subset := s
			create given_element_storage.put (a)
		ensure
			attached_storage: attached given_element_storage
			eq: eq = a_eq
			is_not_empty: subset /= Current
			attached_eq: attached eq
			given_element: eq (given_element, a)
			subset: subset = s -- TODO: Use set equality instead.
		end

feature -- Membership

	has alias "∋" (a: G): BOOLEAN
			-- Is `a' an element in current set?
		do
			if subset /= Current then -- Current set is not empty, so it is an "extended" set.
				check
					attached eq -- `make_extended' and `extended' definitions
				then
					Result := eq (a, given_element) or subset ∋ a
				end
			end
		ensure
			universe_has_everything: attached is_universe as is_u and then is_u.item ⇒ Result
		end

	does_not_have alias "∌" (a: G): BOOLEAN
			-- Does not current set have `a'?
		do
			Result := not (Current ∋ a)
		ensure
			definition: Result = not (Current ∋ a)
		end

	is_in alias "∈" (s: SET [SET [G]]): BOOLEAN
			-- Does `s` have current set?
		do
			Result := s ∋ Current
		ensure
			definition: Result = s ∋ Current
		end

	is_not_in alias "∉" (s: SET [SET [G]]): BOOLEAN
			-- Is not current set in `s'?
		do
			Result := not (Current ∈ s)
		ensure
			definition: Result = not (Current ∈ s)
		end

feature -- Construction

	extended (a: G; a_eq: EQUALITY [G]): like superset_anchor
			-- Current set extended with `a', whose equality with any other element is defined by `eq'
		do
			create Result.make_extended (a, a_eq, Current)
		ensure
			has_a: Result ∋ a
			equality: Result.eq = a_eq
			is_not_empty: Result.subset /= Result
			given_element: a_eq (Result.given_element, a)
			subset: Result.subset = Current -- TODO: Use set equality instead.
		end

	prunned (a: G): like subset_anchor
			-- Set with every element of current set but any element regarded equal to `a'
		do
			if subset = Current then
				Result := Current
			else -- Current set is not empty, so it is an "extended" set.
				check
					attached eq -- `make_extended' and `extended' definitions
				then
					if eq (a, given_element) then
						Result := subset.prunned (a)
					else
						Result := subset.prunned (a).extended (given_element, eq)
					end
				end
			end
		ensure
			does_not_have_a: Result ∌ a
			when_empty: not attached eq ⇒ Result = Current -- TODO: Use set equality instead.
--			when_found: attached eq and then eq (a, given_element) ⇒ Result ≍ subset.prunned (a)
--			when_not_found: attached eq and then not eq (a, given_element) ⇒ Result ≍ subset.prunned (a).extended (given_element, eq)
		end

feature -- Quality

	is_universe: detachable BOOLEAN_REF
			-- Is current set a universe, i.e., does it have every element of type {G}?
			--| Detachable because it is not always knowable whether a set is a universe of not
		do
		end

feature -- Anchor

	subset_anchor: SET [G]
			-- Anchor for subsets of current set
		do
			Result := Current
		end

	superset_anchor: SET [G]
			-- Anchor for supersets of current set
		do
			Result := Current
		end

feature {SET} -- Implementation

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

	eq: detachable EQUALITY [G]
			-- Rule for testing equality between `given_element' and any other element
		note
			option: stable
		attribute
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

	given_element_anchor: G
			-- Anchor for objects like `given_element'
		require
			is_not_empty: subset /= Current
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

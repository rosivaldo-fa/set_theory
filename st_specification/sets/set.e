note
	description: "[
			Element that models a mathematical set.
			Notice that Eiffel Base has a {SET} class, that was renamed to {EB_SET} in order to not clash with this one, that has a more
			fundamental nature, hence the choice of keeping current's name instead of Eiffel Base's one.
		]"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET [G]

inherit
	ELEMENT
		rename
			is_in as element_is_in,
			is_not_in as element_is_not_in
		end

feature -- Membership

	has alias "∋" (a: G): BOOLEAN
			-- Is `a' an element in current set?
		deferred
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

	extended (a: G; eq: EQUALITY [G]): like superset_anchor
			-- Current set extended with `a', whose equality with any other element is defined by `eq'
		deferred
		ensure
			has_a: Result ∋ a
		end

	prunned (a: G): like subset_anchor
			-- Set with every element of current set but any element regarded equal to `a'
		deferred
		ensure
			does_not_have_a: Result ∌ a
		end

feature -- Quality

	is_universe: detachable BOOLEAN_REF
			-- Is current set a universe, i.e., does it have every element of type {G}?
			--| Detachable because it is not always knowable whether a set is a universe of not
		deferred
		end

feature -- Anchor

	subset_anchor: SET [G]
			-- Anchor for subsets of current set
		deferred
		end

	superset_anchor: SET [G]
			-- Anchor for supersets of current set
		deferred
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

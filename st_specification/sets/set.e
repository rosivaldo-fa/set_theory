﻿note
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

feature -- Membership

	has alias "∋" (a: G): BOOLEAN
			-- Is `a' an element in current set?
		deferred
		end

feature -- Construction

	extended (a: G; eq: EQUALITY [G]): like superset_anchor
			-- Current set extended with `a', whose equality with any other element is defined by `eq'
		deferred
		ensure
			has_a: Result ∋ a
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

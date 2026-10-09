note
	description: "Minimal implementation of {SET_FAMILY}"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	EFFECTIVE_SET_FAMILY [G]

inherit
	SET_FAMILY [G]
		undefine
			default_create,
			out
		redefine
			superfamily_anchor
		end

	EFFECTIVE_SET [SET [G]]
		rename
			make_extended as set_make_extended,
			given_element as given_set,
			given_element_storage as given_set_storage,
			subset as subfamily,
			subset_anchor as subfamily_anchor,
			superset_anchor as superfamily_anchor
		undefine
			subfamily_anchor
		redefine
			set_make_extended,
			extended,
			superfamily_anchor
		end

create
	default_create,
	make_extended

feature {NONE} -- Initialization

	set_make_extended (s: SET [G]; a_eq: EQUALITY [SET [G]]; ss: SET [SET [G]])
			-- Do nothing.
		do
		end

	make_extended (s: SET [G]; a_eq: EQUALITY [SET [G]]; sf: SET_FAMILY [G])
			-- Create a set family whose `given_set' set and `subfamily' are, respectively, `s' and `sf'.
		do
			eq := a_eq
			subfamily := sf
			create given_set_storage.put (s)
		ensure
			attached_storage: attached given_set_storage
			is_not_empty: subfamily /= Current
			attached_eq: attached eq
			given_set: eq (given_set, s)
			subfamily: subfamily = sf -- TODO: Use set equality instead.
		end

feature -- Construction

	extended (s: SET [G]; a_eq: EQUALITY [SET [G]]): like superfamily_anchor
			-- Current set family extended with `s`, whose equality with any other set is defined by `a_eq`
		do
			create Result.make_extended (s, a_eq, Current)
		end

feature -- Anchor

	superfamily_anchor: EFFECTIVE_SET_FAMILY [G]
			-- Anchor for supersets of current set family
		do
			Result := Current
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

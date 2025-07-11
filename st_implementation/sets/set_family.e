note
	description: "Implementation of {STS_SET_FAMILY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_FAMILY [G]

inherit
	STS_SET_FAMILY [G]
		undefine
			default_create,
			out
		end

	SET [STS_SET [G]]
		rename
			make_extended as set_make_extended,
			given_element as given_set,
			given_element_storage as given_set_storage,
			subset as subfamily,
			set_anchor as family_anchor,
			subset_anchor as subfamily_anchor,
			superset_anchor as superfamily_anchor
		redefine
			set_make_extended,
			extended,
			family_anchor,
			subfamily_anchor,
			superfamily_anchor
		end

create
	default_create,
	make_extended

feature {NONE} -- Initialization

	set_make_extended (s: STS_SET [G]; a_eq: STS_EQUALITY [STS_SET [G]]; sf: STS_SET [STS_SET [G]])
			-- Do nothing.
		do
		end

	make_extended (s: STS_SET [G]; a_eq: STS_EQUALITY [STS_SET [G]]; sf: STS_SET_FAMILY [G])
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

	extended (s: STS_SET [G]; a_eq: STS_EQUALITY [STS_SET [G]]): like superfamily_anchor
			-- Current set family extended with `s`, whose equality with any other set is defined by `a_eq`
		do
			create Result.make_extended (s, a_eq, Current)
		end

feature -- Anchor

	family_anchor: SET_FAMILY [G]
			-- <Precursor>
		do
			Result := Current
		end

	subfamily_anchor: STS_SET_FAMILY [G]
			-- <Precursor>
		do
			Result := Current
		end

	superfamily_anchor: SET_FAMILY [G]
			-- <Precursor>
		do
			Result := Current
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

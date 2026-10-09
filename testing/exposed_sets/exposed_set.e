note
	description: "Descendant of {EFFECTIVE_SET} that exposes the hidden features or its ancestor in order to test them"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class EXPOSED_SET [G]

inherit
	EFFECTIVE_SET [G]
		rename
			make_extended as set_make_extended
		export {EFFECTIVE_SET_TESTS}
			given_element,
			subset,
			eq,
			given_element_storage
		redefine
			set_make_extended,
			extended,
			subset_anchor,
			superset_anchor
		end

create
	default_create,
	make_extended

feature {NONE} -- Initialization

	set_make_extended (a: G; a_eq: EQUALITY [G]; s: SET [G])
			-- Do nothing.
		do
		end

	make_extended (a: G; a_eq: EQUALITY [G]; s: EXPOSED_SET [G])
			-- Create an exposed set whose `given_element' element and `subset' are, respectively, `a' and `s'.
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

feature -- Construction

	extended (a: G; a_eq: EQUALITY [G]): like superset_anchor
			-- <Precursor>
		do
			create Result.make_extended (a, a_eq, Current)
		end

feature -- Anchor

	subset_anchor,
	superset_anchor: EXPOSED_SET [G]
			-- <Precursor>
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

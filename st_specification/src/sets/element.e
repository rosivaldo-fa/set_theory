note
	description: "[
		Object that knows whether it is in a given set.
		Though the elements of a {SET} may be of any type, this class is meant to be the ancestor of any class specified in set_theory.
		]"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	ELEMENT

feature -- Membership

	is_in alias "∈" (s: SET [ELEMENT, EQUALITY [ELEMENT]]): BOOLEAN
			-- Does `s' have current element?
		do
			Result := s ∋ Current
		ensure
			definition: Result = s ∋ Current
		end

note
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	copyright: "Copyright (c) 2012-2023, Rosivaldo Fernandes Alves"
	source: ""
end

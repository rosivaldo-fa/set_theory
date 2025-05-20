note
	description: "Object that checks whether the properties verified within set theory hold for an implementation of {STS_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQUALITY_PROPERTIES [G]

inherit
	STS_ELEMENT

feature -- Properties (Relationship)

	holds_successively_ok (a, b, c: G; eq: STS_EQUALITY [G]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_EQUALITY}.holds_successively?
		do
			check
				definition: eq.holds_successively (a, b, c) = (eq (a, b) and eq (a, c))
			then
				Result := True
			end
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

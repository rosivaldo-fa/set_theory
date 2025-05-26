note
	description: "Object that checks whether the properties verified within set theory hold for an implementation of {STS_OBJECT_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBJECT_EQUALITY_PROPERTIES [G]

inherit
	EQUALITY_PROPERTIES [G]
		rename
			holds_successively_ok as eq_holds_successively_ok
		end

feature -- Properties (Relationship)

	holds_ok (a, b: G; eq: STS_OBJECT_EQUALITY [G]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_OBJECT_EQUALITY}.holds?
		do
			check
				consistent: {STS_OBJECT_STANDARD_EQUALITY [G]}.holds (a, b) implies eq (a, b)
			then
				Result := True
			end
		end

	holds_successively_ok (a, b, c: G; eq: STS_OBJECT_EQUALITY [G]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_OBJECT_EQUALITY}.holds_successively?
		do
			check
				precursor_holds: eq_holds_successively_ok (a, b, c, eq)
				consistent: {STS_OBJECT_STANDARD_EQUALITY [G]}.holds_successively (a, b, c) implies eq.holds_successively (a, b, c)
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

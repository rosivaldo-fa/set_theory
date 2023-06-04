note
	description: "Object that checks whether the properties verified within set theory hold for an implementation of {STS_OBJECT_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_EQUALITY_PROPERTIES [A, EQ -> STS_OBJECT_EQUALITY [A]]

inherit
	EQUALITY_PROPERTIES [A, EQ]
		redefine
			holds_ok,
			holds_successively_ok
		end

feature -- Properties (Relationship)

	holds_ok (a, b: A; eq: EQ): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_OBJECT_EQUALITY}.holds?
		do
			check
				precursor_holds: Precursor (a, b, eq)
				consistent: {STS_OBJECT_STANDARD_EQUALITY [A]}.holds (a, b) implies eq (a, b)
			then
				Result := True
			end
		end

	holds_successively_ok (a, b, c: A; eq: EQ): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_OBJECT_EQUALITY}.holds_successively?
		do
			check
				precursor_holds: Precursor (a, b, c, eq)
				consistent: {STS_OBJECT_STANDARD_EQUALITY [A]}.holds_successively (a, b, c) implies eq.holds_successively (a, b, c)
			then
				Result := True
			end
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end

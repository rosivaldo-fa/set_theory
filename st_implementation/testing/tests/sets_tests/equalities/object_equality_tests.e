note
	description: "Test suite for {STS_OBJECT_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBJECT_EQUALITY_TESTS [A, EQ -> STS_OBJECT_EQUALITY [A] create default_create end]

inherit
	EQUALITY_TESTS [A, EQ]
		redefine
			test_holds
		end

feature -- Test routines (Relationship)

	test_holds
			-- Test {STS_OBJECT_EQUALITY}.holds.
		note
			testing: "covers/{STS_OBJECT_EQUALITY}.holds"
		local
			eq: like equality_to_be_tested
			a1, a2: A
		do
			Precursor {EQUALITY_TESTS}

			eq := equality_to_be_tested
			a1 := some_object_a
			a2 := object_twin_a (a1)
			assert ("a1 ~ a2", eq (a1, a2))
			assert ("a1 ~ a2 ok", properties.holds_ok (a1, a2, eq))

			from
				a2 := some_object_a
			until
				a2 /~ a1
			loop
				a2 := some_object_a
			end
			assert ("a1 /~ a2", not eq (a1, a2))
			assert ("a1 /~ a2 ok", properties.holds_ok (a1, a2, eq))
		end

feature -- Factory (object)

	object_twin_a (a: A): A
			-- Object equal (by value) to `a'
		do
			if attached a then
				Result := a.twin
			else
				Result := a
			end
		ensure
			definition: Result ~ a
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end

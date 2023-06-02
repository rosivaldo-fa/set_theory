note
	description: "Test suite for {STS_REFERENCE_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REFERENCE_EQUALITY_TESTS [A, EQ -> STS_REFERENCE_EQUALITY [A] create default_create end]

inherit
	EQUALITY_TESTS [A, EQ]
		redefine
			test_holds,
			test_holds_successively
		end

feature -- Test routines (Relationship)

	test_holds
			-- Test {STS_REFERENCE_EQUALITY}.holds.
		note
			testing: "covers/{STS_REFERENCE_EQUALITY}.holds"
		local
			eq: like equality_to_be_tested
			a1, a2: A
		do
			Precursor {EQUALITY_TESTS}

			eq := equality_to_be_tested
			a1 := some_object_a
			from
				a2 := some_object_a
			until
				a2 /= a1
			loop
				a2 := some_object_a
			end
			assert ("a1 /= a2", not eq (a1, a2))
			assert ("a1 /= a2 ok", properties.holds_ok (a1, a2, eq))
		end

	test_holds_successively
			-- Test {INSTANCE_FREE_EQUALITY}.holds_successively.
			-- Test {STS_REFERENCE_EQUALITY}.holds_successively.
		note
			testing: "covers/{INSTANCE_FREE_EQUALITY}.holds_successively"
			testing: "covers/{STS_REFERENCE_EQUALITY}.holds_successively"
		local
			eq: like equality_to_be_tested
			a1, a2, a3: A
		do
			Precursor {EQUALITY_TESTS}

			eq := equality_to_be_tested
			a1 := some_object_a
			from
				a2 := some_object_a
				a3 := some_object_a
			until
				not (a1 = a2 and a2 = a3)
			loop
				a2 := some_object_a
				a3 := some_object_a
			end
			assert ("not (a1 = a2 = a3)", not eq.holds_successively (a1, a2, a3))
			assert ("not (a1 = a2 = a3) ok", properties.holds_successively_ok (a1, a2, a3, eq))
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end

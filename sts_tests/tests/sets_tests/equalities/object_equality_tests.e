note
	description: "Test suite for {STS_OBJECT_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBJECT_EQUALITY_TESTS [G]

inherit
	EQUALITY_TESTS [G]
		rename
			holds_successively_ok as eq_holds_successively_ok
		redefine
			test_holds,
			test_holds_successively
		end

	OBJECT_EQUALITY_PROPERTIES [G]

feature -- Test routines (Relationship)

	test_holds
			-- Test {STS_OBJECT_EQUALITY}.holds.
		note
			testing: "covers/{STS_OBJECT_EQUALITY}.holds"
		local
			eq: like equality_to_be_tested
			a1, a2: G
		do
			Precursor {EQUALITY_TESTS}

			eq := equality_to_be_tested
			a1 := some_object_g
			a2 := object_twin_g (a1)
			assert ("a1 ~ a2", eq (a1, a2))
			assert ("a1 ~ a2 ok", holds_ok (a1, a2, eq))

			from
				a2 := some_object_g
			until
				a2 /~ a1
			loop
				a2 := some_object_g
			end
			assert ("a1 /~ a2", not eq (a1, a2))
			assert ("a1 /~ a2 ok", holds_ok (a1, a2, eq))
		end

	test_holds_successively
			-- Test {STS_INSTANCE_FREE_EQUALITY}.holds_successively.
			-- Test {STS_OBJECT_EQUALITY}.holds_successively.
		note
			testing: "covers/{STS_INSTANCE_FREE_EQUALITY}.holds_successively"
			testing: "covers/{STS_OBJECT_EQUALITY}.holds_successively"
		local
			eq: like equality_to_be_tested
			a1, a2, a3: G
		do
			Precursor {EQUALITY_TESTS}

			eq := equality_to_be_tested
			a1 := some_object_g
			a2 := object_twin_g (a1)
			a3 := object_twin_g (a2)
			assert ("a1 ~ a2 ~ a3", eq.holds_successively (a1, a2, a3))
			assert ("a1 ~ a2 ~ a3 ok", holds_successively_ok (a1, a2, a3, eq))

			from
				a2 := some_object_g
				a3 := some_object_g
			until
				not (a1 ~ a2 and a2 ~ a3)
			loop
				a2 := some_object_g
				a3 := some_object_g
			end
			assert ("not (a1 ~ a2 ~ a3)", not eq.holds_successively (a1, a2, a3))
			assert ("not (a1 ~ a2 ~ a3) ok", holds_successively_ok (a1, a2, a3, eq))
		end

feature -- Factory (Equality)

	some_immediate_equality_g: STS_OBJECT_EQUALITY [G]
			-- Some monomorphic object equality for {G} objects
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

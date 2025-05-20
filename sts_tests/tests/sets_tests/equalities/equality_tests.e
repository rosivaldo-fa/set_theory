note
	description: "Test suite for {STS_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQUALITY_TESTS [G]

inherit
	EQUALITY_PROPERTIES [G]
		undefine
			default_create
		end

	UNARY_TESTS [G]
		rename
			element_to_be_tested as equality_to_be_tested
		redefine
			test_all,
			equality_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_EQUALITY}.
		note
			testing: "covers/{STS_EQUALITY}"
		do
			Precursor {UNARY_TESTS}
			test_holds
			test_holds_successively
		end

feature -- Test routines (Relationship)

	test_holds
			-- Test {STS_EQUALITY}.holds.
		note
			testing: "covers/{STS_EQUALITY}.holds"
		local
			eq: like equality_to_be_tested
			a1, a2: G
		do
			eq := equality_to_be_tested
			a1 := some_object_g
			assert ("a1 = a1", eq (a1, a1))

			a2 := a1
			assert ("a1 = a2", eq (a1, a2))

			a2 := some_object_g
			assert ("holds", eq (a1, a2) ⇒ True)
		end

	test_holds_successively
			-- Test {STS_EQUALITY}.holds_successively.
		note
			testing: "covers/{STS_EQUALITY}.holds_successively"
		local
			eq: like equality_to_be_tested
			a1, a2, a3: G
		do
			eq := equality_to_be_tested
			a1 := some_object_g
			assert ("a1 = a1 = a1", eq.holds_successively (a1, a1, a1))
			assert ("a1 = a1 = a1 ok", holds_successively_ok (a1, a1, a1, eq))

			a2 := a1
			a3 := a2
			assert ("a1 = a2 = a3", eq.holds_successively (a1, a2, a3))
			assert ("a1 = a2 = a3 ok", holds_successively_ok (a1, a2, a3, eq))

			eq := equality_to_be_tested
			a2 := some_object_g
			a3 := some_object_g
			assert ("holds_successively", eq.holds_successively (a1, a2, a3) ⇒ True)
			assert ("holds_successively_ok", holds_successively_ok (a1, a2, a3, eq))
		end

feature {NONE} -- Factory (Element to be tested)

	equality_to_be_tested: like some_immediate_equality_g
			-- Equality meant to be under tests
		do
			Result := some_immediate_equality_g
		end

feature -- Factory (Equality)

	some_immediate_equality_g: STS_EQUALITY [G]
			-- Some monomorphic equality of type {EQ}
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


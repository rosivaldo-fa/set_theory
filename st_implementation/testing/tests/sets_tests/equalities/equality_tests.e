note
	description: "Test suite for {STS_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQUALITY_TESTS [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit
	UNARY_TESTS [A, EQ]
		rename
			element_to_be_tested as equality_to_be_tested
		redefine
			properties,
			equality_to_be_tested
		end

feature -- Access

	properties: STP_EQUALITY_PROPERTIES [A, EQ]
			-- Object that checks the set-theory properties of {STS_EQUALITY}

feature -- Test routines (Relationship)

	test_holds
			-- Test {STS_EQUALITY}.holds.
		note
			testing: "covers/{STS_EQUALITY}.holds"
		local
			eq: like equality_to_be_tested
			a1, a2: A
		do
			eq := equality_to_be_tested
			a1 := some_object_a
			assert ("a1 = a1", eq (a1, a1))
			assert ("a1 = a1 ok", properties.holds_ok (a1, a1, eq))

			a2 := a1
			assert ("a1 = a2", eq (a1, a2))
			assert ("a1 = a2 ok", properties.holds_ok (a1, a2, eq))

			a2 := some_object_a
			assert ("holds", eq (a1, a2) ⇒ True)
			assert ("holds_ok", properties.holds_ok (a1, a2, eq))
		end

	test_holds_successively
			-- Test {STS_EQUALITY}.holds_successively.
		note
			testing: "covers/{STS_EQUALITY}.holds_successively"
		local
			eq: like equality_to_be_tested
			a1, a2, a3: A
		do
			eq := equality_to_be_tested
			a1 := some_object_a
			assert ("a1 = a1 = a1", eq.holds_successively (a1, a1, a1))
			assert ("a1 = a1 = a1 ok", properties.holds_successively_ok (a1, a1, a1, eq))

			a2 := a1
			a3 := a2
			assert ("a1 = a2 = a3", eq.holds_successively (a1, a2, a3))
			assert ("a1 = a2 = a3 ok", properties.holds_successively_ok (a1, a2, a3, eq))

			eq := equality_to_be_tested
			a2 := some_object_a
			a3 := some_object_a
			assert ("holds_successively", eq.holds_successively (a1, a2, a3) ⇒ True)
			assert ("holds_successively_ok", properties.holds_successively_ok (a1, a2, a3, eq))
		end

feature {NONE} -- Factory (Element to be tested)

	equality_to_be_tested: EQ
			-- Equality meant to be under tests
		do
			Result := some_immediate_equality_a
		end

feature -- Factory (Equality)

	some_immediate_equality_a: EQ
			-- Some monomorphic equality of type {EQ}
		deferred
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""

end


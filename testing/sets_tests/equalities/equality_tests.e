note
	description: "Test suite for {EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQUALITY_TESTS

inherit
	ELEMENT_TESTS
		rename
			element_to_be_tested as equality_to_be_tested
		undefine
			equality_to_be_tested
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {EQUALITY}.
		note
			testing: "covers/{EQUALITY}"
		do
			Precursor {ELEMENT_TESTS}
			test_holds
		end

feature -- Test routines (Relationship)

	test_holds
			-- Test {EQUALITY}.holds.
		note
			testing: "covers/{EQUALITY}.holds"
		local
			eq: like equality_to_be_tested
			c1, c2: detachable separate CHARACTER_REF
		do
			eq := equality_to_be_tested
			create c1
			assert ("c1 = c1", eq (c1, c1))

			c2 := c1
			assert ("c1 = c2", eq (c1, c2))

			create c2
			assert ("holds", eq (c1, c2) ⇒ True)
		end

feature {NONE} -- Factory (Element to be tested)

	equality_to_be_tested: EQUALITY [detachable separate CHARACTER_REF]
			-- Equality meant to be under tests
		deferred
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end


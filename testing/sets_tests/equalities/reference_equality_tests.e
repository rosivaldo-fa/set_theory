note
	description: "Test suite for {REFERENCE_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	REFERENCE_EQUALITY_TESTS

inherit
	EQUALITY_TESTS
		redefine
			test_holds
		end

feature -- Test routines (Relationship)

	test_holds
			-- Test {REFERENCE_EQUALITY}.holds.
		note
			testing: "covers/{REFERENCE_EQUALITY}.holds"
		local
			eq: like equality_to_be_tested
			c1, c2: detachable separate CHARACTER_REF
		do
			Precursor {EQUALITY_TESTS}

			eq := equality_to_be_tested
			create c1
			create c2
			assert ("c1 /= c2", not eq (c1, c2))
		end

feature {NONE} -- Factory (Element to be tested)

	equality_to_be_tested: REFERENCE_EQUALITY [detachable separate CHARACTER_REF]
			-- <Precursor>
		do
			create Result
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

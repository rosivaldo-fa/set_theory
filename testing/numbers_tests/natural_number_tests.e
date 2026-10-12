note
	description: "Test suite for {NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	NATURAL_NUMBER_TESTS

inherit
	ELEMENT_TESTS
		rename
			element_to_be_tested as natural_number_to_be_tested
		undefine
			natural_number_to_be_tested
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {NATURAL_NUMBER}.
		note
			testing: "covers/{NATURAL_NUMBER}"
		do
			Precursor {ELEMENT_TESTS}
		end

feature -- Factory (element to be tested)

	natural_number_to_be_tested: NATURAL_NUMBER
			-- Natural number meant to be under tests
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

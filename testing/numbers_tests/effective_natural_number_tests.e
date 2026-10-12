note
	description: "Test suite for {EFFECTIVE_NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	EFFECTIVE_NATURAL_NUMBER_TESTS

inherit
	NATURAL_NUMBER_TESTS
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {EFFECTIVE_NATURAL_NUMBER}.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}"
		do
			Precursor {NATURAL_NUMBER_TESTS}
			test_default_create
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {EFFECTIVE_NATURAL_NUMBER}.default_create.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.default_create"
		do
			assert ("default_create", attached (create {like natural_number_to_be_tested}))
		end

feature -- Factory (element to be tested)

	natural_number_to_be_tested: EFFECTIVE_NATURAL_NUMBER
			-- Natural number meant to be under tests
		once
			create Result
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end

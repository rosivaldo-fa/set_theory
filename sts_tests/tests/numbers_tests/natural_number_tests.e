note
	description: "Test suite for {STS_NATURAL_NUMBER}"
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
		redefine
			test_all,
			natural_number_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_NATURAL_NUMBER}.
		note
			testing: "covers/{STS_NATURAL_NUMBER}"
		do
			Precursor {ELEMENT_TESTS}
			test_value
		end

feature -- Test routines (Primitive)

	test_value
			-- Test {STS_NATURAL_NUMBER}.value.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.value"
		do
			assert ("value", attached natural_number_to_be_tested.value)
		end

feature {NONE} -- Factory (element to be tested)

	natural_number_to_be_tested: like some_immediate_natural_number
			-- Natural number meant to be under tests
		do
			Result := some_immediate_natural_number
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

note
	description: "Test suite for {STS_RATIONAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	RATIONAL_NUMBER_TESTS

inherit
	ELEMENT_TESTS
		rename
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as rational_number_to_be_tested
		redefine
			test_all,
			rational_number_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_RATIONAL_NUMBER}.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}"
		do
			Precursor {ELEMENT_TESTS}
			test_p
		end

feature -- Test routines (Primitive)

	test_p
			-- Test {STS_RATIONAL_NUMBER}.p.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.p"
		local
			pq: like rational_number_to_be_tested
		do
			pq := rational_number_to_be_tested
			assert ("p", attached pq.p)
		end

feature {NONE} -- Factory (element to be tested)

	rational_number_to_be_tested: like some_immediate_rational_number
			-- Rational number meant to be under tests
		do
			Result := some_immediate_rational_number
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

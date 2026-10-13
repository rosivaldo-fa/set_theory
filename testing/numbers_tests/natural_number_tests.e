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
			test_is_in as test_element_is_in,
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
			test_is_in
		end

feature -- Test routines (Membership)

	test_is_in
			-- Test {NATURAL_NUMBER}.is_in.
		note
			testing: "covers/{NATURAL_NUMBER}.is_in"
		local
			n: like natural_number_to_be_tested
			s: SET [NATURAL_NUMBER]
		do
			n := natural_number_to_be_tested
			create {EFFECTIVE_SET [NATURAL_NUMBER]} s
			s := s.extended (n, create {REFERENCE_EQUALITY [NATURAL_NUMBER]})
			assert ("n ∈ s", n ∈ s)

			s := s.prunned (n)
			assert ("not (n ∈ s)", not (n ∈ s))
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

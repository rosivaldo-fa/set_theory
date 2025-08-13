note
	description: "Test suite for {STI_RATIONAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	TODO: "AutoTest may confuse {STST_RATIONAL_NUMBER_TESTS} with {RATIONAL_NUMBER_TESTS}."

class
	RATIONAL_NUMBER_EFFECTIVE_TESTS

inherit
	STST_RATIONAL_NUMBER_TESTS
		rename
			some_immediate_natural_number as some_expanded_natural_number,
			some_immediate_integer_number as some_expanded_integer_number,
			some_immediate_rational_number as some_expanded_rational_number
		undefine
			default_create,
			test_element_is_in,
			test_element_is_not_in,
			same_natural_number,
			some_natural_set,
			same_integer_number,
			some_integer_set,
			same_rational_number
		redefine
			test_all,
			test_p,
			test_numerator,
			test_q,
			test_denominator,
			test_is_in,
			test_is_not_in
		end

	ELEMENT_EFFECTIVE_TESTS
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as rational_number_to_be_tested
		undefine
			rational_number_to_be_tested
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_RATIONAL_NUMBER}.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
			test_default_create
			test_p
			test_q
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {STI_RATIONAL_NUMBER}.default_create.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.default_create"
		do
			assert ("default_create", attached (create {like rational_number_to_be_tested}))
		end

feature -- Test routines (Primitive)

	test_p
			-- Test {STI_RATIONAL_NUMBER}.p.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.p"
		local
			pq: like rational_number_to_be_tested
		do
			pq := rational_number_to_be_tested
			assert ("p", attached pq.p)
		end

	test_numerator
			-- Test every routine of {STI_RATIONAL_NUMBER}.numerator.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.numerator"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_q
			-- Test {STI_RATIONAL_NUMBER}.q.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.q"
		local
			pq: like rational_number_to_be_tested
		do
			pq := rational_number_to_be_tested
			assert ("q", attached pq.q)
		end

	test_denominator
			-- Test every routine of {STI_RATIONAL_NUMBER}.denominator.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.denominator"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

feature -- Test routines (Membership)

	test_is_in
			-- Test {STS_RATIONAL_NUMBER}.is_in.
			-- Test {STI_RATIONAL_NUMBER}.is_in.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_in"
			testing: "covers/{STI_RATIONAL_NUMBER}.is_in"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_is_not_in
			-- Test {STS_RATIONAL_NUMBER}.is_not_in.
			-- Test {STI_RATIONAL_NUMBER}.is_not_in.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_not_in"
			testing: "covers/{STI_RATIONAL_NUMBER}.is_not_in"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

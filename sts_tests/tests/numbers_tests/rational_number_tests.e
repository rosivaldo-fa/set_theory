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
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as rational_number_to_be_tested
		redefine
			test_all,
			rational_number_to_be_tested
		end

	RATIONAL_NUMBER_PROPERTIES

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_RATIONAL_NUMBER}.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}"
		do
			Precursor {ELEMENT_TESTS}
			test_p
			test_numerator
			test_q
			test_denominator
			test_is_in
			test_is_not_in
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

	test_numerator
			-- Test {STS_RATIONAL_NUMBER}.numerator.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.numerator"
		local
			pq: like rational_number_to_be_tested
		do
			pq := rational_number_to_be_tested
			assert ("numerator", attached pq.numerator)
		end

	test_q
			-- Test {STS_RATIONAL_NUMBER}.q.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.q"
		local
			pq: like rational_number_to_be_tested
		do
			pq := rational_number_to_be_tested
			assert ("q", attached pq.q)
		end

	test_denominator
			-- Test {STS_RATIONAL_NUMBER}.denominator.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.denominator"
		local
			pq: like rational_number_to_be_tested
		do
			pq := rational_number_to_be_tested
			assert ("denominator", attached pq.denominator)
		end

feature -- Test routines (Membership)

	test_is_in
			-- Test {STS_RATIONAL_NUMBER}.is_in.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_in"
		local
			pq: like rational_number_to_be_tested
			s: like some_set_r
		do
			pq := rational_number_to_be_tested
			s := some_set_r.extended (pq, some_equality_r)
			assert ("pq ∈ s", pq ∈ s)

			pq := rational_number_to_be_tested
			s := some_set_r.prunned (pq)
			assert ("not (pq ∈ s)", not (pq ∈ s))

			pq := rational_number_to_be_tested
			s := some_set_r
			assert ("is_in", pq ∈ s ⇒ True)
		end

	test_is_not_in
			-- Test {STS_RATIONAL_NUMBER}.is_not_in.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_not_in"
		local
			pq: like rational_number_to_be_tested
			s: like some_set_r
		do
			pq := rational_number_to_be_tested
			s := some_set_r.prunned (pq)
			assert ("pq ∉ s", pq ∉ s)
			assert ("pq ∉ s ok", is_not_in_ok (pq, s))

			pq := rational_number_to_be_tested
			s := some_set_r.extended (pq, some_equality_r)
			assert ("not (pq ∉ s)", not (pq ∉ s))
			assert ("not (pq ∉ s) ok", is_not_in_ok (pq, s))

			pq := rational_number_to_be_tested
			s := some_set_r
			assert ("is_not_in", pq ∉ s ⇒ True)
			assert ("is_not_in_ok", is_not_in_ok (pq, s))
		end

feature -- Test routines (Access)

	test_zero
			-- Test {STS_RATIONAL_NUMBER}.zero.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.zero"
		local
			pq: like rational_number_to_be_tested
		do
			pq := rational_number_to_be_tested
			assert ("zero", attached pq.Zero)
		end

	test_one
			-- Test {STS_RATIONAL_NUMBER}.one.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.one"
		local
			pq: like rational_number_to_be_tested
		do
			pq := rational_number_to_be_tested
			assert ("one", attached pq.one)
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

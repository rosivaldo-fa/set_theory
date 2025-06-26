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
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
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

feature -- Test routines (Membership)

	test_is_in
			-- Test {STS_NATURAL_NUMBER}.is_in.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_in"
		local
			n: like natural_number_to_be_tested
			s: like some_set_of_natural_numbers
		do
			n := natural_number_to_be_tested
			s := some_set_of_natural_numbers.extended (n, some_natural_number_equality)
			assert ("n ∈ s", n ∈ s)

			n := natural_number_to_be_tested
			s := some_set_of_natural_numbers.prunned (n)
			assert ("not (n ∈ s)", not (n ∈ s))

			n := natural_number_to_be_tested
			s := some_set_of_natural_numbers
			assert ("is_in", n ∈ s ⇒ True)
		end

	test_is_not_in
			-- Test {STS_NATURAL_NUMBER}.is_not_in.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_not_in"
		local
			n: like natural_number_to_be_tested
			s: like some_set_of_natural_numbers
		do
			n := natural_number_to_be_tested
			s := some_set_of_natural_numbers.prunned (n)
			assert ("n ∉ s", n ∉ s)
			assert ("n ∉ s ok", is_not_in_ok (n, s))

			n := natural_number_to_be_tested
			s := some_set_of_natural_numbers.extended (n, some_natural_number_equality)
			assert ("not (n ∉ s)", not (n ∉ s))
			assert ("not (n ∉ s) ok", is_not_in_ok (n, s))

			n := natural_number_to_be_tested
			s := some_set_of_natural_numbers
			assert ("is_not_in", n ∉ s ⇒ True)
			assert ("is_not_in_ok", is_not_in_ok (n, s))
		end

feature -- Test routines (Access)

	test_zero
			-- Test {STI_NATURAL_NUMBER}.zero.
		note
			testing: "covers/{STI_NATURAL_NUMBER}.zero"
		local
			n: like natural_number_to_be_tested
		do
			n := natural_number_to_be_tested
			assert ("zero", attached n.Zero)
		end

	test_one
			-- Test {STI_NATURAL_NUMBER}.one.
		note
			testing: "covers/{STI_NATURAL_NUMBER}.one"
		local
			n: like natural_number_to_be_tested
		do
			n := natural_number_to_be_tested
			assert ("one", attached n.One)
		end

feature -- Test routines (Implementation)

	test_adjusted_value
			-- Test {STS_NATURAL_NUMBER}.adjusted_value.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.adjusted_value"
		do
			assert ("adjusted_value", attached natural_number_to_be_tested.adjusted_value (next_random_item.as_natural_32))
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

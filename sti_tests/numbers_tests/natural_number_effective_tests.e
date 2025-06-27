note
	description: "Test suite for {STI_NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	TODO: "AutoTest may confuse {STST_NATURAL_NUMBER_TESTS} with {NATURAL_NUMBER_TESTS}."

class
	NATURAL_NUMBER_EFFECTIVE_TESTS

inherit
	STST_NATURAL_NUMBER_TESTS
		rename
			some_immediate_natural_number as some_expanded_natural_number
		undefine
			default_create,
			test_element_is_in,
			test_element_is_not_in,
			same_natural_number
		redefine
			test_all,
			test_value,
			test_is_in,
			test_is_not_in,
			test_zero,
			test_one,
			test_equals,
			test_unequals,
			test_is_less,
			test_is_less_equal,
			test_is_greater,
			test_is_greater_equal,
			test_adjusted_value
		end

	ELEMENT_TESTS
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as natural_number_to_be_tested
		undefine
			test_all,
			natural_number_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_NATURAL_NUMBER}.
		note
			testing: "covers/{STI_NATURAL_NUMBER}"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {STI_NATURAL_NUMBER}.default_create.
		note
			testing: "covers/{STI_NATURAL_NUMBER}.default_create"
		do
			assert ("default_create", attached (create {like natural_number_to_be_tested}))
		end

	test_make
			-- Test {STI_NATURAL_NUMBER}.make.
		note
			testing: "covers/{STI_NATURAL_NUMBER}.make"
		do
			assert ("make", attached (create {like natural_number_to_be_tested}.make (next_random_item.as_natural_32)))
			assert ("natural_number_from_native", attached natural_number_from_native (next_random_item.as_natural_32))
		end

feature -- Test routines (Primitive)

	test_value
			-- Test {STI_NATURAL_NUMBER}.value.
		note
			testing: "covers/{STI_NATURAL_NUMBER}.value"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

feature -- Test routines (Membership)

	test_is_in
			-- <Precursor>
			-- Test {STI_NATURAL_NUMBER}.is_in.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_in"
			testing: "covers/{STI_NATURAL_NUMBER}.is_in"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

	test_is_not_in
			-- <Precursor>
			-- Test {STI_NATURAL_NUMBER}.is_not_in.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_not_in"
			testing: "covers/{STI_NATURAL_NUMBER}.is_not_in"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

feature -- Test routines (Access)

	test_zero
			-- <Precursor>
		note
			testing: "covers/{STI_NATURAL_NUMBER}.zero"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

	test_one
			-- <Precursor>
		note
			testing: "covers/{STI_NATURAL_NUMBER}.one"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

feature -- Test routines (Comparison)

	test_equals
			-- <Precursor>
			-- Test {STI_NATURAL_NUMBER}.equals.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.equals"
			testing: "covers/{STI_NATURAL_NUMBER}.equals"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

	test_unequals
			-- <Precursor>
			-- Test {STI_NATURAL_NUMBER}.unequals.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.unequals"
			testing: "covers/{STI_NATURAL_NUMBER}.unequals"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

	test_is_less
			-- <Precursor>
			-- Test {STI_NATURAL_NUMBER}.is_less.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_less"
			testing: "covers/{STI_NATURAL_NUMBER}.is_less"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

	test_is_less_equal
			-- <Precursor>
			-- Test {STI_NATURAL_NUMBER}.is_less_equal.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_less_equal"
			testing: "covers/{STI_NATURAL_NUMBER}.is_less_equal"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

	test_is_greater
			-- <Precursor>
			-- Test {STI_NATURAL_NUMBER}.is_greater.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_greater"
			testing: "covers/{STI_NATURAL_NUMBER}.is_greater"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

	test_is_greater_equal
			-- <Precursor>
			-- Test {STI_NATURAL_NUMBER}.is_greater_equal.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_greater_equal"
			testing: "covers/{STI_NATURAL_NUMBER}.is_greater_equal"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

feature -- Test routines (Implementation)

	test_adjusted_value
			-- Test {STI_NATURAL_NUMBER}.adjusted_value.
		note
			testing: "covers/{STI_NATURAL_NUMBER}.adjusted_value"
		do
			assert ("adjusted_value", attached natural_number_to_be_tested.adjusted_value (next_random_item.as_natural_32))
		end

feature {NONE} -- Conversion

	natural_number_from_native (v: like some_native_natural_number): like natural_number_to_be_tested
			-- `v' converted to a natural number like `natural_number_to_be_tested'
		do
			Result := v
		ensure
			adjusted_value: Result.value = {like natural_number_to_be_tested}.adjusted_value (v)
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end

note
	description: "Test suite for {STI_INTEGER_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	TODO: "AutoTest may confuse {STST_INTEGER_NUMBER_TESTS} with {INTEGER_NUMBER_TESTS}."

class
	INTEGER_NUMBER_EFFECTIVE_TESTS

inherit
	STST_INTEGER_NUMBER_TESTS
		rename
			some_immediate_natural_number as some_expanded_natural_number,
			some_immediate_integer_number as some_expanded_integer_number,
			some_immediate_rational_number as some_expanded_rational_number,
			some_immediate_real_number as some_expanded_real_number
		undefine
			default_create,
			test_element_is_in,
			test_element_is_not_in,
			same_natural_number,
			some_natural_set,
			same_integer_number,
			some_integer_set,
			same_rational_number,
			some_rational_set,
			same_real_number
		redefine
			test_all,
			test_value,
			test_is_in,
			test_is_not_in,
			test_zero,
			test_one,
			test_min_value,
			test_max_value,
			test_min_value_exists,
			test_max_value_exists,
			test_equals,
			test_unequals,
			test_is_less,
			test_is_less_equal,
			test_is_greater,
			test_is_greater_equal,
			test_three_way_comparison,
			test_min,
			test_max,
			test_divisible,
			test_divides,
			test_modulus,
			test_abs,
			test_plus,
			test_identity,
			test_minus,
			test_opposite,
			test_product,
			test_quotient,
			test_integer_quotient,
			test_integer_remainder,
			test_adjusted_value
		end

	ELEMENT_EFFECTIVE_TESTS
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as integer_number_to_be_tested
		undefine
			test_all,
			integer_number_to_be_tested
		end

	INTEGER_NUMBER_PROPERTIES
		undefine
			default_create
		end

feature -- Access

--	zero: STI_INTEGER_NUMBER
--			-- <Precursor>
--		once
--		ensure then
--			class
--		end

--	one: STI_INTEGER_NUMBER
--			-- <Precursor>
--		once
--			create Result.make (1)
--		ensure then
--			class
--		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_INTEGER_NUMBER}.
		note
			testing: "covers/{STI_INTEGER_NUMBER}"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
			test_default_create
			test_make
			test_make_from_reference
			test_out
			test_as_rational_number
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {STI_INTEGER_NUMBER}.default_create.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.default_create"
		do
			assert ("default_create", attached (create {like integer_number_to_be_tested}))
		end

	test_make
			-- Test {STI_INTEGER_NUMBER}.make.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.make"
		do
			assert ("make", attached (create {like integer_number_to_be_tested}.make (next_random_item)))
			assert ("integer_number_from_native", attached integer_number_from_native (next_random_item))
		end

	test_make_from_reference
			-- Test {STI_INTEGER_NUMBER}.make_from_reference.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.make_from_reference"
		do
			assert ("make_from_reference", attached (create {like integer_number_to_be_tested}.make_from_reference (some_integer_number)))
			assert ("integer_number_from_reference", attached integer_number_from_reference (some_integer_number))
		end

feature -- Test routines (Primitive)

	test_value
			-- Test {STI_INTEGER_NUMBER}.value.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.value"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

feature -- Test routines (Membership)

	test_is_in
			-- <Precursor>
			-- Test {STI_INTEGER_NUMBER}.is_in.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_in"
			testing: "covers/{STI_INTEGER_NUMBER}.is_in"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_is_not_in
			-- <Precursor>
			-- Test {STI_INTEGER_NUMBER}.is_not_in.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_not_in"
			testing: "covers/{STI_INTEGER_NUMBER}.is_not_in"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

feature -- Test routines (Access)

	test_zero
			-- Test {STI_INTEGER_NUMBER}.zero.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.zero"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_one
			-- Test {STI_INTEGER_NUMBER}.one.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.one"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_min_value
			-- Test {STI_INTEGER_NUMBER}.min_value.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.min_value"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_max_value
			-- Test {STI_INTEGER_NUMBER}.max_value.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.max_value"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

feature -- Test routines (Quality)

	test_min_value_exists
			-- Test {STI_INTEGER_NUMBER}.min_value_exists.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.min_value_exists"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_max_value_exists
			-- Test {STI_INTEGER_NUMBER}.max_value_exists.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.max_value_exists"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

feature -- Test routines (Output)

	test_out
			-- Test {STI_INTEGER_NUMBER}.out.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.out"
		local
			i: like integer_number_to_be_tested
		do
			i := integer_number_to_be_tested
			assert ("out", attached i.out)
		end

feature -- Test routines (Comparison)

	test_equals
			-- <Precursor>
			-- Test {STI_INTEGER_NUMBER}.equals.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.equals"
			testing: "covers/{STI_INTEGER_NUMBER}.equals"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_unequals
			-- <Precursor>
			-- Test {STI_INTEGER_NUMBER}.unequals.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.unequals"
			testing: "covers/{STI_INTEGER_NUMBER}.unequals"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_is_less
			-- <Precursor>
			-- Test {STI_INTEGER_NUMBER}.is_less.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_less"
			testing: "covers/{STI_INTEGER_NUMBER}.is_less"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_is_less_equal
			-- <Precursor>
			-- Test {STI_INTEGER_NUMBER}.is_less_equal.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_less_equal"
			testing: "covers/{STI_INTEGER_NUMBER}.is_less_equal"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_is_greater
			-- <Precursor>
			-- Test {STI_INTEGER_NUMBER}.is_greater.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_greater"
			testing: "covers/{STI_INTEGER_NUMBER}.is_greater"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_is_greater_equal
			-- <Precursor>
			-- Test {STI_INTEGER_NUMBER}.is_greater_equal.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_greater_equal"
			testing: "covers/{STI_INTEGER_NUMBER}.is_greater_equal"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_three_way_comparison
			-- Test {STI_INTEGER_NUMBER}.three_way_comparison.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.three_way_comparison"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_min
			-- Test {STI_INTEGER_NUMBER}.min.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.min"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_max
			-- Test {STI_INTEGER_NUMBER}.max.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.max"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

feature -- Test routines (Relationship)

	test_divisible
			-- <Precursor>
			-- Test {STI_INTEGER_NUMBER}.divisible.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.divisible"
			testing: "covers/{STI_INTEGER_NUMBER}.divisible"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_divides
			-- <Precursor>
			-- Test {STI_INTEGER_NUMBER}.divides.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.divides"
			testing: "covers/{STI_INTEGER_NUMBER}.divides"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

feature -- Test routines (Operation)

	test_modulus
			-- Test {STI_INTEGER_NUMBER}.modulus.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.modulus"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_abs
			-- Test {STI_INTEGER_NUMBER}.abs.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.abs"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_plus
			-- Test {STI_INTEGER_NUMBER}.plus.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.plus"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_identity
			-- <Precursor>
			-- Test {STI_INTEGER_NUMBER}.identity.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.identity"
			testing: "covers/{STI_INTEGER_NUMBER}.identity"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_minus
			-- Test {STI_INTEGER_NUMBER}.minus.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.minus"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_opposite
			-- Test {STI_INTEGER_NUMBER}.opposite.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.opposite"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_product
			-- Test {STI_INTEGER_NUMBER}.product.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.product"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_quotient
			-- Test {STI_INTEGER_NUMBER}.quotient.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.quotient"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_integer_quotient
			-- Test {STI_INTEGER_NUMBER}.integer_quotient.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.integer_quotient"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

	test_integer_remainder
			-- Test {STI_INTEGER_NUMBER}.integer_remainder.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.integer_remainder"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

feature -- Test routines (Conversion)

	test_as_rational_number
			-- Test {STI_INTEGER_NUMBER}.as_rational_number.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.as_rational_number"
		local
			i: like integer_number_to_be_tested
		do
			i := integer_number_to_be_tested
			assert ("as_rational_number", attached i.as_rational_number)
			assert ("integer_as_rational", attached integer_as_rational (i))
			assert ("as_rational_number_ok", as_rational_number_ok (i))
		end

feature -- Test routines (Implementation)

	test_adjusted_value
			-- Test {STI_INTEGER_NUMBER}.adjusted_value.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.adjusted_value"
		do
			Precursor {STST_INTEGER_NUMBER_TESTS}
		end

feature {NONE} -- Conversion

	integer_number_from_native (v: like some_native_integer): like integer_number_to_be_tested
			-- `v' converted to a integer number like `integer_number_to_be_tested'
		do
			Result := v
		ensure
			adjusted_value: Result.value = {like integer_number_to_be_tested}.adjusted_value (v)
		end

	integer_number_from_reference (i: like some_integer_number): like integer_number_to_be_tested
			-- `i' converted to an integer number like `integer_number_to_be_tested'
		do
			Result := i
		ensure
			same_integer_number: Result ≍ i
		end

	integer_as_rational (i: STI_INTEGER_NUMBER): STI_RATIONAL_NUMBER
			-- `i' converted to an {STI_RATIONAL_NUMBER}
		do
			Result := i
		ensure
			definition: Result ≍ i
		end

feature -- Anchor

--	integer_anchor: STI_INTEGER_NUMBER
--			-- <Precursor>
--		once
--		ensure then
--			class
--		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end

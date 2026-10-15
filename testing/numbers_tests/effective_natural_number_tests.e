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
			test_all,
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
			test_min,
			test_max,
			test_divisible,
			test_plus,
			test_identity,
			test_minus,
			test_product,
			test_natural_quotient
		end

feature -- Access

	zero: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

	one: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 1
		ensure then
			class
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {EFFECTIVE_NATURAL_NUMBER}.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}"
		do
			Precursor {NATURAL_NUMBER_TESTS}
			test_default_create
			test_make
			test_make_from_reference
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {EFFECTIVE_NATURAL_NUMBER}.default_create.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.default_create"
		do
			assert ("default_create", attached (create {like natural_number_to_be_tested}))
		end

	test_make
			-- Test {EFFECTIVE_NATURAL_NUMBER}.make.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.make"
		do
			assert ("make", attached (create {like natural_number_to_be_tested}.make (1)))
			assert ("natural_number_from_native", attached natural_number_from_native (1))
		end

	test_make_from_reference
			-- Test {EFFECTIVE_NATURAL_NUMBER}.make_from_reference.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.make_from_reference"
		do
			assert ("make_from_reference", attached (create {like natural_number_to_be_tested}.make_from_reference (create {EFFECTIVE_NATURAL_NUMBER}.make (1))))
			assert ("natural_number_from_reference", attached natural_number_from_reference (create {EFFECTIVE_NATURAL_NUMBER}.make (1)))
		end

feature -- Test routines (Membership)

	test_is_in
			-- <Precursor>
			-- Test {EFFECTIVE_NATURAL_NUMBER}.is_in.
		note
			testing: "covers/{NATURAL_NUMBER}.is_in"
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.is_in"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_is_not_in
			-- <Precursor>
			-- Test {EFFECTIVE_NATURAL_NUMBER}.is_not_in.
		note
			testing: "covers/{NATURAL_NUMBER}.is_not_in"
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.is_not_in"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

feature -- Test routines (Access)

	test_zero
			-- Test {EFFECTIVE_NATURAL_NUMBER}.zero.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.zero"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_one
			-- Test {EFFECTIVE_NATURAL_NUMBER}.one.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.one"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

feature -- Test routines (Comparison)

	test_equals
			-- <Precursor>
			-- Test {EFFECTIVE_NATURAL_NUMBER}.equals.
		note
			testing: "covers/{NATURAL_NUMBER}.equals"
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.equals"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_unequals
			-- <Precursor>
			-- Test {EFFECTIVE_NATURAL_NUMBER}.unequals.
		note
			testing: "covers/{NATURAL_NUMBER}.unequals"
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.unequals"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_is_less
			-- <Precursor>
			-- Test {EFFECTIVE_NATURAL_NUMBER}.is_less.
		note
			testing: "covers/{NATURAL_NUMBER}.is_less"
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.is_less"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_is_less_equal
			-- <Precursor>
			-- Test {EFFECTIVE_NATURAL_NUMBER}.is_less_equal.
		note
			testing: "covers/{NATURAL_NUMBER}.is_less_equal"
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.is_less_equal"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_is_greater
			-- <Precursor>
			-- Test {EFFECTIVE_NATURAL_NUMBER}.is_greater.
		note
			testing: "covers/{NATURAL_NUMBER}.is_greater"
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.is_greater"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_is_greater_equal
			-- <Precursor>
			-- Test {EFFECTIVE_NATURAL_NUMBER}.is_greater_equal.
		note
			testing: "covers/{NATURAL_NUMBER}.is_greater_equal"
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.is_greater_equal"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_min
			-- Test {EFFECTIVE_NATURAL_NUMBER}.min.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.min"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_max
			-- Test {EFFECTIVE_NATURAL_NUMBER}.max.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.max"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

feature -- Test routines (Relationship)

	test_divisible
			-- <Precursor>
			-- Test {EFFECTIVE_NATURAL_NUMBER}.divisible.
		note
			testing: "covers/{NATURAL_NUMBER}.divisible"
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.divisible"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

feature -- Test routines (Operation)

	test_plus
			-- Test {EFFECTIVE_NATURAL_NUMBER}.plus.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.plus"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_identity
			-- <Precursor>
			-- Test {EFFECTIVE_NATURAL_NUMBER}.identity.
		note
			testing: "covers/{NATURAL_NUMBER}.identity"
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.identity"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_minus
			-- Test {EFFECTIVE_NATURAL_NUMBER}.minus.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.minus"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_product
			-- Test {EFFECTIVE_NATURAL_NUMBER}.product.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.product"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

	test_natural_quotient
			-- Test {EFFECTIVE_NATURAL_NUMBER}.natural_quotient.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.natural_quotient"
		do
			Precursor {NATURAL_NUMBER_TESTS}
		end

feature -- Factory (element to be tested)

	natural_number_to_be_tested: EFFECTIVE_NATURAL_NUMBER
			-- Natural number meant to be under tests
		once
			create Result
		ensure then
			class
		end

feature -- Conversion

	natural_number_from_native (v: like native_natural_anchor): like natural_number_to_be_tested
			-- `v' converted to a natural number like `natural_number_to_be_tested'
		do
			Result := v
		ensure then
			class
			adjusted_value: Result.value = {like natural_number_to_be_tested}.adjusted_value (v)
		end

	natural_number_from_reference (n: NATURAL_NUMBER): like natural_number_to_be_tested
			-- `n' converted to a natural number like `natural_number_to_be_tested'
		do
			Result := n
		ensure
			class
--			same_natural_number: Result ≍ n
		end

feature -- Anchor

	native_natural_anchor: NATURAL
			-- <Precursor>
		do
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

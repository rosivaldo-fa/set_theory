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
			multipliable_ok,
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
			test_is_not_in,
			test_sign,
			test_zero,
			test_one,
			test_is_integer,
			test_is_invertible,
			test_equals,
			test_unequals,
			test_is_less,
			test_is_less_equal,
			test_is_greater,
			test_is_greater_equal,
			test_three_way_comparison,
			test_multipliable,
			test_divisible,
			test_min,
			test_max,
			test_modulus,
			test_abs,
			test_plus,
			test_minus,
			test_opposite,
			test_reciprocal,
			test_inverse,
			test_gcd,
			test_div,
			test_rem,
			test_converted_integer,
			test_integer_product_overflows
		end

	RATIONAL_NUMBER_PROPERTIES
		undefine
			default_create
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
			test_make
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

	test_make
			-- Test {STI_RATIONAL_NUMBER}.make.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.make"
		local
			num, den: like some_integer_number
		do
			num := some_integer_number
			from
				den := some_integer_number
			until
				den ≭ {STI_INTEGER_NUMBER}.Zero
			loop
				den := some_integer_number
			end
			assert ("make", attached (create {like rational_number_to_be_tested}.make (num, den)))
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

feature -- Test routines (Access)

	test_sign
			-- Test {STI_RATIONAL_NUMBER}.sign.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.sign"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_zero
			-- Test {STI_RATIONAL_NUMBER}.zero.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.zero"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_one
			-- Test {STI_RATIONAL_NUMBER}.one.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.one"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

feature -- Test routines (Quality)

	test_is_integer
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.is_integer.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_integer"
			testing: "covers/{STI_RATIONAL_NUMBER}.is_integer"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_is_invertible
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.is_invertible.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_invertible"
			testing: "covers/{STI_RATIONAL_NUMBER}.is_invertible"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

feature -- Test routines (Comparison)

	test_equals
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.equals.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.equals"
			testing: "covers/{STI_RATIONAL_NUMBER}.equals"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_unequals
			-- <Precursor>
			-- Test {STS_RATIONAL_NUMBER}.unequals.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.unequals"
			testing: "covers/{STI_RATIONAL_NUMBER}.unequals"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_is_less
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.is_less.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_less"
			testing: "covers/{STI_RATIONAL_NUMBER}.is_less"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_is_less_equal
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.is_less_equal.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_less_equal"
			testing: "covers/{STI_RATIONAL_NUMBER}.is_less_equal"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_is_greater
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.is_greater.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_greater"
			testing: "covers/{STI_RATIONAL_NUMBER}.is_greater"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_is_greater_equal
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.is_greater_equal.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_greater_equal"
			testing: "covers/{STI_RATIONAL_NUMBER}.is_greater_equal"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_three_way_comparison
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.three_way_comparison.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.three_way_comparison"
			testing: "covers/{STI_RATIONAL_NUMBER}.three_way_comparison"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_min
			-- Test {STI_RATIONAL_NUMBER}.min.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.min"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_max
			-- Test {STI_RATIONAL_NUMBER}.max.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.max"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

feature -- Test routines (Relationship)

	test_multipliable
			-- Test {STI_RATIONAL_NUMBER}.multipliable.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.multipliable"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			check
				good_divisor_1: pq_1.q.divisible (gcd (pq_2.p, pq_1.q)) -- pq_1.q /= 0
				good_divisor_2: pq_2.q.divisible (gcd (pq_1.p, pq_2.q)) -- pq_2.q /= 0
			end
			assert (
					"even when overflows",
					pq_1.integer_product_overflows (pq_1.q // gcd (pq_2.p, pq_1.q), pq_2.q // gcd (pq_1.p, pq_2.q)) and
					(pq_1.q // gcd (pq_2.p, pq_1.q)) ⋅ (pq_2.q // gcd (pq_1.p, pq_2.q)) ≭ Zero.p ⇒
					pq_1.multipliable (pq_2)
				)
			assert ("even when overflows ok", multipliable_ok (pq_1, pq_2))
		end

	test_divisible
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.divisible.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.divisible"
			testing: "covers/{STI_RATIONAL_NUMBER}.divisible"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			check
				good_divisor_1: pq_1.q.divisible (gcd (pq_2.q, pq_1.q)) -- pq_1.q, pq_2.q /= 0
				good_divisor_2: pq_2 ≭ zero ⇒ pq_2.p.divisible (gcd (pq_1.p, pq_2.p)) -- pq_2.p /= 0 ⇐ pq_2 ≭ zero
			end
			assert (
					"even when overflows",
					pq_2 ≭ zero and then pq_1.integer_product_overflows (pq_1.q // gcd (pq_2.q, pq_1.q), pq_2.p // gcd (pq_1.p, pq_2.p)) and
					(pq_1.q // gcd (pq_2.q, pq_1.q)) ⋅ (pq_2.p // gcd (pq_1.p, pq_2.p)) ≭ Zero.p ⇒
					pq_1.divisible (pq_2)
				)
			assert ("even when overflows ok", divisible_ok (pq_1, pq_2))
		end

feature -- Test routines (Operation)

	test_modulus
			-- Test {STI_RATIONAL_NUMBER}.modulus.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.modulus"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_abs
			-- Test {STI_RATIONAL_NUMBER}.abs.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.abs"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_plus
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.plus.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.plus"
			testing: "covers/{STI_RATIONAL_NUMBER}.plus"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_minus
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.minus.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.minus"
			testing: "covers/{STI_RATIONAL_NUMBER}.minus"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_opposite
			-- Test {STI_RATIONAL_NUMBER}.opposite.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.opposite"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_reciprocal
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.reciprocal.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.reciprocal"
			testing: "covers/{STI_RATIONAL_NUMBER}.reciprocal"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_inverse
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.inverse.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.inverse"
			testing: "covers/{STI_RATIONAL_NUMBER}.inverse"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

feature -- Test routines (Math)

	test_gcd
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.gcd.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.gcd"
			testing: "covers/{STI_RATIONAL_NUMBER}.gcd"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_div
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.div.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.div"
			testing: "covers/{STI_RATIONAL_NUMBER}.div"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

	test_rem
			-- <Precursor>
			-- Test {STI_RATIONAL_NUMBER}.rem.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.rem"
			testing: "covers/{STI_RATIONAL_NUMBER}.rem"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

feature -- Test routines (Factory)

	test_converted_integer
			-- Test {STI_RATIONAL_NUMBER}.converted_integer.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.converted_integer"
		do
			Precursor {STST_RATIONAL_NUMBER_TESTS}
		end

feature -- Test routines (Predicate)

	test_integer_product_overflows
			-- Test {STI_RATIONAL_NUMBER}.integer_product_overflows.
		note
			testing: "covers/{STI_RATIONAL_NUMBER}.integer_product_overflows"
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

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

feature -- Access

	zero: like rational_anchor
			-- The rational number 0/1
		deferred
		end

	one: like rational_anchor
			-- The rational number 1/1
		deferred
		ensure
			definition: Result.p ≍ Result.q
		end

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
			test_sign
			test_zero
			test_one
			test_is_integer
			test_is_invertible
			test_equals
			test_unequals
			test_is_less
			test_is_less_equal
			test_is_greater
			test_is_greater_equal
			test_three_way_comparison
			test_multipliable
			test_divisible
			test_min
			test_max
			test_reciprocal
			test_inverse
			test_gcd
			test_div
			test_rem
			test_converted_integer
			test_integer_product_overflows
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

	test_sign
			-- Test {STS_RATIONAL_NUMBER}.sign.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.sign"
		local
			pq: like rational_number_to_be_tested
		do
			from
				pq := rational_number_to_be_tested
			until
				pq < Zero
			loop
				pq := rational_number_to_be_tested
			end
			assert ("negative", pq.sign ≍ - pq.sign.one)

			pq := Zero
			assert ("unchanged zero", (- pq).sign ≍ Zero.p)
			assert ("just zero", pq.sign ≍ Zero.p)

			from
				pq := rational_number_to_be_tested
			until
				pq > Zero
			loop
				pq := rational_number_to_be_tested
			end
			assert ("positive", pq.sign ≍ pq.sign.one)

			assert ("sign", attached rational_number_to_be_tested.sign)
		end

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

feature -- Test routines (Quality)

	test_is_integer
			-- Test {STS_RATIONAL_NUMBER}.is_integer.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_integer"
		local
			pq: like rational_number_to_be_tested
		do
			from
				pq := rational_number_to_be_tested
			until
				(pq.p \\ pq.q) ≍ zero.p
			loop
				pq := rational_number_to_be_tested
			end
			assert ("pq.is_integer", pq.is_integer)

			from
				pq := rational_number_to_be_tested
				check
					good_divisor: pq.q ≭ zero.p -- {STS_RATIONAL_NUMBER} invariant
				end
			until
				(pq.p \\ pq.q) ≭ zero.p
			loop
				pq := rational_number_to_be_tested
				check
					good_divisor: pq.q ≭ zero.p -- {STS_RATIONAL_NUMBER} invariant
				end
			end
			assert ("not pq.is_integer", not pq.is_integer)

			pq := rational_number_to_be_tested
			assert ("is_integer", pq.is_integer implies True)
		end

	test_is_invertible
			-- Test {STS_RATIONAL_NUMBER}.is_invertible.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_invertible"
		local
			pq: like rational_number_to_be_tested
		do
			from
				pq := rational_number_to_be_tested
			until
				pq.p ≭ zero.p
			loop
				pq := rational_number_to_be_tested
			end
			assert ("pq.is_invertible", pq.is_invertible)

			pq := Zero
			assert ("not pq.is_invertible", not pq.is_invertible)

			pq := rational_number_to_be_tested
			assert ("is_invertible", pq.is_invertible implies True)
		end

feature -- Test routines (Comparison)

	test_equals
			-- Test {STS_RATIONAL_NUMBER}.equals.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.equals"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			pq_1 := rational_number_to_be_tested
			assert ("same_entity", pq_1 ≍ pq_1)
			assert ("same_entity_ok", equals_ok (pq_1, pq_1, pq_1))

			pq_1 := rational_number_to_be_tested
			pq_2 := same_rational_number (pq_1)
			assert ("same_rational", pq_1 ≍ pq_2)
			assert ("same_rational_ok", equals_ok (pq_1, pq_2, same_rational_number (pq_2)))

			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			assert ("some_rational_number", pq_1 ≍ pq_2 ⇒ True)
			assert ("equals_ok", equals_ok (pq_1, pq_2, some_rational_number))
		end

	test_unequals
			-- Test {STS_RATIONAL_NUMBER}.unequals.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.unequals"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			pq_1 := rational_number_to_be_tested
			from
				pq_2 := some_rational_number
			until
				not (pq_1 ≍ pq_2)
			loop
				pq_2 := some_rational_number
			end
			assert ("pq_1 ≭ pq_2", pq_1 ≭ pq_2)
			assert ("pq_1 ≭ pq_2 ok", unequals_ok (pq_1))

			pq_1 := rational_number_to_be_tested
			pq_2 := same_rational_number (pq_1)
			assert ("not (pq_1 ≭ pq_2)", not (pq_1 ≭ pq_2))
			assert ("not (pq_1 ≭ pq_2) ok", unequals_ok (pq_1))

			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			assert ("unequals", pq_1 ≭ pq_2 ⇒ True)
			assert ("unequals ok", unequals_ok (pq_1))
		end

	test_is_less
			-- Test {STS_RATIONAL_NUMBER}.is_less.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_less"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			invariant
					-- {STS_RATIONAL_NUMBER} invariant
				good_divisor_1: pq_1.q.value /= 0
				good_divisor_2: pq_2.q.value /= 0
			until
				(pq_1.p.value / pq_1.q.value) < (pq_2.p.value / pq_2.q.value)
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("pq_1 < pq_2", pq_1 < pq_2)
			assert ("pq_1 < pq_2 ok", is_less_ok (pq_1, pq_2, some_rational_number))

			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			invariant
					-- {STS_RATIONAL_NUMBER} invariant
				good_divisor_1: pq_1.q.value /= 0
				good_divisor_2: pq_2.q.value /= 0
			until
				(pq_1.p.value / pq_1.q.value) ≥ (pq_2.p.value / pq_2.q.value)
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("not (pq_1 < pq_2)", not (pq_1 < pq_2))
			assert ("not (pq_1 < pq_2) ok", is_less_ok (pq_1, pq_2, some_rational_number))

			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			assert ("is_less", pq_1 < pq_2 ⇒ True)
			assert ("is_less ok", is_less_ok (pq_1, pq_2, some_rational_number))
		end

	test_is_less_equal
			-- Test {STS_RATIONAL_NUMBER}.is_less_equal.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_less_equal"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			invariant
					-- {STS_RATIONAL_NUMBER} invariant
				good_divisor_1: pq_1.q.value /= 0
				good_divisor_2: pq_2.q.value /= 0
			until
				(pq_1.p.value / pq_1.q.value) ≤ (pq_2.p.value / pq_2.q.value)
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("pq_1 ≤ pq_2", pq_1 ≤ pq_2)
			assert ("pq_1 ≤ pq_2 ok", is_less_equal_ok (pq_1, pq_2, some_rational_number))

			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			invariant
					-- {STS_RATIONAL_NUMBER} invariant
				good_divisor_1: pq_1.q.value /= 0
				good_divisor_2: pq_2.q.value /= 0
			until
				(pq_1.p.value / pq_1.q.value) > (pq_2.p.value / pq_2.q.value)
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("not (pq_1 ≤ pq_2)", not (pq_1 ≤ pq_2))
			assert ("not (pq_1 ≤ pq_2) ok", is_less_equal_ok (pq_1, pq_2, some_rational_number))

			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			assert ("is_less_equal", pq_1 ≤ pq_2 ⇒ True)
			assert ("is_less_equal_ok", is_less_equal_ok (pq_1, pq_2, some_rational_number))
		end

	test_is_greater
			-- Test {STS_RATIONAL_NUMBER}.is_greater.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_greater"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			invariant
					-- {STS_RATIONAL_NUMBER} invariant
				good_divisor_1: pq_1.q.value /= 0
				good_divisor_2: pq_2.q.value /= 0
			until
				(pq_1.p.value / pq_1.q.value) > (pq_2.p.value / pq_2.q.value)
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("pq_1 > pq_2", pq_1 > pq_2)
			assert ("pq_1 > pq_2 ok", is_greater_ok (pq_1, pq_2, some_rational_number))

			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			invariant
					-- {STS_RATIONAL_NUMBER} invariant
				good_divisor_1: pq_1.q.value /= 0
				good_divisor_2: pq_2.q.value /= 0
			until
				(pq_1.p.value / pq_1.q.value) ≤ (pq_2.p.value / pq_2.q.value)
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("not (pq_1 > pq_2)", not (pq_1 > pq_2))
			assert ("not (pq_1 > pq_2) ok", is_greater_ok (pq_1, pq_2, some_rational_number))

			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			assert ("is_greater", pq_1 > pq_2 ⇒ True)
			assert ("is_greater ok", is_greater_ok (pq_1, pq_2, some_rational_number))
		end

	test_is_greater_equal
			-- Test {STS_RATIONAL_NUMBER}.is_greater_equal.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.is_greater_equal"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			invariant
					-- {STS_RATIONAL_NUMBER} invariant
				good_divisor_1: pq_1.q.value /= 0
				good_divisor_2: pq_2.q.value /= 0
			until
				(pq_1.p.value / pq_1.q.value) ≥ (pq_2.p.value / pq_2.q.value)
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("pq_1 ≥ pq_2", pq_1 ≥ pq_2)
			assert ("pq_1 ≥ pq_2 ok", is_greater_equal_ok (pq_1, pq_2, some_rational_number))

			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			invariant
					-- {STS_RATIONAL_NUMBER} invariant
				good_divisor_1: pq_1.q.value /= 0
				good_divisor_2: pq_2.q.value /= 0
			until
				(pq_1.p.value / pq_1.q.value) < (pq_2.p.value / pq_2.q.value)
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("not (pq_1 ≥ pq_2)", not (pq_1 ≥ pq_2))
			assert ("not (pq_1 ≥ pq_2) ok", is_greater_equal_ok (pq_1, pq_2, some_rational_number))

			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			assert ("is_greater_equal", pq_1 ≥ pq_2 ⇒ True)
			assert ("is_greater_equal_ok", is_greater_equal_ok (pq_1, pq_2, some_rational_number))
		end

	test_three_way_comparison
			-- Test {STS_RATIONAL_NUMBER}.three_way_comparison.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.three_way_comparison"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			until
				pq_1 < pq_2
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("negative", pq_1 ⋚ pq_2 ≍ - pq_1.p.one)

			pq_1 := rational_number_to_be_tested
			assert ("same_entity", pq_1 ⋚ pq_1 ≍ pq_1.p.zero)
			assert ("same_rational_number", pq_1 ⋚ same_rational_number (pq_1) ≍ pq_1.p.zero)

			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			until
				pq_1 > pq_2
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("positive", pq_1 ⋚ pq_2 ≍ pq_1.p.one)

			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			assert ("three_way_comparison", attached (pq_1 ⋚ pq_2))
		end

	test_min
			-- Test {STS_RATIONAL_NUMBER}.min.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.min"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			until
				pq_1 ≤ pq_2
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("pq_1", (pq_1 ∧ pq_2) ≍ pq_1)
			assert ("pq_1 ok", min_ok (pq_1, pq_2, some_rational_number))

			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			until
				pq_1 ≥ pq_2
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("pq_2", (pq_1 ∧ pq_2) ≍ pq_2)
			assert ("pq_2 ok", min_ok (pq_1, pq_2, some_rational_number))

			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			assert ("min", attached (pq_1 ∧ pq_2))
			assert ("min ok", min_ok (pq_1, pq_2, some_rational_number))
		end

	test_max
			-- Test {STS_RATIONAL_NUMBER}.max.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.max"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			until
				pq_1 ≥ pq_2
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("pq_1", (pq_1 ∨ pq_2) ≍ pq_1)
			assert ("pq_1 ok", max_ok (pq_1, pq_2, some_rational_number))

			from
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			until
				pq_1 ≤ pq_2
			loop
				pq_1 := rational_number_to_be_tested
				pq_2 := some_rational_number
			end
			assert ("pq_2", (pq_1 ∨ pq_2) ≍ pq_2)
			assert ("pq_2 ok", max_ok (pq_1, pq_2, some_rational_number))

			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			assert ("max", attached (pq_1 ∨ pq_2))
			assert ("max ok", max_ok (pq_1, pq_2, some_rational_number))
		end

feature -- Test routines (Relationship)

	test_multipliable
			-- Test {STS_RATIONAL_NUMBER}.multipliable.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.multipliable"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			check
				good_divisor_1: pq_1.q.divisible (gcd (pq_2.p, pq_1.q)) -- pq_1.q /= 0
				good_divisor_2: pq_2.q.divisible (gcd (pq_1.p, pq_2.q)) -- pq_2.q /= 0
			end
			assert (
					"when does not overflow",
					not pq_1.integer_product_overflows (pq_1.q // gcd (pq_2.p, pq_1.q), pq_2.q // gcd (pq_1.p, pq_2.q)) ⇒ pq_1.multipliable (pq_2)
				)
			assert (
					"when is not multipliable",
					not pq_1.multipliable (pq_2) ⇒ pq_1.integer_product_overflows (pq_1.q // gcd (pq_2.p, pq_1.q), pq_2.q // gcd (pq_1.p, pq_2.q))
				)
			assert ("multipliable ok", multipliable_ok (pq_1, pq_2))
		end

	test_divisible
			-- Test {STS_RATIONAL_NUMBER}.divisible.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.divisible"
		local
			pq_1: like rational_number_to_be_tested
			pq_2: like some_rational_number
		do
			pq_1 := rational_number_to_be_tested
			pq_2 := some_rational_number
			check
				good_divisor_1: pq_1.q.divisible (gcd (pq_2.q, pq_1.q)) -- pq_1.q, pq_2.q /= 0
				good_divisor_2: pq_2 ≭ zero ⇒ pq_2.p.divisible (gcd (pq_1.p, pq_2.p)) -- pq_2.p /= 0 ⇐ pq_2 ≭ zero
			end
			assert (
					"when does not overflow",
					pq_2 ≭ zero and then not pq_1.integer_product_overflows (pq_1.q // gcd (pq_2.q, pq_1.q), pq_2.p // gcd (pq_1.p, pq_2.p)) ⇒
					pq_1.divisible (pq_2)
				)
			assert (
					"when is not divisible",
					not pq_1.divisible (pq_2) ⇒
					pq_2 ≍ zero or else pq_1.integer_product_overflows (pq_1.q // gcd (pq_2.q, pq_1.q), pq_2.p // gcd (pq_1.p, pq_2.p))
				)
		end

feature -- Test routines (Operation)

	test_reciprocal
			-- Test {STS_RATIONAL_NUMBER}.reciprocal.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.reciprocal"
		local
			pq: like rational_number_to_be_tested
		do
			pq := rational_number_to_be_tested
			assert ("reciprocal", pq.is_invertible ⇒ attached pq.reciprocal)
		end

	test_inverse
			-- Test {STS_RATIONAL_NUMBER}.inverse.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.inverse"
		local
			pq: like rational_number_to_be_tested
		do
			pq := rational_number_to_be_tested
			assert ("inverse", pq.is_invertible ⇒ attached pq.inverse)
		end

feature -- Test routines (Math)

	test_gcd
			-- Test gcd.
		note
			testing: "covers/gcd"
		local
			pq: like rational_number_to_be_tested
			i, j: like some_integer_number
		do
			i := some_integer_number
			j := some_integer_number
			pq := rational_number_to_be_tested
			assert ("gcd", attached pq.gcd (i, j))
			assert ("gcd_ok", gcd_ok (pq, i, j, some_integer_number))
		end

	test_div
			-- Test {STS_RATIONAL_NUMBER}.div.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.div"
		local
			i, j: like some_integer_number
		do
			i := some_integer_number
			from
				j := some_integer_number
			until
				i.divisible (j)
			loop
				j := some_integer_number
			end
			assert ("div", attached rational_number_to_be_tested.div (i, j))
		end

	test_rem
			-- Test {STS_RATIONAL_NUMBER}.rem.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.rem"
		local
			pq: like rational_number_to_be_tested
			i, j: like some_integer_number
		do
			pq := rational_number_to_be_tested
			i := some_integer_number
			from
				j := some_integer_number
			until
				i.divisible (j)
			loop
				j := some_integer_number
			end
			assert ("rem", attached pq.rem (i, j))
			assert ("rem ok", rem_ok (pq, i, j))
		end

feature -- Test routines (Factory)

	test_converted_integer
			-- Test {STS_RATIONAL_NUMBER}.converted_integer.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.converted_integer"
		do
			assert ("converted_integer", attached rational_number_to_be_tested.converted_integer (some_integer_number))
		end

feature -- Test routines (Predicate)

	test_integer_product_overflows
			-- Test {STS_RATIONAL_NUMBER}.integer_product_overflows.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}.integer_product_overflows"
		local
			pq: like rational_number_to_be_tested
			i, j: like some_integer_number
		do
			pq := rational_number_to_be_tested
			i := - some_integer_number.abs
			i := i ∧ - i.one
			j := - some_integer_number.abs ∧ - i.one
			if i.max_value_exists then
				check
					good_divisor_1: i.max_value.divisible (j) -- j < 0
				end
				i := i ∧ i.max_value // j - i.one
				assert ("i, j < 0; overflow", pq.integer_product_overflows (i, j))
				assert ("i, j < 0; overflow ok", integer_product_overflows_ok (pq, i, j))
			end

			j := some_integer_number.abs ∨ j.one
			if i.min_value_exists then
				check
					good_divisor_2: i.min_value.divisible (j) -- j > 0
				end
				i := i ∧ i.min_value // j - i.one
				assert ("i < 0 < j; overflow", pq.integer_product_overflows (i, j))
				assert ("i < 0 < j; overflow ok", integer_product_overflows_ok (pq, i, j))
			end

			i := some_integer_number.abs ∨ i.one
			j := - some_integer_number.abs ∧ - i.one - i.one
			if i.min_value_exists then
				check
					good_divisor_3: i.min_value.divisible (j) -- j < 0
				end
				i := i ∨ i.min_value // j + i.one
				assert ("j < - 1 < 0 < i; overflow", pq.integer_product_overflows (i, j))
				assert ("j < - 1 < 0 < i; overflow ok", integer_product_overflows_ok (pq, i, j))
			end

			j := some_integer_number.abs ∨ j.one
			if i.max_value_exists then
				check
					good_divisor_4: i.max_value.divisible (j) -- j > 0
				end
				i := i ∨ i.max_value // j + i.one
				assert ("0 < i, j; overflow", pq.integer_product_overflows (i, j))
				assert ("0 < i, j; overflow ok", integer_product_overflows_ok (pq, i, j))
			end

			i := - some_integer_number.abs ∧ - i.one
			j := - some_integer_number.abs ∧ - i.one
			if i.max_value_exists then
				check
					good_divisor_5: i.max_value.divisible (j) -- j < 0
				end
				i := i ∨ i.max_value // j
				assert ("i, j < 0; no overflow", not pq.integer_product_overflows (i, j))
				assert ("i, j < 0; no overflow ok", integer_product_overflows_ok (pq, i, j))
			end

			j := j.zero
			assert ("i < 0 = j; no overflow", not pq.integer_product_overflows (i, j))
			assert ("i < 0 = j; no overflow ok", integer_product_overflows_ok (pq, i, j))

			j := some_integer_number.abs ∨ j.one
			if i.min_value_exists then
				check
					good_divisor_6: i.min_value.divisible (j) -- j > 0
				end
				i := i ∨ i.min_value // j
				assert ("i < 0 < j; no overflow", not pq.integer_product_overflows (i, j))
				assert ("i < 0 < j; no overflow ok", integer_product_overflows_ok (pq, i, j))
			end

			i := i.zero
			j := some_integer_number
			assert ("i = 0; no overflow", not pq.integer_product_overflows (i, j))
			assert ("i = 0; no overflow ok", integer_product_overflows_ok (pq, i, j))

			i := some_integer_number.abs ∨ i.one
			j := - some_integer_number.abs ∧ - i.one - i.one
			if i.min_value_exists then
				check
					good_divisor_7: i.min_value.divisible (j) -- j < 0
				end
				i := i ∧ i.min_value // j
				assert ("j < - 1 < 0 < i; no overflow", not pq.integer_product_overflows (i, j))
				assert ("j < - 1 < 0 < i; no overflow ok", integer_product_overflows_ok (pq, i, j))
			end

			j := - j.one
			assert ("- 1 = j < 0 < i; no overflow", not pq.integer_product_overflows (i, j))
			assert ("- 1 = j < 0 < i; no overflow ok", integer_product_overflows_ok (pq, i, j))

			j := j.zero
			assert ("j = 0 < i; no overflow", not pq.integer_product_overflows (i, j))
			assert ("j = 0 < i; no overflow ok", integer_product_overflows_ok (pq, i, j))

			j := some_integer_number.abs ∨ j.one
			if i.max_value_exists then
				check
					good_divisor_8: i.max_value.divisible (j) -- j > 0
				end
				i := i ∧ i.max_value // j
				assert ("0 < i, j; no overflow", not pq.integer_product_overflows (i, j))
				assert ("0 < i, j; no overflow ok", integer_product_overflows_ok (pq, i, j))
			end

			i := some_integer_number
			j := some_integer_number
			pq := rational_number_to_be_tested
			assert ("product_overflows", pq.integer_product_overflows (i, j) ⇒ True)
			assert ("integer_product_overflows_ok", integer_product_overflows_ok (pq, i, j))
		end

feature {NONE} -- Factory (element to be tested)

	rational_number_to_be_tested: like some_immediate_rational_number
			-- Rational number meant to be under tests
		do
			Result := some_immediate_rational_number
		end

feature -- Anchor

	rational_anchor: STS_RATIONAL_NUMBER
			-- Anchor for rational numbers
		deferred
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end

note
	description: "Test suite for {STS_REAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	REAL_NUMBER_TESTS

inherit
	ELEMENT_TESTS
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as real_number_to_be_tested
		redefine
			test_all,
			real_number_to_be_tested
		end

	REAL_NUMBER_PROPERTIES

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_REAL_NUMBER}.
		note
			testing: "covers/{STS_REAL_NUMBER}"
		do
			Precursor {ELEMENT_TESTS}
			test_value
			test_is_in
			test_is_not_in
			test_sign
			test_zero
			test_one
			test_is_nan
			test_is_negative_infinity
--			test_is_integer
--			test_is_natural
--			test_is_invertible
--			test_equals
--			test_unequals
--			test_is_less
--			test_is_less_equal
--			test_is_greater
--			test_is_greater_equal
--			test_three_way_comparison
--			test_multipliable
--			test_divisible
--			test_min
--			test_max
--			test_modulus
--			test_abs
--			test_plus
--			test_minus
--			test_opposite
--			test_product
--			test_quotient
--			test_reciprocal
--			test_inverse
--			test_to_integer_number
--			test_to_natural_number
--			test_converted_integer
--			test_gcd
--			test_div
--			test_rem
--			test_integer_product_overflows
			test_adjusted_value
		end

feature -- Test routines (Primitive)

	test_value
			-- Test {STS_REAL_NUMBER}.value.
		note
			testing: "covers/{STS_REAL_NUMBER}.value"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("value", attached x.value)
		end

feature -- Test routines (Membership)

	test_is_in
			-- Test {STS_REAL_NUMBER}.is_in.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_in"
		local
			x: like real_number_to_be_tested
			s: like some_set_r
		do
			x := real_number_to_be_tested
			s := some_set_r.extended (x, some_equality_r)
			assert ("x ∈ s", x ∈ s)

			x := real_number_to_be_tested
			s := some_set_r.prunned (x)
			assert ("not (x ∈ s)", not (x ∈ s))

			x := real_number_to_be_tested
			s := some_set_r
			assert ("is_in", x ∈ s ⇒ True)
		end

	test_is_not_in
			-- Test {STS_REAL_NUMBER}.is_not_in.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_not_in"
		local
			x: like real_number_to_be_tested
			s: like some_set_r
		do
			x := real_number_to_be_tested
			s := some_set_r.prunned (x)
			assert ("x ∉ s", x ∉ s)
			assert ("x ∉ s ok", is_not_in_ok (x, s))

			x := real_number_to_be_tested
			s := some_set_r.extended (x, some_equality_r)
			assert ("not (x ∉ s)", not (x ∉ s))
			assert ("not (x ∉ s) ok", is_not_in_ok (x, s))

			x := real_number_to_be_tested
			s := some_set_r
			assert ("is_not_in", x ∉ s ⇒ True)
			assert ("is_not_in_ok", is_not_in_ok (x, s))
		end

feature -- Test routines (Access)

	test_sign
			-- Test {STS_REAL_NUMBER}.sign.
		note
			testing: "covers/{STS_REAL_NUMBER}.sign"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("x.sign", attached x.sign)

			from
				x := real_number_to_be_tested
			until
				x < Zero
			loop
				x := real_number_to_be_tested
			end
			assert ("negative", x.sign.real_value = - One.value)

			from
				x := real_number_to_be_tested
			until
				x > Zero
			loop
				x := real_number_to_be_tested
			end
			assert ("positive", x.sign.real_value = One.value)
		end

	test_zero
			-- Test {STS_REAL_NUMBER}.zero.
		note
			testing: "covers/{STS_REAL_NUMBER}.zero"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("zero", attached x.Zero)
		end

	test_one
			-- Test {STS_REAL_NUMBER}.one.
		note
			testing: "covers/{STS_REAL_NUMBER}.one"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("one", attached x.One)
			assert ("One ok", one_ok (x, some_real_number))

			assert ("0", one_ok (Zero, some_real_number))
		end

feature -- Test routines (Quality)

	test_is_nan
			-- Test {STS_REAL_NUMBER}.is_nan.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_nan"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("is_nan", x.is_nan ⇒ True)
			assert ("is_nan ok", is_nan_ok (x, some_real_number))

			from
				x := real_number_to_be_tested
			until
				x < Zero
			loop
				x := real_number_to_be_tested
			end
			x := x.real_from_value ({like real_math_anchor}.log (x.value))
			assert ("log (x).is_nan", x.is_nan)
			assert ("log (x).is_nan ok", is_nan_ok (x, some_real_number))

			from
				x := real_number_to_be_tested
			until
				x < Zero
			loop
				x := real_number_to_be_tested
			end
			x := x.real_from_value ({like real_math_anchor}.log10 (x.value))
			assert ("log10 (x).is_nan", x.is_nan)
			assert ("log10 (x).is_nan ok", is_nan_ok (x, some_real_number))

			from
				x := real_number_to_be_tested
			until
				x < Zero
			loop
				x := real_number_to_be_tested
			end
			x := x.real_from_value ({like real_math_anchor}.log_2 (x.value))
			assert ("log_2 (x).is_nan", x.is_nan)
			assert ("log_2 (x).is_nan ok", is_nan_ok (x, some_real_number))

			assert ("not zero.is_nan", not zero.is_nan)
			assert ("not zero.is_nan ok", is_nan_ok (Zero, some_real_number))

			assert ("not one.is_nan", not one.is_nan)
			assert ("not one.is_nan ok", is_nan_ok (one, some_real_number))
		end

	test_is_negative_infinity
			-- Test {STS_REAL_NUMBER}.is_negative_infinity.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_negative_infinity"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("is_negative_infinity", x.is_negative_infinity ⇒ True)
			assert ("is_negative_infinity ok", is_negative_infinity_ok (x, some_real_number))

			assert ("0", is_negative_infinity_ok (Zero, some_real_number))
			assert ("0 ok", is_negative_infinity_ok (Zero, some_real_number))

			assert ("is_negative_infinity_ok", is_negative_infinity_ok (real_number_to_be_tested, some_real_number))
		end

--	test_is_integer
--			-- Test {STS_REAL_NUMBER}.is_integer.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_integer"
--		local
--			x: like real_number_to_be_tested
--		do
--			from
--				x := real_number_to_be_tested
--			until
--				(x.p \\ x.q) ≍ zero.p
--			loop
--				x := real_number_to_be_tested
--			end
--			assert ("x.is_integer", x.is_integer)

--			from
--				x := real_number_to_be_tested
--				check
--					good_divisor: x.q ≭ zero.p -- {STS_REAL_NUMBER} invariant
--				end
--			until
--				(x.p \\ x.q) ≭ zero.p
--			loop
--				x := real_number_to_be_tested
--				check
--					good_divisor: x.q ≭ zero.p -- {STS_REAL_NUMBER} invariant
--				end
--			end
--			assert ("not x.is_integer", not x.is_integer)

--			x := real_number_to_be_tested
--			assert ("is_integer", x.is_integer ⇒ True)
--		end

--	test_is_natural
--			-- Test {STS_REAL_NUMBER}.is_natural.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_natural"
--		local
--			x: like real_number_to_be_tested
--		do
--			from
--				x := real_number_to_be_tested
--			until
--				x < zero
--			loop
--				x := real_number_to_be_tested
--			end
--			assert ("not x.is_natural", not x.is_natural)

--			from
--				x := real_number_to_be_tested
--			until
--				zero ≤ x and x.q | x.p
--			loop
--				x := real_number_to_be_tested
--			end
--			assert ("x.is_natural", x.is_natural)

--			x := real_number_to_be_tested
--			assert ("is_natural", x.is_natural ⇒ True)
--		end

--	test_is_invertible
--			-- Test {STS_REAL_NUMBER}.is_invertible.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_invertible"
--		local
--			x: like real_number_to_be_tested
--		do
--			from
--				x := real_number_to_be_tested
--			until
--				x.p ≭ zero.p
--			loop
--				x := real_number_to_be_tested
--			end
--			assert ("x.is_invertible", x.is_invertible)

--			x := Zero
--			assert ("not x.is_invertible", not x.is_invertible)

--			x := real_number_to_be_tested
--			assert ("is_invertible", x.is_invertible ⇒ True)
--		end

--feature -- Test routines (Comparison)

--	test_equals
--			-- Test {STS_REAL_NUMBER}.equals.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.equals"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			pq_1 := real_number_to_be_tested
--			assert ("same_entity", pq_1 ≍ pq_1)
--			assert ("same_entity_ok", equals_ok (pq_1, pq_1, pq_1))

--			pq_1 := real_number_to_be_tested
--			pq_2 := same_real_number (pq_1)
--			assert ("same_real", pq_1 ≍ pq_2)
--			assert ("same_real_ok", equals_ok (pq_1, pq_2, same_real_number (pq_2)))

--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			assert ("some_real_number", pq_1 ≍ pq_2 ⇒ True)
--			assert ("equals_ok", equals_ok (pq_1, pq_2, some_real_number))
--		end

--	test_unequals
--			-- Test {STS_REAL_NUMBER}.unequals.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.unequals"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			pq_1 := real_number_to_be_tested
--			from
--				pq_2 := some_real_number
--			until
--				not (pq_1 ≍ pq_2)
--			loop
--				pq_2 := some_real_number
--			end
--			assert ("pq_1 ≭ pq_2", pq_1 ≭ pq_2)
--			assert ("pq_1 ≭ pq_2 ok", unequals_ok (pq_1))

--			pq_1 := real_number_to_be_tested
--			pq_2 := same_real_number (pq_1)
--			assert ("not (pq_1 ≭ pq_2)", not (pq_1 ≭ pq_2))
--			assert ("not (pq_1 ≭ pq_2) ok", unequals_ok (pq_1))

--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			assert ("unequals", pq_1 ≭ pq_2 ⇒ True)
--			assert ("unequals ok", unequals_ok (pq_1))
--		end

--	test_is_less
--			-- Test {STS_REAL_NUMBER}.is_less.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_less"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			invariant
--					-- {STS_REAL_NUMBER} invariant
--				good_divisor_1: pq_1.q.value /= 0
--				good_divisor_2: pq_2.q.value /= 0
--			until
--				(pq_1.p.value / pq_1.q.value) < (pq_2.p.value / pq_2.q.value)
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("pq_1 < pq_2", pq_1 < pq_2)
--			assert ("pq_1 < pq_2 ok", is_less_ok (pq_1, pq_2, some_real_number))

--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			invariant
--					-- {STS_REAL_NUMBER} invariant
--				good_divisor_1: pq_1.q.value /= 0
--				good_divisor_2: pq_2.q.value /= 0
--			until
--				(pq_1.p.value / pq_1.q.value) ≥ (pq_2.p.value / pq_2.q.value)
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("not (pq_1 < pq_2)", not (pq_1 < pq_2))
--			assert ("not (pq_1 < pq_2) ok", is_less_ok (pq_1, pq_2, some_real_number))

--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			assert ("is_less", pq_1 < pq_2 ⇒ True)
--			assert ("is_less ok", is_less_ok (pq_1, pq_2, some_real_number))
--		end

--	test_is_less_equal
--			-- Test {STS_REAL_NUMBER}.is_less_equal.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_less_equal"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			invariant
--					-- {STS_REAL_NUMBER} invariant
--				good_divisor_1: pq_1.q.value /= 0
--				good_divisor_2: pq_2.q.value /= 0
--			until
--				(pq_1.p.value / pq_1.q.value) ≤ (pq_2.p.value / pq_2.q.value)
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("pq_1 ≤ pq_2", pq_1 ≤ pq_2)
--			assert ("pq_1 ≤ pq_2 ok", is_less_equal_ok (pq_1, pq_2, some_real_number))

--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			invariant
--					-- {STS_REAL_NUMBER} invariant
--				good_divisor_1: pq_1.q.value /= 0
--				good_divisor_2: pq_2.q.value /= 0
--			until
--				(pq_1.p.value / pq_1.q.value) > (pq_2.p.value / pq_2.q.value)
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("not (pq_1 ≤ pq_2)", not (pq_1 ≤ pq_2))
--			assert ("not (pq_1 ≤ pq_2) ok", is_less_equal_ok (pq_1, pq_2, some_real_number))

--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			assert ("is_less_equal", pq_1 ≤ pq_2 ⇒ True)
--			assert ("is_less_equal_ok", is_less_equal_ok (pq_1, pq_2, some_real_number))
--		end

--	test_is_greater
--			-- Test {STS_REAL_NUMBER}.is_greater.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_greater"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			invariant
--					-- {STS_REAL_NUMBER} invariant
--				good_divisor_1: pq_1.q.value /= 0
--				good_divisor_2: pq_2.q.value /= 0
--			until
--				(pq_1.p.value / pq_1.q.value) > (pq_2.p.value / pq_2.q.value)
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("pq_1 > pq_2", pq_1 > pq_2)
--			assert ("pq_1 > pq_2 ok", is_greater_ok (pq_1, pq_2, some_real_number))

--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			invariant
--					-- {STS_REAL_NUMBER} invariant
--				good_divisor_1: pq_1.q.value /= 0
--				good_divisor_2: pq_2.q.value /= 0
--			until
--				(pq_1.p.value / pq_1.q.value) ≤ (pq_2.p.value / pq_2.q.value)
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("not (pq_1 > pq_2)", not (pq_1 > pq_2))
--			assert ("not (pq_1 > pq_2) ok", is_greater_ok (pq_1, pq_2, some_real_number))

--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			assert ("is_greater", pq_1 > pq_2 ⇒ True)
--			assert ("is_greater ok", is_greater_ok (pq_1, pq_2, some_real_number))
--		end

--	test_is_greater_equal
--			-- Test {STS_REAL_NUMBER}.is_greater_equal.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_greater_equal"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			invariant
--					-- {STS_REAL_NUMBER} invariant
--				good_divisor_1: pq_1.q.value /= 0
--				good_divisor_2: pq_2.q.value /= 0
--			until
--				(pq_1.p.value / pq_1.q.value) ≥ (pq_2.p.value / pq_2.q.value)
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("pq_1 ≥ pq_2", pq_1 ≥ pq_2)
--			assert ("pq_1 ≥ pq_2 ok", is_greater_equal_ok (pq_1, pq_2, some_real_number))

--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			invariant
--					-- {STS_REAL_NUMBER} invariant
--				good_divisor_1: pq_1.q.value /= 0
--				good_divisor_2: pq_2.q.value /= 0
--			until
--				(pq_1.p.value / pq_1.q.value) < (pq_2.p.value / pq_2.q.value)
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("not (pq_1 ≥ pq_2)", not (pq_1 ≥ pq_2))
--			assert ("not (pq_1 ≥ pq_2) ok", is_greater_equal_ok (pq_1, pq_2, some_real_number))

--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			assert ("is_greater_equal", pq_1 ≥ pq_2 ⇒ True)
--			assert ("is_greater_equal_ok", is_greater_equal_ok (pq_1, pq_2, some_real_number))
--		end

--	test_three_way_comparison
--			-- Test {STS_REAL_NUMBER}.three_way_comparison.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.three_way_comparison"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			until
--				pq_1 < pq_2
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("negative", pq_1 ⋚ pq_2 ≍ - pq_1.p.one)

--			pq_1 := real_number_to_be_tested
--			assert ("same_entity", pq_1 ⋚ pq_1 ≍ pq_1.p.zero)
--			assert ("same_real_number", pq_1 ⋚ same_real_number (pq_1) ≍ pq_1.p.zero)

--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			until
--				pq_1 > pq_2
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("positive", pq_1 ⋚ pq_2 ≍ pq_1.p.one)

--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			assert ("three_way_comparison", attached (pq_1 ⋚ pq_2))
--		end

--	test_min
--			-- Test {STS_REAL_NUMBER}.min.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.min"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			until
--				pq_1 ≤ pq_2
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("pq_1", (pq_1 ∧ pq_2) ≍ pq_1)
--			assert ("pq_1 ok", min_ok (pq_1, pq_2, some_real_number))

--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			until
--				pq_1 ≥ pq_2
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("pq_2", (pq_1 ∧ pq_2) ≍ pq_2)
--			assert ("pq_2 ok", min_ok (pq_1, pq_2, some_real_number))

--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			assert ("min", attached (pq_1 ∧ pq_2))
--			assert ("min ok", min_ok (pq_1, pq_2, some_real_number))
--		end

--	test_max
--			-- Test {STS_REAL_NUMBER}.max.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.max"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			until
--				pq_1 ≥ pq_2
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("pq_1", (pq_1 ∨ pq_2) ≍ pq_1)
--			assert ("pq_1 ok", max_ok (pq_1, pq_2, some_real_number))

--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			until
--				pq_1 ≤ pq_2
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("pq_2", (pq_1 ∨ pq_2) ≍ pq_2)
--			assert ("pq_2 ok", max_ok (pq_1, pq_2, some_real_number))

--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			assert ("max", attached (pq_1 ∨ pq_2))
--			assert ("max ok", max_ok (pq_1, pq_2, some_real_number))
--		end

--feature -- Test routines (Relationship)

--	test_multipliable
--			-- Test {STS_REAL_NUMBER}.multipliable.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.multipliable"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			check
--				good_divisor_1: pq_1.q.divisible (gcd (pq_2.p, pq_1.q)) -- pq_1.q /= 0
--				good_divisor_2: pq_2.q.divisible (gcd (pq_1.p, pq_2.q)) -- pq_2.q /= 0
--			end
--			assert (
--					"when does not overflow",
--					not pq_1.integer_product_overflows (pq_1.q // gcd (pq_2.p, pq_1.q), pq_2.q // gcd (pq_1.p, pq_2.q)) ⇒ pq_1.multipliable (pq_2)
--				)
--			assert (
--					"when is not multipliable",
--					not pq_1.multipliable (pq_2) ⇒ pq_1.integer_product_overflows (pq_1.q // gcd (pq_2.p, pq_1.q), pq_2.q // gcd (pq_1.p, pq_2.q))
--				)
--			assert ("multipliable ok", multipliable_ok (pq_1, pq_2))
--		end

--	test_divisible
--			-- Test {STS_REAL_NUMBER}.divisible.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.divisible"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			check
--				good_divisor_1: pq_1.q.divisible (gcd (pq_2.q, pq_1.q)) -- pq_1.q, pq_2.q /= 0
--				good_divisor_2: pq_2 ≭ zero ⇒ pq_2.p.divisible (gcd (pq_1.p, pq_2.p)) -- pq_2.p /= 0 ⇐ pq_2 ≭ zero
--			end
--			assert (
--					"when does not overflow",
--					pq_2 ≭ zero and then not pq_1.integer_product_overflows (pq_1.q // gcd (pq_2.q, pq_1.q), pq_2.p // gcd (pq_1.p, pq_2.p)) ⇒
--					pq_1.divisible (pq_2)
--				)
--			assert (
--					"when is not divisible",
--					not pq_1.divisible (pq_2) ⇒
--					pq_2 ≍ zero or else pq_1.integer_product_overflows (pq_1.q // gcd (pq_2.q, pq_1.q), pq_2.p // gcd (pq_1.p, pq_2.p))
--				)
--		end

--feature -- Test routines (Operation)

--	test_modulus
--			-- Test {STS_REAL_NUMBER}.modulus.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.modulus"
--		do
--			assert ("modulus", attached real_number_to_be_tested.modulus)
--		end

--	test_abs
--			-- Test {STS_REAL_NUMBER}.abs.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.abs"
--		do
--			assert ("abs", attached real_number_to_be_tested.abs)
--		end

--	test_plus
--			-- Test {STS_REAL_NUMBER}.plus.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.plus"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			assert ("plus", attached (pq_1 + pq_2))
--			assert ("plus_ok", plus_ok (pq_1, pq_2))
--		end

--	test_minus
--			-- Test {STS_REAL_NUMBER}.minus.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.minus"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			assert ("minus", attached (pq_1 - pq_2))
--			assert ("minus_ok", minus_ok (pq_1, pq_2))
--		end

--	test_opposite
--			-- Test {STS_REAL_NUMBER}.opposite.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.opposite"
--		local
--			x: like real_number_to_be_tested
--		do
--			x := real_number_to_be_tested
--			assert ("opposite", attached (- x))
--			assert ("opposite_ok", opposite_ok (x))
--		end

--	test_product
--			-- Test {STS_REAL_NUMBER}.product.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.product"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			until
--				pq_1.multipliable (pq_2)
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("product", attached (pq_1 * pq_2))
--			assert ("product_ok", product_ok (pq_1, pq_2))
--		end

--	test_quotient
--			-- Test {STS_REAL_NUMBER}.quotient.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.quotient"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			from
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			until
--				pq_1.divisible (pq_2)
--			loop
--				pq_1 := real_number_to_be_tested
--				pq_2 := some_real_number
--			end
--			assert ("quotient", attached (pq_1 / pq_2))
--			assert ("quotient_ok", quotient_ok (pq_1))
--		end

--	test_reciprocal
--			-- Test {STS_REAL_NUMBER}.reciprocal.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.reciprocal"
--		local
--			x: like real_number_to_be_tested
--		do
--			x := real_number_to_be_tested
--			assert ("reciprocal", x.is_invertible ⇒ attached x.reciprocal)
--		end

--	test_inverse
--			-- Test {STS_REAL_NUMBER}.inverse.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.inverse"
--		local
--			x: like real_number_to_be_tested
--		do
--			x := real_number_to_be_tested
--			assert ("inverse", x.is_invertible ⇒ attached x.inverse)
--		end

--feature -- Test routines (Conversion)

--	test_to_integer_number
--			-- Test {STS_REAL_NUMBER}.to_integer_number.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.to_integer_number"
--		local
--			x: like real_number_to_be_tested
--		do
--			x := real_number_to_be_tested
--			assert ("to_integer_number", x.is_integer ⇒ attached x.to_integer_number)
--		end

--	test_to_natural_number
--			-- Test {STS_REAL_NUMBER}.to_natural_number.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.to_natural_number"
--		local
--			x: like real_number_to_be_tested
--		do
--			x := real_number_to_be_tested
--			assert ("to_natural_number", x.is_natural ⇒ attached x.to_natural_number)
--		end

--feature -- Test routines (Factory)

--	test_converted_integer
--			-- Test {STS_REAL_NUMBER}.converted_integer.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.converted_integer"
--		do
--			assert ("converted_integer", attached real_number_to_be_tested.converted_integer (some_integer_number))
--		end

--feature -- Test routines (Math)

--	test_gcd
--			-- Test gcd.
--		note
--			testing: "covers/gcd"
--		local
--			x: like real_number_to_be_tested
--			i, j: like some_integer_number
--		do
--			i := some_integer_number
--			j := some_integer_number
--			x := real_number_to_be_tested
--			assert ("gcd", attached x.gcd (i, j))
--			assert ("gcd_ok", gcd_ok (x, i, j, some_integer_number))
--		end

--	test_div
--			-- Test {STS_REAL_NUMBER}.div.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.div"
--		local
--			i, j: like some_integer_number
--		do
--			i := some_integer_number
--			from
--				j := some_integer_number
--			until
--				i.divisible (j)
--			loop
--				j := some_integer_number
--			end
--			assert ("div", attached real_number_to_be_tested.div (i, j))
--		end

--	test_rem
--			-- Test {STS_REAL_NUMBER}.rem.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.rem"
--		local
--			x: like real_number_to_be_tested
--			i, j: like some_integer_number
--		do
--			x := real_number_to_be_tested
--			i := some_integer_number
--			from
--				j := some_integer_number
--			until
--				i.divisible (j)
--			loop
--				j := some_integer_number
--			end
--			assert ("rem", attached x.rem (i, j))
--			assert ("rem ok", rem_ok (x, i, j))
--		end

--feature -- Test routines (Predicate)

--	test_integer_product_overflows
--			-- Test {STS_REAL_NUMBER}.integer_product_overflows.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.integer_product_overflows"
--		local
--			x: like real_number_to_be_tested
--			i, j: like some_integer_number
--		do
--			x := real_number_to_be_tested
--			i := - some_integer_number.abs
--			i := i ∧ - i.one
--			j := - some_integer_number.abs ∧ - i.one
--			if i.max_value_exists then
--				check
--					good_divisor_1: i.max_value.divisible (j) -- j < 0
--				end
--				i := i ∧ i.max_value // j - i.one
--				assert ("i, j < 0; overflow", x.integer_product_overflows (i, j))
--				assert ("i, j < 0; overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			j := some_integer_number.abs ∨ j.one
--			if i.min_value_exists then
--				check
--					good_divisor_2: i.min_value.divisible (j) -- j > 0
--				end
--				i := i ∧ i.min_value // j - i.one
--				assert ("i < 0 < j; overflow", x.integer_product_overflows (i, j))
--				assert ("i < 0 < j; overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			i := some_integer_number.abs ∨ i.one
--			j := - some_integer_number.abs ∧ - i.one - i.one
--			if i.min_value_exists then
--				check
--					good_divisor_3: i.min_value.divisible (j) -- j < 0
--				end
--				i := i ∨ i.min_value // j + i.one
--				assert ("j < - 1 < 0 < i; overflow", x.integer_product_overflows (i, j))
--				assert ("j < - 1 < 0 < i; overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			j := some_integer_number.abs ∨ j.one
--			if i.max_value_exists then
--				check
--					good_divisor_4: i.max_value.divisible (j) -- j > 0
--				end
--				i := i ∨ i.max_value // j + i.one
--				assert ("0 < i, j; overflow", x.integer_product_overflows (i, j))
--				assert ("0 < i, j; overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			i := - some_integer_number.abs ∧ - i.one
--			j := - some_integer_number.abs ∧ - i.one
--			if i.max_value_exists then
--				check
--					good_divisor_5: i.max_value.divisible (j) -- j < 0
--				end
--				i := i ∨ i.max_value // j
--				assert ("i, j < 0; no overflow", not x.integer_product_overflows (i, j))
--				assert ("i, j < 0; no overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			j := j.zero
--			assert ("i < 0 = j; no overflow", not x.integer_product_overflows (i, j))
--			assert ("i < 0 = j; no overflow ok", integer_product_overflows_ok (x, i, j))

--			j := some_integer_number.abs ∨ j.one
--			if i.min_value_exists then
--				check
--					good_divisor_6: i.min_value.divisible (j) -- j > 0
--				end
--				i := i ∨ i.min_value // j
--				assert ("i < 0 < j; no overflow", not x.integer_product_overflows (i, j))
--				assert ("i < 0 < j; no overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			i := i.zero
--			j := some_integer_number
--			assert ("i = 0; no overflow", not x.integer_product_overflows (i, j))
--			assert ("i = 0; no overflow ok", integer_product_overflows_ok (x, i, j))

--			i := some_integer_number.abs ∨ i.one
--			j := - some_integer_number.abs ∧ - i.one - i.one
--			if i.min_value_exists then
--				check
--					good_divisor_7: i.min_value.divisible (j) -- j < 0
--				end
--				i := i ∧ i.min_value // j
--				assert ("j < - 1 < 0 < i; no overflow", not x.integer_product_overflows (i, j))
--				assert ("j < - 1 < 0 < i; no overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			j := - j.one
--			assert ("- 1 = j < 0 < i; no overflow", not x.integer_product_overflows (i, j))
--			assert ("- 1 = j < 0 < i; no overflow ok", integer_product_overflows_ok (x, i, j))

--			j := j.zero
--			assert ("j = 0 < i; no overflow", not x.integer_product_overflows (i, j))
--			assert ("j = 0 < i; no overflow ok", integer_product_overflows_ok (x, i, j))

--			j := some_integer_number.abs ∨ j.one
--			if i.max_value_exists then
--				check
--					good_divisor_8: i.max_value.divisible (j) -- j > 0
--				end
--				i := i ∧ i.max_value // j
--				assert ("0 < i, j; no overflow", not x.integer_product_overflows (i, j))
--				assert ("0 < i, j; no overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			i := some_integer_number
--			j := some_integer_number
--			x := real_number_to_be_tested
--			assert ("product_overflows", x.integer_product_overflows (i, j) ⇒ True)
--			assert ("integer_product_overflows_ok", integer_product_overflows_ok (x, i, j))
--		end

feature -- Test routines (Implementation)

	test_adjusted_value
			-- Test {STS_REAL_NUMBER}.adjusted_value.
		note
			testing: "covers/{STS_REAL_NUMBER}.adjusted_value"
		do
			assert ("adjusted_value", attached real_number_to_be_tested.adjusted_value (some_native_real))
		end

feature {NONE} -- Factory (element to be tested)

	real_number_to_be_tested: like some_immediate_real_number
			-- Real number meant to be under tests
		do
			Result := some_immediate_real_number
		end

feature -- Anchor

	real_anchor: STS_REAL_NUMBER
			-- Anchor for real numbers
		deferred
		end

	real_math_anchor: like real_number_to_be_tested.real_math_anchor
			-- Anchor for accessing basic mathematical operations on native real numbers
		do
			Result := real_number_to_be_tested.real_math_anchor
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
